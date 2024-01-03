import 'dart:convert';
import 'dart:isolate';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_guide_istanbul/pages/mainPage.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/patterns/maps.dart';
import 'package:park_guide_istanbul/patterns/objects.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/utils/helper.dart';
import 'package:park_guide_istanbul/utils/searchBar.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

ReceivePort? receivePort;
Isolate? backgroundIsolate;
Timer? backgroundTimer;

void trackJourney(SendPort sendPort) async {
  //WidgetsFlutterBinding.ensureInitialized();
  backgroundTimer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
    ReceivePort isolateReceivePort = ReceivePort();
    sendPort.send(isolateReceivePort.sendPort);

    isolateReceivePort.listen((message) {
      if (message is String && message == 'getLocation') {
        sendPort.send('fetchLocation');
      } else {
        HttpRequests httpJT = HttpRequests(
            'https://o11xc731wl.execute-api.eu-central-1.amazonaws.com/dev2/controljourney');
        MapsApi mapsJT = MapsApi();
        double lat = message['latitude'];
        double lng = message['longitude'];
        String token = message['token'];
        mapsJT.getDistrictFromCoordinates(lat: lat, lng: lng).then((district) {
          Map<String, dynamic> data = {
            "district": district,
            "lat": "$lat",
            "lng": "$lng"
          };
          httpJT.isolatePostRequest(data, token).then((res) {
            if (res['message'] ==
                'The user has not yet been closed the destination') {
              sendPort.send('JOURNEY CONTINUES.');
              return;
            } else if (res['message'] == 'Operation failed.') {
              sendPort.send(res['message']);
              return;
            } else {
              sendPort.send(res);
              return;
            }
          });
        });
      }
    });
  });
}

void startJourneyTrack() async {
  receivePort = ReceivePort();
  var backgroundIsolate =
      await Isolate.spawn(trackJourney, receivePort!.sendPort);
  Config.setOnJourney(value: true);
  Config.simulationIndex = 0;
}

class NearestParksPage extends StatefulWidget {
  NearestParksPage({Key? key}) : super(key: key);

  @override
  State<NearestParksPage> createState() => _NearestParksPageState();
}

class _NearestParksPageState extends State<NearestParksPage> {
  void _startJourney() {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    LocationSingleton locationSingleton = LocationSingleton.getInstance();
    String destinationDistrict =
        locationSingleton.getSearchedLocationDistrict();
    double destinationLat = locationSingleton.getSearchedLat();
    double destinationLng = locationSingleton.getSearchedLng();

    Map<String, dynamic> destination = {
      "destinationdistrict": destinationDistrict,
      "destinationlat": "$destinationLat",
      "destinationlng": "$destinationLng"
    };

    String exampleCurrentDistrict = "GÜNGÖREN";
    double exampleCurrentLat = 41.021397;
    double exampleCurrentLng = 28.872747;

    Map<String, dynamic> starting = {
      "startingdistrict": exampleCurrentDistrict,
      "startinglat": "$exampleCurrentLat",
      "startinglng": "$exampleCurrentLng"
    };

    Helpers.selfLocation().then((coordinates) {
      MapsApi mapsApi = MapsApi();
      mapsApi
          .getDistrictFromCoordinates(
              lat: coordinates['latitude']!, lng: coordinates['longitude']!)
          .then((district) {
        print("AGA DISTRICT");
        print(district);

        HttpRequests httpReq = HttpRequests(Config.getStartJourneyURL());
        Map<String, dynamic> data = {
          "starting": starting,
          "destination": destination
        };

        httpReq.postRequest(data, header: true).then((response) {
          print(response);
          Config.setOnJourney(value: true);
          Config.setSearchBarEnable(value: false);
          while (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: ((context) => MainPage())));
          Fluttertoast.showToast(
              msg: "Journey has started.",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: CustomColors.middlePurple());
        });
      });
    });

    startJourneyTrack();
  }

  @override
  Widget build(BuildContext context) {
    LocationSingleton locationSingleton = LocationSingleton.getInstance();
    //LocationSingleton.getInstance().setSearchAsCurrentLocation(false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: mainAppBar(),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ortakoy_mosq.png'),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
          ),
          SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 32, bottom: 16),
                child: Container(
                    decoration: BoxDecoration(
                        color: CustomColors.customGrey(),
                        borderRadius: BorderRadius.circular(16)),
                    height: 150,
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Destination Location:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: CustomColors.lightPurple()),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                locationSingleton
                                    .getSearchedLocation()
                                    .toUpperCase(),
                                style: CustomTextStyles.labelTextStyle(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              locationSingleton.getSearchAsCurrentLocation()
                  ? const SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : customButton(
                      label: "START JOURNEY", onPressed: _startJourney),
              Container(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  "AVAILABLE PARKS NOW: ",
                  style: CustomTextStyles.labelTextStyle(),
                  textAlign: TextAlign.left,
                ),
              ),
              const NearestParks(),
              const SizedBox(height: 20)
            ]),
          ),
        ]));
  }
}

