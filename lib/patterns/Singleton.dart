import 'package:park_guide_istanbul/patterns/objects.dart';

class EmailSingleton {
  static EmailSingleton? _singleton;

  EmailSingleton._();

  static EmailSingleton getInstance() {
    singleton ??= EmailSingleton.();

    return _singleton!;
  }

  String _email = '';
  void setEmail({required String email}) {
    _email = email;
  }

  String getEmail() => _email;
}

class UsernameSingleton {
  static UsernameSingleton? _singleton;

  UsernameSingleton._();

  static UsernameSingleton getInstance() {
    singleton ??= UsernameSingleton.();

    return _singleton!;
  }

  String _username = '';
  void setUsername({required String username}) {
    _username = username;
  }

  String getUsername() => _username;
}

class PasswordSingleton {
  static PasswordSingleton? _singleton;

  PasswordSingleton._();

  static PasswordSingleton getInstance() {
    singleton ??= PasswordSingleton.();

    return _singleton!;
  }

  String _password = '';
  void setPassword({required String password}) {
    _password = password;
  }

  String getPassword() => _password;
}

class ParkListSingleton {
  static ParkListSingleton? _singleton;

  ParkListSingleton._();
  static ParkListSingleton getInstance() {
    singleton ??= ParkListSingleton.();

    return _singleton!;
  }

  List<Park> _parkList = [];
  void setList({required List<Park> parkList}) {
    _parkList = parkList;
  }

  List<Park> getParkList() => _parkList;
}

class LocationSingleton {
  static LocationSingleton? _singleton;
  LocationSingleton._();
  static LocationSingleton getInstance() {
    singleton ??= LocationSingleton.();

    return _singleton!;
  }

  String _searchedLocation = '';
  String _searchedLocationDistrict = '';
  double _searchedLat = 0.0;
  double _searchedLng = 0.0;
  bool _searchAsCurrentLocation = false;

  void setSearchedLocationDistrict(String district) {
    _searchedLocationDistrict = district;
  }

  void setSearchedLat(double lat) {
    _searchedLat = lat;
  }

  void setSearchedLng(double lng) {
    _searchedLng = lng;
  }

  void setSearchAsCurrentLocation(bool val) {
    _searchAsCurrentLocation = val;
  }

  void setSearchedLocation(String locationName) {
    _searchedLocation = locationName;
  }

  String getSearchedLocationDistrict() => _searchedLocationDistrict;
  String getSearchedLocation() => _searchedLocation;
  bool getSearchAsCurrentLocation() => _searchAsCurrentLocation;
  double getSearchedLat() => _searchedLat;
  double getSearchedLng() => _searchedLng;
}

class QuickSearchSingleton {
  static QuickSearchSingleton? _singleton;
  QuickSearchSingleton._();
  static QuickSearchSingleton getInstance() {
    singleton ??= QuickSearchSingleton.();
    return _singleton!;
  }

  List<String> _quickSearches = [];
  void setQuickSearches(List<String> quickSearches) {
    _quickSearches = quickSearches;
  }

  List<String> getQuickSearches() => _quickSearches;
}
