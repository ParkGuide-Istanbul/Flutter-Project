import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_guide_istanbul/pages/mainPage.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/patterns/maps.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/pages/signUp.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import 'forgotPassword.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final String label = "label";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: preLoginAppBar(label: 'Login To Your Account', context: context),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ortakoy_mosq.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  alignment: Alignment.center)),
        ),
        SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: LoginForm(),
        )),
      ]),
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
  HttpRequests _httpQS = HttpRequests(Config.getQuickSearchesURL());
  MapsApi _mapsApi = MapsApi();
  final _loginKey = GlobalKey<FormState>();
  bool wrongCredentials = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> _quickSearches = [];

  void goToSignUpPage() {
    print('This is Sign Up function');
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => SignUpPage()));
  }

  void passwordRenewingMethod() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) => ForgotPasswordEmailPage()));
  }

  void _submit() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Username and password have to be filled.",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: CustomColors.middlePurple());

      return;
    }

    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    Map<String, dynamic> userCredentials = {
      "username": username,
      "password": password,
      "requiredRoles": ["StandardUser"]
    };

    httpLogin.postRequest(userCredentials).then((response) {
      if (response['statusCode'] == 200) {
        print(response);
        wrongCredentials = false;
        String userToken = response['message']['token'];
        String name = response['message']['name'];
        String surname = response['message']['surname'];
        print('TOKEN: $userToken');
        Config.setUserToken(userToken);
        Config.setPassword(password: password);
        Config.setUsername(username: username);
        Config.setName(name: name);
        Config.setSurname(surname: surname);
        Config.setProfilePicture(
            profilePictureURL: "assets/useravatarazkucuk.png");
        //Main page context obtain protocol:
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => MainPage()));

        //go to home page

      } else if (response['statusCode'] == 500) {
        Navigator.of(context).pop();
        print('Server is off.');
      } else {
        Navigator.of(context).pop();
        wrongCredentials = true;
        _loginKey.currentState!.validate();
        wrongCredentials = false;
        Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: CustomColors.middlePurple());
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
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
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
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
