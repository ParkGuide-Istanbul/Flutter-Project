import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_guide_istanbul/pages/nearestParks.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/patterns/maps.dart';
import 'package:park_guide_istanbul/patterns/objects.dart';
import 'package:park_guide_istanbul/patterns/userLocation.dart';
import 'package:park_guide_istanbul/utils/helper.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import 'package:geolocator/geolocator.dart';

class MainSearchBar extends StatefulWidget {
  MainSearchBar({Key? key}) : super(key: key);

  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
  UserLocation _userLocation = UserLocation();
  MapsApi _mapsApi = MapsApi();
  HttpRequests httpReq = HttpRequests(Config.getNearestParksURL());
  TextEditingController _searchBarController = TextEditingController();

  void _searchFromBar() {
    if (Config.getOnJourney()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Text(
                  'You have a journey.',
                  style: CustomTextStyles.drawerMenuTextStyle(),
                ),
                content: Text(
                    'You should stop the journey to look for new destinations.',
                    style: TextStyle(color: CustomColors.middlePurple())),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the AlertDialog
                    },
                    child: Text('OK'),
                  )
                ],
              ));
      return;
    }

    String adres = _searchBarController.text;
    String id = '';
    String dist = '';
    double lat = 0.0;
    double lng = 0.0;
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    _mapsApi.getIdFromAddress(adres).then(((value) {
      print(value);
      id = value;
      print('PLACE ID: ' + id);
      _mapsApi.getCoordinatesFromAddress(id).then(
        (value) {
          print("LOCATION INFO: \n");
          print(value['district']);

          String district = '';
          district = Helpers.correctDistrictName(value['district']);

          dist = district;
          lat = value['latitude'];
          lng = value['longitude'];
          Map<String, dynamic> data = {
            "district": district,
            "lat": "${value['latitude']}",
            "lng": "${value['longitude']}"
          };
          httpReq.nearestParksPostRequest(data).then((value) {
            /*for (int i = 0; i < value.length; i++) {
              print(
                  'PARK ID: ${value[i]['parkID']}, PARK NAME: ${value[i]['parkName']}\n');
            }*/

            ParkListSingleton.getInstance().setList(parkList: [
              Park(
                  name: value[0]['parkName'],
                  district: value[0]['district'],
                  latitude: double.parse(value[0]['lat']),
                  longitude: double.parse(value[0]['lng']),
                  mapsURL: value[0]['MapsURL'],
                  capacity: value[0]['capacity'],
                  emptyCapacity: value[0]['emptyCapacity']),
              Park(
                  name: value[1]['parkName'],
                  district: value[1]['district'],
                  latitude: double.parse(value[1]['lat']),
                  longitude: double.parse(value[1]['lng']),
                  mapsURL: value[1]['MapsURL'],
                  capacity: value[1]['capacity'],
                  emptyCapacity: value[1]['emptyCapacity']),
              Park(
                  name: value[2]['parkName'],
                  district: value[2]['district'],
                  latitude: double.parse(value[2]['lat']),
                  longitude: double.parse(value[2]['lng']),
                  mapsURL: value[2]['MapsURL'],
                  capacity: value[2]['capacity'],
                  emptyCapacity: value[2]['emptyCapacity']),
              Park(
                  name: value[3]['parkName'],
                  district: value[3]['district'],
                  latitude: double.parse(value[3]['lat']),
                  longitude: double.parse(value[3]['lng']),
                  mapsURL: value[3]['MapsURL'],
                  capacity: value[3]['capacity'],
                  emptyCapacity: value[3]['emptyCapacity']),
              Park(
                  name: value[4]['parkName'],
                  district: value[4]['district'],
                  latitude: double.parse(value[4]['lat']),
                  longitude: double.parse(value[4]['lng']),
                  mapsURL: value[4]['MapsURL'],
                  capacity: value[4]['capacity'],
                  emptyCapacity: value[4]['emptyCapacity'])
            ]);
            LocationSingleton locationSingleton =
                LocationSingleton.getInstance();
            locationSingleton.setSearchAsCurrentLocation(false);
            locationSingleton.setSearchedLocation(adres);
            locationSingleton.setSearchedLocationDistrict(dist);
            locationSingleton.setSearchedLat(lat);
            locationSingleton.setSearchedLng(lng);
            Navigator.of(context).pop();
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => NearestParksPage()));
          });
        },
      );
    }));
  }

  void _selfLocation() {
    if (Config.getOnJourney()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Text(
                  'You have a journey.',
                  style: CustomTextStyles.drawerMenuTextStyle(),
                ),
                content: Text(
                    'You should stop the journey to look for new destinations.',
                    style: TextStyle(color: CustomColors.middlePurple())),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the AlertDialog
                    },
                    child: Text('OK'),
                  )
                ],
              ));
      return;
    }
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    double exampleLat = 40.9876722;
    double exampleLng = 29.0368903;
    String exampleDistrict = "KADIKÖY";
    Map<String, double> coordinates = {};
    Helpers.selfLocation().then((value) {
      coordinates = value;
      _mapsApi
          .getDistrictFromCoordinates(
              lat: coordinates['latitude']!, lng: coordinates['longitude']!)
          .then((district) {
        /*LocationSingleton locationSingleton = LocationSingleton.getInstance();
        locationSingleton.setSearchedLat(coordinates['lat']!);
        locationSingleton.setSearchedLng(coordinates['lng']!);
        locationSingleton.setSearchedLocationDistrict(district);*/

        /*Map<String, dynamic> data = {
          "district": district,
          "lat": "${coordinates['latitude']}",
          "lng": "${coordinates['longitude']}"
        };*/
        Map<String, dynamic> data = {
          "district": exampleDistrict,
          "lat": "${exampleLat}",
          "lng": "${exampleLng}"
        };
        httpReq.nearestParksPostRequest(data).then((value) {
          LocationSingleton locationSingleton = LocationSingleton.getInstance();
          locationSingleton.setSearchedLocation("Current Location");
          locationSingleton.setSearchAsCurrentLocation(true);
          ParkListSingleton.getInstance().setList(parkList: [
            Park(
                name: value[0]['parkName'],
                district: value[0]['district'],
                latitude: double.parse(value[0]['lat']),
                longitude: double.parse(value[0]['lng']),
                mapsURL: value[0]['MapsURL'],
                capacity: value[0]['capacity'],
                emptyCapacity: value[0]['emptyCapacity']),
            Park(
                name: value[1]['parkName'],
                district: value[1]['district'],
                latitude: double.parse(value[1]['lat']),
                longitude: double.parse(value[1]['lng']),
                mapsURL: value[1]['MapsURL'],
                capacity: value[1]['capacity'],
                emptyCapacity: value[1]['emptyCapacity']),
            Park(
                name: value[2]['parkName'],
                district: value[2]['district'],
                latitude: double.parse(value[2]['lat']),
                longitude: double.parse(value[2]['lng']),
                mapsURL: value[2]['MapsURL'],
                capacity: value[2]['capacity'],
                emptyCapacity: value[2]['emptyCapacity']),
            Park(
                name: value[3]['parkName'],
                district: value[3]['district'],
                latitude: double.parse(value[3]['lat']),
                longitude: double.parse(value[3]['lng']),
                mapsURL: value[3]['MapsURL'],
                capacity: value[3]['capacity'],
                emptyCapacity: value[3]['emptyCapacity']),
            Park(
                name: value[4]['parkName'],
                district: value[4]['district'],
                latitude: double.parse(value[4]['lat']),
                longitude: double.parse(value[4]['lng']),
                mapsURL: value[4]['MapsURL'],
                capacity: value[4]['capacity'],
                emptyCapacity: value[4]['emptyCapacity'])
          ]);
          Navigator.of(context).pop();
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => NearestParksPage()));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(32),
      child: CupertinoSearchTextField(
        enabled: Config.getSearchBarEnable(),
        backgroundColor: CustomColors.customGrey(),
        prefixIcon: GestureDetector(
            onTap: _selfLocation, child: Icon(Icons.my_location_sharp)),
        suffixIcon: Icon(CupertinoIcons.search),
        onSuffixTap: _searchFromBar,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        controller: _searchBarController,
        borderRadius: BorderRadius.circular(16),
        placeholder: "Where are you going to?",
        placeholderStyle:
            TextStyle(color: CustomColors.middlePurple(), fontSize: 20),
        itemColor: CustomColors.middlePurple(),
        itemSize: 25,
        onSubmitted: (val) {
          _searchFromBar();
        },
        autocorrect: true,
      ),
    );
  }
}
