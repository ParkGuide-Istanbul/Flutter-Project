import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';

import '../utils/ui_features.dart';

class ForgotPasswordEmailPage extends StatelessWidget {
  const ForgotPasswordEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          preLoginAppBar(label: 'Enter Your E-Mail Adress', context: context),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ortakoy_mosq.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  alignment: Alignment.center)),
        ),
        ForgotPasswordEmailStage()
      ]),
    );
  }
}

class ForgotPasswordEmailStage extends StatefulWidget {
  ForgotPasswordEmailStage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmailStage> createState() =>
      _ForgotPasswordEmailStageState();
}

class _ForgotPasswordEmailStageState extends State<ForgotPasswordEmailStage> {
  HttpRequests httpReq = HttpRequests(Config.getForgotPasswordURL());

  final _validationKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  RegExp _regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void _submit() {
    if (_validationKey.currentState!.validate()) {
      String email = _emailController.text;
      Map<String, dynamic> body = {"email": email};
      httpReq.postRequest(body).then((res) {
        if (res['statusCode'] == 200) {
          UsernameSingleton usernameSingleton = UsernameSingleton.getInstance();
          usernameSingleton.setUsername(username: res['username']);
          EmailSingleton emailSingleton = EmailSingleton.getInstance();
          emailSingleton.setEmail(email: email);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForgotPasswordCodePage()));
        } else {
          Fluttertoast.showToast(
              msg: res['message'],
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
    return SingleChildScrollView(
      reverse: true,
      child: Form(
        key: _validationKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 75),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
              child: TextFormField(
                validator: (email) =>
                    _regex.hasMatch(email!) && email.length != 0
                        ? null
                        : 'Please enter a valid email',
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            customButton(label: 'Submit', onPressed: _submit),
            Padding(padding: EdgeInsets.all(10))
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
class ForgotPasswordCodePage extends StatelessWidget {
  const ForgotPasswordCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          preLoginAppBar(label: 'Enter Verification Code', context: context),
      body: ForgotPasswordCodeStage(),
    );
  }
}

class ForgotPasswordCodeStage extends StatefulWidget {
  ForgotPasswordCodeStage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordCodeStage> createState() =>
      _ForgotPasswordCodeStageState();
}

class _ForgotPasswordCodeStageState extends State<ForgotPasswordCodeStage> {
  /*
    Here, there should be validation code coming from backend and the validation check should be here. 
  */
  String? codeValidator(code) {
    return null;
  }

  EmailSingleton? emailSingleton;
  String email = '';
  UsernameSingleton? usernameSingleton;
  String username = '';

  _ForgotPasswordCodeStageState() {
    emailSingleton = EmailSingleton.getInstance();
    email = emailSingleton!.getEmail();
    usernameSingleton = UsernameSingleton.getInstance();
    username = usernameSingleton!.getUsername();
  }
  final _codeValidationKey = GlobalKey<FormState>();
  TextEditingController _codeController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordRepeatController = new TextEditingController();

  void _submit() {
    if (_codeValidationKey.currentState!.validate()) {
      String validationCode = _codeController.text;
      print(validationCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Form(
        key: _codeValidationKey,
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
              child: TextFormField(
                validator: codeValidator,
                controller: _codeController,
                decoration: const InputDecoration(
                    labelText: "Verification Code",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
              child: TextFormField(
                validator: ((value) => value!.length >= 8
                    ? null
                    : "Password should have at least 8 characters."),
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: "New Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
              child: TextFormField(
                validator: (value) => value == _passwordController.text
                    ? null
                    : "Passwords do not match.",
                controller: _passwordRepeatController,
                decoration: const InputDecoration(
                    labelText: "New Password Repeat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 22),
            customButton(label: 'Submit', onPressed: _submit),
            Padding(padding: EdgeInsets.all(10))
          ],
        ),
      ),
    );
    ;
  }
}
