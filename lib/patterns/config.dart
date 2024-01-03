class Config {
  static bool _searchBarEnable = true;
  static bool _onJourney = false;
  static bool _signedIn = false;
  static bool _quickSearchLoaded = false;
  static const String _mapsApiKey = 'AIzaSyDHkfZhEbOlIDyYyx0FiXF5K28VATsiVL0';
  static const String _loginURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/login';
  static const String _signUpURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/signup';
  static const String _verifyCodeURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/verifycode';
  static const String _forgotPasswordURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/forgotpassword';
  static const String _nearestParksURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/getnearestparks';
  static const String _quickSearchesURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/getquicksearchresults';
  static const String _startJourneyURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/startjourney';
  static const String _sendReportURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/sendreport';
  static const String _finishJourneyURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/finishjourney';
  static const String _journeyTrackingURL =
      'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/controljourney';

  static String _name = '';
  static String _surname = '';
  static String _username = '';
  static String _email = '';
  static String _password = '';
  static String _userToken = '';
  static String _profilePicture = '';
  static int simulationIndex = 0;

  static bool getSearchBarEnable() => _searchBarEnable;
  static String getJourneyTrackingURL() => _journeyTrackingURL;
  static String getFinishJourneyURL() => _finishJourneyURL;
  static String getSendReportURL() => _sendReportURL;
  static String getStartJourneyURL() => _startJourneyURL;
  static bool getQuickSearchLoaded() => _quickSearchLoaded;
  static String getNearestParksURL() => _nearestParksURL;
  static String getMapsApiKey() => _mapsApiKey;
  static String getLoginURL() => _loginURL;
  static String getSignUpURL() => _signUpURL;
  static String getVerifyURL() => _verifyCodeURL;
  static String getForgotPasswordURL() => _forgotPasswordURL;
  static String getUsername() => _username;
  static String getEmail() => _email;
  static String getPassword() => _password;
  static String getProfilePicture() => _profilePicture;
  static String getQuickSearchesURL() => _quickSearchesURL;
  static bool getOnJourney() => _onJourney;
  static String getName() => _name;
  static String getSurname() => _surname;

  static void setSearchBarEnable({required bool value}) {
    _searchBarEnable = value;
  }

  static void setOnJourney({required bool value}) {
    _onJourney = value;
  }

  static void setQuickSearchLoaded({required bool value}) {
    _quickSearchLoaded = value;
  }

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

  static void setName({required String name}) {
    _name = name;
  }

  static void setSurname({required String surname}) {
    _surname = surname;
  }

  static void setUserToken(String token) {
    _userToken = token;
  }

  static String getUserToken() => _userToken;

  static void setSignedIn(bool value) {
    _signedIn = value;
  }

  static bool getSignedIn() => _signedIn;

  static void clearAll() {
    _userToken = '';
    _username = '';
    _email = '';
    _password = '';
    _profilePicture = '';
  }
}
