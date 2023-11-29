import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';

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
  final _signupKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatedController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? emailValidator(email) {
    RegExp _regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_regex.hasMatch(email))
      return null;
    else
      return "Please enter a valid email.";
  }

  void signup() {
    if (_signupKey.currentState!.validate()) {
      List<String> strings = <String>[];
      strings.add(_nameController.text);
      strings.add(_surNameController.text);
      strings.add(_emailController.text);
      strings.add(_passwordController.text);

      strings.forEach((element) {
        print(element + "\n");
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
                    ? "Name should be longer than 2 characters"
                    : null,
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) => value!.length < 2
                    ? "Surname should be longer than 2 characters"
                    : null,
                controller: _surNameController,
                decoration: const InputDecoration(
                    labelText: "Surname",
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
