import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:park_guide_istanbul/patterns/Singleton.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/patterns/httpReqs.dart';
import 'package:park_guide_istanbul/patterns/maps.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import '../patterns/objects.dart';
import '../utils/helper.dart';
import '../utils/searchBar.dart';
import 'nearestParks.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _finishJourney() {
    print("FINISH JOURNEY");

    HttpRequests httpReq = HttpRequests(Config.getFinishJourneyURL());
    httpReq.getRequest().then((response) {
      print(response);
      Config.setOnJourney(value: false);
      setState(() {
        Config.setSearchBarEnable(value: true);
      });
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Journey is cancelled.",
          backgroundColor: CustomColors.middlePurple());
    });

    finishJourneyTrack();
  }

  void finishJourneyTrack() {
    try {
      backgroundTimer?.cancel();
      backgroundIsolate?.kill(priority: Isolate.immediate);
      receivePort?.close();
      backgroundTimer = null;
      backgroundIsolate = null;
      receivePort = null;
      setState(() {
        Config.setOnJourney(value: false);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  List<Map<String, double>> simulationLocs = [
    {"latitude": 41.108814, "longitude": 29.022575},
    {"latitude": 41.094331, "longitude": 29.004828},
    {"latitude": 41.075999, "longitude": 29.014221},
    {"latitude": 41.055142, "longitude": 29.009061}
  ];
  @override
  Widget build(BuildContext context) {
    if (Config.getOnJourney()) {
      SendPort? isolatesendPort;
      receivePort?.listen((message) {
        if (Config.simulationIndex < simulationLocs.length) {
          if (message == 'JOURNEY CONTINUES.') {
            print(message);
          } else if (message == 'Operation failed.') {
            print(message);
          } else if (message is SendPort) {
            isolatesendPort = message;
            isolatesendPort!.send('getLocation');
          } else if (message is String && message == 'fetchLocation') {
            Helpers.selfLocation().then((value) {
              isolatesendPort!.send({
                "latitude": simulationLocs[Config.simulationIndex]['latitude'],
                "longitude": simulationLocs[Config.simulationIndex]
                    ['longitude'],
                "token": Config.getUserToken()
              });
              Config.simulationIndex++;
            });
          }
        } else {
          //JOURNEY COMES TO THE END.
          print(message);
          finishJourneyTrack();
          List<dynamic> value = message['list'];
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
          LocationSingleton.getInstance().setSearchAsCurrentLocation(true);
          Config.setOnJourney(value: false);
          Config.setSearchBarEnable(value: true);
          while (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => NearestParksPage()));
          NotificationHelper.showNotification(
              title: "You're about to arrive in your destination!",
              body: "Click to see the currently available parks now.",
              payload: "payloadddd");
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(),
      drawer: const MainDrawer(),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ortakoy_mosq.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  alignment: Alignment.center)),
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            Config.getOnJourney()
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.darkPurple(),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Text(
                            'JOURNEY IS ON TO: ${LocationSingleton.getInstance().getSearchedLocation()}',
                            style: CustomTextStyles.drawerMenuTextStyle(
                                setPurple: true),
                          ),
                          const SizedBox(height: 16),
                          customButton(
                              label: "FINISH JOURNEY",
                              onPressed: _finishJourney)
                        ],
                      ),
                    ),
                  )
                : const SizedBox(height: 0, width: 0),
            MainBody(),
          ],
        ))
      ]),
    );
  }
}

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return customDrawer(context: context, pageName: PAGE.MAIN);
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 200, child: MainSearchBar()),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          alignment: Alignment.centerLeft,
          child: Text(
            "Quick Search",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: CustomColors.middlePurple(),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        const MainQuickSearches(),
      ],
    );
  }
}

class MainQuickSearches extends StatefulWidget {
  const MainQuickSearches({Key? key}) : super(key: key);

  @override
  State<MainQuickSearches> createState() => _MainQuickSearchesState();
}

class _MainQuickSearchesState extends State<MainQuickSearches> {
  HttpRequests _httpQS = HttpRequests(Config.getQuickSearchesURL());
  HttpRequests _httpReq = HttpRequests(Config.getNearestParksURL());
  MapsApi _mapsApi = MapsApi();
  List<String> _quickSearches = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Config.getQuickSearchLoaded()) {
      _quickSearches = QuickSearchSingleton.getInstance().getQuickSearches();
      _isLoading = false;
      return;
    }
    _fetchData().then((list) {
      setState(() {
        _quickSearches = list;
        _isLoading = false;
      });
    });
  }

  Future<List<String>> _fetchData() async {
    final lat_lng_list = await _httpQS.quickSearchGetRequest();
    print(lat_lng_list);

    List<String> quickSearches = [];
    for (int i = 0; i < lat_lng_list.length; i++) {
      String placeName =
          await _mapsApi.getNameFromCoordinates(latlng: lat_lng_list[i]);
      quickSearches.add(placeName);
    }
    QuickSearchSingleton.getInstance().setQuickSearches(quickSearches);
    Config.setQuickSearchLoaded(value: true);
    return quickSearches;
  }

  void _quickSearch(int index) {
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
    String adres = _quickSearches[index];
    String id = '';
    String dist = '';
    double lat = 0.0;
    double lng = 0.0;
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    _mapsApi.getIdFromAddress(adres).then(((value) {
      print(value);
      if (value == 'Address not found.') {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: value,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: CustomColors.middlePurple());
        return;
      }
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
            "district": district == '' ? value['district'] : district,
            "lat": "${value['latitude']}",
            "lng": "${value['longitude']}"
          };
          _httpReq.nearestParksPostRequest(data).then((value) {
            /*for (int i = 0; i < value.length; i++) {
              print(
                  'PARK ID: ${value[i]['parkID']}, PARK NAME: ${value[i]['parkName']}\n');
            }*/
            print("RESPONSE: ");
            print(value);

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
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => NearestParksPage()));
          });
        },
      );
    }));
  }

  //NEED TO WRITE A PROTOCOL TO DYNAMICALLY GET THE QUICK SEARHC SUGGESTIONS!!!
  final List<String> _staticQuickSearches = [
    "Barbaros Meydanı, Beşiktaş/Istanbul",
    "İTÜ Taşkışla Yerleşkesi, Beyoğlu/Istanbul",
    "Şükrü Saraçoğlu Stadyumu, Kadıköy/Istanbul",
    "Sabiha Gökçen Havalimanı, Pendik/Istanbul"
  ];

  void _makeQuickSearch(int index) {}

  @override
  Widget build(BuildContext context) {
    /*print("QUICK SEARCHES:");
    print(_quickSearches);*/
    if (_quickSearches.length < 4) {
      for (int i = _quickSearches.length; i < 4; i++) {
        _quickSearches.add(_staticQuickSearches[i]);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CustomColors.customGrey()),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _quickSearch(0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors.darkGrey(),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _quickSearches.elementAt(0),
                          style: TextStyle(
                              color: CustomColors.middlePurple(), fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _quickSearch(1);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _quickSearches.elementAt(1),
                          style: TextStyle(
                              color: CustomColors.middlePurple(), fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _quickSearch(2);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: CustomColors.darkGrey()),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _quickSearches.elementAt(2),
                          style: TextStyle(
                              color: CustomColors.middlePurple(), fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _quickSearch(3);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _quickSearches.elementAt(3),
                          style: TextStyle(
                              color: CustomColors.middlePurple(), fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
