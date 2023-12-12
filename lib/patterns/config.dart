class Config {
  static bool _signedIn = false;
  static const String _loginURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/login';
  static const String _signUpURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/signup';
  static const String _verifyCodeURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/verifycode';
  static const String _forgotPasswordURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/forgotpassword';
  static String _username = '';
  static String _email = '';
  static String _password = '';
  static String _userToken = '';
  static String _profilePicture = '';

  static String getLoginURL() => _loginURL;
  static String getSignUpURL() => _signUpURL;
  static String getVerifyURL() => _verifyCodeURL;
  static String getForgotPasswordURL() => _forgotPasswordURL;
  static String getUsername() => _username;
  static String getEmail() => _email;
  static String getPassword() => _password;
  static String getProfilePicture() => _profilePicture;

  static void setProfilePicture({required String profilePictureURL}) {
    _profilePicture = profilePictureURL;
  }

  static void setEmail({required String email}) {
    _email = email;
  }

  static void setPassword({required String password}) {
    _password = password;
  }

  static void setUsername({required String username}) {
    _username = username;
  }

  static void setUserToken(String token) {
    _userToken = token;
  }

  static String getUserToken() => _userToken;

  static void setSignedIn(bool value) {
    _signedIn = value;
  }

  static bool getSignedIn() => _signedIn;
}
