import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import '../utils/searchBar.dart';
import '../patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ortakoy_mosq.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  alignment: Alignment.center)),
        ),
        const SingleChildScrollView(child: ReportBody())
      ]),
    );
  }
}

class ReportDrawer extends StatefulWidget {
  const ReportDrawer({Key? key}) : super(key: key);

  @override
  State<ReportDrawer> createState() => _ReportDrawerState();
}

class _ReportDrawerState extends State<ReportDrawer> {
  @override
  Widget build(BuildContext context) {
    return customDrawer(context: context, pageName: PAGE.REPORT);
  }
}

class ReportBody extends StatefulWidget {
  const ReportBody({Key? key}) : super(key: key);

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  final HttpRequests httpReq = HttpRequests(Config.getSendReportURL());
  final GlobalKey<FormState> _reportKey = GlobalKey<FormState>();
  final TextEditingController _reportCategoryController =
      TextEditingController();
  final TextEditingController _reportContextController =
      TextEditingController();

  void sendReport() {
    if (_reportKey.currentState!.validate()) {
      print("report send");
      String reportCategory = _reportCategoryController.text;
      String reportContext = _reportContextController.text;

      Map<String, dynamic> reportInfo = {
        "Content": reportContext,
        "ReportTopic": reportCategory
      };

      httpReq.postRequest(reportInfo, header: true).then((response) {
        print(response['message']);
        if (response['statusCode'] == 200) {
          print("successfull");
          Fluttertoast.showToast(
              msg: "Report Send Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: CustomColors.darkPurple(),
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: ((context) => ReportPage())));
        } else if (response['statusCode'] == 400) {
          print("Failed");
          Fluttertoast.showToast(
              msg: response['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: CustomColors.darkPurple(),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _reportKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 50),
              TextFormField(
                validator: (value) =>
                    value!.length == 0 ? "Please Enter Report Category" : null,
                controller: _reportCategoryController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    fillColor: CustomColors.customGrey(),
                    filled: true,
                    labelText: "Report Category",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
                validator: (value) =>
                    value!.length == 0 ? "Please Enter Report Context" : null,
                controller: _reportContextController,
                decoration: InputDecoration(
                    fillColor: CustomColors.customGrey(),
                    filled: true,
                    labelText: "Report Context",
                    contentPadding: const EdgeInsets.only(
                        bottom: 100.0, top: 10.0, left: 10.0, right: 10.0),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
              ),
              const SizedBox(height: 15),
              Center(
                  child:
                      customButton(label: 'Send Report', onPressed: sendReport))
            ],
          ),
        ),
      ),
    );
  }
}
