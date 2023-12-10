import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import '../patterns/config.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preLoginAppBar(
          label: 'Sign Up To ParkGuide Istanbul', context: context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: SignUpForm(),
      )),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final HttpRequests httpReq = new HttpRequests(Config.getSignUpURL());
  final _signupKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatedController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String? emailValidator(email) {
    RegExp _regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_regex.hasMatch(email))
      return null;
    else
      return "Please enter a valid email.";
  }

  void signup() {
    if (_signupKey.currentState!.validate()) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      Map<String, dynamic> signupInfo = {
        "username": username,
        "password": password,
        "email": email
      };
      httpReq.postRequest(signupInfo).then((response) {
        if (response['statusCode'] == 200) {
          //KOD ALMA İŞLEMLERİNE GEÇİLMELİ

        } else if (response['statusCode'] == 400) {
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
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _signupKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextFormField(
                validator: (value) => value!.length < 2
                    ? "Username should be longer than 2 characters"
                    : null,
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: emailValidator,
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) => value!.length < 8
                    ? "Password must be longer than 8 characters"
                    : null,
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value != _passwordController.text)
                    return "Passwords don't match";
                  else
                    null;
                },
                controller: _passwordRepeatedController,
                decoration: const InputDecoration(
                    labelText: "Password Repeat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Center(child: customButton(label: 'Sign Up', onPressed: signup))
            ],
          ),
        ),
      ),
    );
  }
}
