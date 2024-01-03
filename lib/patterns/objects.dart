class Park {
  String _name = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _district = '';
  String _mapsURL = '';
  int _capasity = 0;
  int _emptyCapacity = 0;

  Park(
      {required String name,
      required String district,
      required double latitude,
      required double longitude,
      required String mapsURL,
      required int capacity,
      required int emptyCapacity}) {
    _name = name;
    _district = district;
    _latitude = latitude;
    _longitude = longitude;
    _mapsURL = mapsURL;
    _capasity = capacity;
    _emptyCapacity = emptyCapacity;
  }

  String getName() => _name;
  String getDistrict() => _district;
  double getLatitude() => _latitude;
  double getLongitude() => _longitude;
  String getMapsURL() => _mapsURL;
  int getCapacity() => _capasity;
  int getEmptyCapacity() => _emptyCapacity;
}
