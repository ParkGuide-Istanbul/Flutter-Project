import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/pages/signUp.dart';

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
  final TextEditingController _emailController = TextEditingController();
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
    String email = _emailController.text;
    String password = _passwordController.text;

    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
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
                backgroundColor: Colors.purple[700],
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
                        style:
                            TextStyle(color: Colors.purple[700], fontSize: 16),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
