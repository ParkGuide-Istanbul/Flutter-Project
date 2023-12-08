import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:park_guide_istanbul/pages/mainPage.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/pages/signUp.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import 'forgotPassword.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final String label = "label";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preLoginAppBar(label: 'Login To Your Account', context: context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: LoginForm(),
      )),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  HttpRequests httpLogin = new HttpRequests(Config.getLoginURL());

  final _loginKey = GlobalKey<FormState>();
  bool wrongCredentials = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void goToSignUpPage() {
    print('This is Sign Up function');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void passwordRenewingMethod() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ForgotPasswordEmailPage()));
  }

  void _submit() {
    // Here, you can add your authentication logic.
    // For a basic example, we'll just print the email and password.
    String username = _usernameController.text;
    String password = _passwordController.text;

    Map<String, dynamic> userCredentials = {
      'username': username,
      'password': password,
    };

    httpLogin.postRequest(userCredentials).then((value) {
      if (value['statusCode'] == 200) {
        wrongCredentials = false;
        String userToken = value['body']['token'];
        Config.setUserToken(userToken);
        //go to home page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } else if (value['statusCode'] == 500) {
        print('Server is off.');
      } else {
        wrongCredentials = true;
        _loginKey.currentState!.validate();
      }
    });

    print('Email: $username');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _loginKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              validator: (value) => wrongCredentials
                  ? "Username and password do not match!"
                  : null,
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              validator: (value) => wrongCredentials
                  ? "Username and password do not match!"
                  : null,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.5,
              child: OutlinedButton(
                onPressed: _submit,
                child: Text('Login'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: CustomColors.darkPurple(),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                      child: TextButton(
                        onPressed: passwordRenewingMethod,
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    Text(
                      "Don't you have account yet?",
                      style: TextStyle(color: Colors.purple[500], fontSize: 16),
                    ),
                    TextButton(
                        onPressed: goToSignUpPage,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.purple[700], fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
