import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/pages/login.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
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
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ortakoy_mosq.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  alignment: Alignment.center)),
        ),
        const SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: SignUpForm(),
        )),
      ]),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final HttpRequests httpReq = HttpRequests(Config.getSignUpURL());
  final _signupKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatedController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();

  String? emailValidator(email) {
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (regex.hasMatch(email)) {
      return null;
    } else {
      return "Please enter a valid email.";
    }
  }

  void signup() {
    if (_signupKey.currentState!.validate()) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String name = _nameController.text;
      String surname = _surNameController.text;

      Map<String, dynamic> signupInfo = {
        "username": username,
        "password": password,
        "email": email,
        "name": name,
        "surname": surname
      };
      httpReq.postRequest(signupInfo).then((response) {
        if (response['statusCode'] == 200) {
          //DOGRULAMA KODU ALMA İŞLEMLERİNE GEÇİLMELİ
          UsernameSingleton usernameSingleton = UsernameSingleton.getInstance();
          usernameSingleton.setUsername(username: username);
          PasswordSingleton passwordSingleton = PasswordSingleton.getInstance();
          passwordSingleton.setPassword(password: password);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignupCodePage()));
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
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _signupKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextFormField(
                validator: (value) => value!.length < 2
                    ? "Name shouldn't be shorter than 2 characters"
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
                    ? "Surname shouldn't be shorter than 2 characters"
                    : null,
                controller: _surNameController,
                decoration: const InputDecoration(
                    labelText: "Surname",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
              ),
              const SizedBox(height: 15),
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

class SignupCodePage extends StatelessWidget {
  const SignupCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          preLoginAppBar(label: 'Enter Verification Code', context: context),
      body: SignUpCodeStage(),
    );
  }
}

class SignUpCodeStage extends StatefulWidget {
  SignUpCodeStage({Key? key}) : super(key: key);

  @override
  State<SignUpCodeStage> createState() => _SignUpCodeStageState();
}

class _SignUpCodeStageState extends State<SignUpCodeStage> {
  /*
    Here, there should be validation code coming from backend and the validation check should be here. 
  */

  HttpRequests httpReq = HttpRequests(Config.getVerifyURL());

  String? codeValidator(code) {
    return null;
  }

  UsernameSingleton? usernameSingleton;
  String username = '';
  PasswordSingleton? passwordSingleton;
  String password = '';

  _SignUpCodeStageState() {
    usernameSingleton = UsernameSingleton.getInstance();
    username = usernameSingleton!.getUsername();
    passwordSingleton = PasswordSingleton.getInstance();
    password = passwordSingleton!.getPassword();
  }
  final _codeValidationKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  void _submit() {
    if (_codeValidationKey.currentState!.validate()) {
      String validationCode = _codeController.text;
      Map<String, dynamic> vCode = {
        "username": username,
        "password": password,
        "code": validationCode
      };
      httpReq.postRequest(vCode).then((res) {
        if (res['statusCode'] == 200) {
          Fluttertoast.showToast(
              msg: "SignUp Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: CustomColors.darkPurple(),
              textColor: Colors.white,
              fontSize: 16.0);

          while (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          /*Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => LoginPage()));*/
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
