class Config {
  static bool _signedIn = false;
  static const String _loginURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/login';
  static const String _signUpURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/signup';
  static const String _verifyCodeURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/verifycode';
  static String _userToken = '';

  static String getLoginURL() => _loginURL;
  static String getSignUpURL() => _signUpURL;
  static String getVerifyURL() => _verifyCodeURL;

  static void setUserToken(String token) {
    _userToken = token;
  }

  static String getUserToken() => _userToken;

  static void setSignedIn(bool value) {
    _signedIn = value;
  }

  static bool getSignedIn() => _signedIn;
}
