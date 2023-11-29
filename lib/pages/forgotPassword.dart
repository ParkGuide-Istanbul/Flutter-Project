import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';

class ForgotPasswordEmailPage extends StatelessWidget {
  const ForgotPasswordEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          preLoginAppBar(label: 'Enter Your E-Mail Adress', context: context),
      body: ForgotPasswordEmailStage(),
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
  final _validationKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  RegExp _regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void _submit() {
    if (_validationKey.currentState!.validate()) {
      String email = _emailController.text;
      EmailSingleton singleton = EmailSingleton.getInstance() as EmailSingleton;
      singleton.setEmail(email: email);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ForgotPasswordCodePage()));
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
            SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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

  EmailSingleton? singleton;
  String email = '';

  _ForgotPasswordCodeStageState() {
    this.singleton = EmailSingleton.getInstance();
    email = singleton!.getEmail();
    print(email);
  }
  final _codeValidationKey = GlobalKey<FormState>();
  TextEditingController _codeController = new TextEditingController();

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
            SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
            customButton(label: 'Submit', onPressed: _submit),
            Padding(padding: EdgeInsets.all(10))
          ],
        ),
      ),
    );
    ;
  }
}