class NearestParks extends StatefulWidget {
  const NearestParks({Key? key}) : super(key: key);

  @override
  State<NearestParks> createState() => _NearestParksState();
}

/*List<dynamic> _quickSearches = [
  "Barbaros Meydanı, Beşiktaş/Istanbul",
  "İTÜ Taşkışla Yerleşkesi, Beyoğlu/Istanbul",
  "Şükrü Saraçoğlu Stadyumu, Kadıköy/Istanbul",
  "Sabiha Gökçen Havalimanı, Pendik/Istanbul",
  "İstanbul Büyükşehir Belediyesi, Fatih/Istanbul"
];
List<int> _emptySpots = [34, 35, 36, 37, 38];
List<int> _capacities = [100, 120, 140, 160, 180];*/

class _NearestParksState extends State<NearestParks> {
  List<Park> _parkList = [];
  _NearestParksState() {
    _parkList = ParkListSingleton.getInstance().getParkList();
  }

  void _openGoogleMaps(int index) async {
    final String googleMapsUrl = _parkList[index].getMapsURL();
    print(googleMapsUrl);
    // Use the launch method from url_launcher to open the URL
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    Icon goToIcon = Icon(
      CupertinoIcons.location_fill,
      color: CustomColors.darkPurple(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CustomColors.customGrey()),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.darkGrey(),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "${_parkList[0].getName()}, ${_parkList[0].getDistrict()}/Istanbul",
                          style: TextStyle(
                              color: CustomColors.darkPurple(), fontSize: 20),
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                          "${_parkList[0].getCapacity() - _parkList[0].getEmptyCapacity()}/${_parkList[0].getCapacity()}",
                          style: TextStyle(
                              color: CustomColors.darkPurple(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      const SizedBox(width: 10),
                      Center(
                          child: GestureDetector(
                              onTap: () {
                                _openGoogleMaps(0);
                              },
                              child: goToIcon)),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${_parkList[1].getName()}, ${_parkList[1].getDistrict()}/Istanbul",
                            style: TextStyle(
                                color: CustomColors.darkPurple(), fontSize: 20),
                            textAlign: TextAlign.left,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                            "${_parkList[1].getCapacity() - _parkList[1].getEmptyCapacity()}/${_parkList[1].getCapacity()}",
                            style: TextStyle(
                                color: CustomColors.darkPurple(),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(width: 10),
                        Center(
                            child: GestureDetector(
                                onTap: () {
                                  _openGoogleMaps(1);
                                },
                                child: goToIcon)),
                      ],
                    )),
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(color: CustomColors.darkGrey()),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${_parkList[2].getName()}, ${_parkList[2].getDistrict()}/Istanbul",
                            style: TextStyle(
                                color: CustomColors.darkPurple(), fontSize: 20),
                            textAlign: TextAlign.left,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                            "${_parkList[2].getCapacity() - _parkList[2].getEmptyCapacity()}/${_parkList[2].getCapacity()}",
                            style: TextStyle(
                                color: CustomColors.darkPurple(),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(width: 10),
                        Center(
                            child: GestureDetector(
                                onTap: () {
                                  _openGoogleMaps(2);
                                },
                                child: goToIcon)),
                      ],
                    )),
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${_parkList[3].getName()}, ${_parkList[3].getDistrict()}/Istanbul",
                            style: TextStyle(
                                color: CustomColors.darkPurple(), fontSize: 20),
                            textAlign: TextAlign.left,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                            "${_parkList[3].getCapacity() - _parkList[3].getEmptyCapacity()}/${_parkList[3].getCapacity()}",
                            style: TextStyle(
                                color: CustomColors.darkPurple(),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(width: 10),
                        Center(
                            child: GestureDetector(
                                onTap: () {
                                  _openGoogleMaps(3);
                                },
                                child: goToIcon)),
                      ],
                    )),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.darkGrey(),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "${_parkList[4].getName()}, ${_parkList[4].getDistrict()}/Istanbul",
                          style: TextStyle(
                              color: CustomColors.darkPurple(), fontSize: 20),
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                          "${_parkList[4].getCapacity() - _parkList[4].getEmptyCapacity()}/${_parkList[4].getCapacity()}",
                          style: TextStyle(
                              color: CustomColors.darkPurple(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      const SizedBox(width: 10),
                      Center(
                          child: GestureDetector(
                              onTap: () {
                                _openGoogleMaps(4);
                              },
                              child: goToIcon)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
