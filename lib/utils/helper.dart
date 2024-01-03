import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class NotificationHelper {
  // Nesnemizi oluşturduk
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    const androidInitialize =
        AndroidInitializationSettings("mipmap/ic_launcher");
    const initializationsSettings =
        InitializationSettings(android: androidInitialize);

    await _notifications.initialize(initializationsSettings);
  }

  static Future _notificationDetails() async => const NotificationDetails(
        android: AndroidNotificationDetails(
          "end journey",
          "closest parks",
          importance: Importance.max,
        ),
      );

  // Normal bildirim gösterme.
  static Future showNotification({
    int id = 0,
    required String title,
    required String body,
    required String payload, // bildirime extra veri eklemek istersek
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}

class Helpers {
  static String correctDistrictName(String district) {
    String corrected = '';

    if (district == 'ŞIŞLI')
      corrected = 'ŞİŞLİ';
    else if (district == 'ZEYTINBURNU')
      corrected = 'ZEYTİNBURNU';
    else if (district == 'BEYLIKDÜZÜ')
      corrected = 'BEYLİKDÜZÜ';
    else if (district == 'SILIVRI')
      corrected = 'SİLİVRİ';
    else if (district == 'BAŞAKŞEHIR')
      corrected = 'BAŞAKŞEHİR';
    else if (district == 'SULTANGAZI')
      corrected = 'SULTANGAZİ';
    else if (district == 'ÜMRANIYE')
      corrected = 'ÜMRANİYE';
    else if (district == 'ŞILE')
      corrected = 'ŞİLE';
    else if (district == 'PENDIK')
      corrected = 'PENDİK';
    else if (district == 'FATIH')
      corrected = 'FATİH';
    else if (district == 'KÂĞITHANE')
      corrected = 'KAĞITHANE';
    else if (district == 'BAHÇELIEVLER')
      corrected = 'BAHÇELİEVLER';
    else if (district == 'GAZIOSMANPAŞA')
      corrected = 'GAZİOSMANPAŞA';
    else if (district == 'ATAŞEHIR')
      corrected = 'ATAŞEHİR';
    else if (district == 'BEŞIKTAŞ')
      corrected = 'BEŞİKTAŞ';
    else if (district == 'SULTANBEYLI') corrected = 'SULTANBEYLİ';

    return corrected == '' ? district : corrected;
  }

  static Future<Map<String, double>> selfLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var location = await Geolocator.getCurrentPosition();
    return {"latitude": location.latitude, "longitude": location.longitude};
  }
}
