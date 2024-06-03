import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart'
    as andoirdsettings;
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart'
    as settings;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:practice/utils/sharedpref.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   requestPermissions();
//   //   checkGPSStatus(); // Check GPS status on app start
//   // }
//   static const String _isolateName = "LocatorIsolate";
//   ReceivePort port = ReceivePort();

//   @override
//   void initState() {
//     super.initState();
//     IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
//     port.listen((dynamic data) {
//       // do something with data
//       debugPrint('DATA $data');
//     });
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     requestPermissions();
//     await BackgroundLocator.initialize();
//     startLocationService();
//   }

//   Future<void> requestPermissions() async {
//     if (await Permission.locationAlways.request().isGranted) {
//       await initPlatformState();
//     }
//   }

//   void callback(LocationDto locationDto) async {
//     String lats = locationDto.latitude.toString();
//     String longs = locationDto.longitude.toString();
//     DateTime now = DateTime.now();
//     debugPrint('==>LATS $lats');
//     debugPrint('==>LONGS $longs');
//     debugPrint('==>TIME $now');
//     await setCoordinates(
//         latitude: lats, longitude: longs, timeStamp: now.toString());
//     if (now.hour >= 18 || now.hour < 8) {
//       // Handle night time logic, pausing updates if necessary
//     } else {
//       // Handle day time logic, continue uploading data
//       await checkAndPushData(lats, longs, now);
//     }
//     await triggerGPSNotification();
//   }

//   // void notificationCallback() async{
//   //   // Handle notification click if needed
//   //  await triggerGPSNotification();
//   // }

//   Future<void> checkAndPushData(
//       String lats, String longs, DateTime time) async {
//     // Your existing checkAndPushData logic here
//   }

//   // Future<void> initPlatformState() async {
//   //   await BackgroundLocator.initialize();
//   //   // Register location updates
//   //   await BackgroundLocator.registerLocationUpdate(
//   //     callback,
//   //     initCallback: ,
//   //     disposeCallback: notificationCallback,
//   //     // iosSettings: IOSSettings(
//   //     //   accuracy: LocationAccuracy.HIGH,
//   //     //   distanceFilter: 50,
//   //     // ),
//   //     androidSettings: const andoirdsettings.AndroidSettings(
//   //       accuracy: settings.LocationAccuracy.HIGH,
//   //       interval: 1000,
//   //       // distanceFilter: 50,
//   //       androidNotificationSettings:
//   //           andoirdsettings.AndroidNotificationSettings(
//   //         notificationChannelName: 'Location tracking',
//   //         notificationTitle: 'Background location tracking',
//   //         notificationMsg: 'Track location in background',
//   //         notificationIcon: '@mipmap/ic_launcher',
//   //       ),
//   //     ),
//   //     autoStop: false,
//   //   );
//   // }

//   // Future<void> checkGPSStatus() async {
//   //   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!isLocationServiceEnabled) {
//   //     // GPS is disabled, trigger notification
//   //     await triggerGPSNotification();
//   //   }
//   // }

//   // Future<void> triggerGPSNotification() async {
//   //   FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
//   //   plugin.show(
//   //       9889,
//   //       "GPS Disabled",
//   //       "Please enable GPS for accurate location tracking.",
//   //       const NotificationDetails(
//   //         android: AndroidNotificationDetails(
//   //           "QMS-ID",
//   //           "QMS",
//   //           channelDescription: "QMS",
//   //           importance: Importance.max,
//   //           icon: "ic_bg_service_small",
//   //           ongoing: true,
//   //           sound: UriAndroidNotificationSound("pop"),
//   //         ),
//   //       ));
//   // }
//   @pragma('vm:entry-point')
//   static void callback(LocationDto locationDto) async {
//     final SendPort? send = IsolateNameServer.lookupPortByName(_isolateName);
//     send?.send(locationDto);
//   }

// //Optional
  @pragma('vm:entry-point')
  static void initCallback(dynamic _) {
    print('Plugin initialization');
    FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
    plugin.show(
        9889,
        "GPS Disabled",
        "Please enable GPS for accurate location tracking.",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "QMS-ID",
            "QMS",
            channelDescription: "QMS",
            importance: Importance.max,
            icon: "ic_bg_service_small",
            ongoing: true,
            sound: UriAndroidNotificationSound("pop"),
          ),
        ));
  }

  static const String _isolateName = "LocatorIsolate";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  ReceivePort port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
    port.listen((data) {
      try {
        LocationDto locationDto = data as LocationDto;
        String lats = locationDto.latitude.toString();
        String longs = locationDto.longitude.toString();
        DateTime now = DateTime.now();
        debugPrint('==>LATS $lats');
        debugPrint('==>LONGS $longs');
        debugPrint('==>TIME $now');
        setCoordinates(
            latitude: lats, longitude: longs, timeStamp: now.toString());
        if (now.hour >= 18 || now.hour < 8) {
          // Handle night time logic, pausing updates if necessary
        } else {
          // Handle day time logic, continue uploading data
          // checkAndPushData(lats, longs, now);
        }
        // triggerGPSNotification();
      } catch (e) {
        debugPrint('THISI ISSISI $e');
      }
    });
    // initPlatformState();
  }

  Future<void> initPlatformState() async {
    await requestPermissions();
    await BackgroundLocator.initialize();
    startLocationService();
  }

  Future<void> requestPermissions() async {
    if (await Permission.locationAlways.request().isGranted) {
      await initPlatformState();
    }
  }

  @pragma('vm:entry-point')
  static void callback(Future<LocationDto> locationDto) async {
    try {
      final SendPort? send = IsolateNameServer.lookupPortByName(_isolateName);
      send!.send(() async {
        await locationDto;
      });
    } catch (e) {
      debugPrint('ERRRRRRRRRRRRRRROR $e');
    }
  }

  // @pragma('vm:entry-point')
  // static void initCallback(dynamic _) async {
  //   FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  //   plugin.initialize(
  //     const InitializationSettings(
  //       android: AndroidInitializationSettings('@drawable/ic_launcher'),
  //       // iOS: IOSInitializationSettings(),
  //     ),
  //   );
  //   plugin.show(
  //       9889,
  //       "GPS Disabled",
  //       "Please enable GPS for accurate location tracking.",
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails("QMS-ID", "QMS",
  //               channelDescription: "QMS",
  //               importance: Importance.max,
  //               icon: "ic_launcher", // Replace with your icon name
  //               ongoing: true,
  //               sound: UriAndroidNotificationSound("pop"))));
  // }

  // @pragma('vm:entry-point')
  // static void notificationCallback() async {
  //   FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  //   await plugin.initialize(const InitializationSettings(
  //       android: AndroidInitializationSettings('@drawable/ic_launcher'),
  //     ));
  //   plugin.show(
  //       9889,
  //       "GPS Disabled",
  //       "Please enable GPS for accurate location tracking.",
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails("QMS-ID", "QMS",
  //             channelDescription: "QMS",
  //             importance: Importance.max,
  //             icon: "ic_launcher", // Replace with your icon name
  //             ongoing: true,
  //             sound: UriAndroidNotificationSound("pop")),
  //       ));
  // }
// Optional
  @pragma('vm:entry-point')
  static void notificationCallback() {
    print('User clicked on the notification');
    FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
    plugin.show(
        9889,
        "GPS Disabled",
        "Please enable GPS for accurate location tracking.",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "QMS-ID",
            "QMS",
            channelDescription: "QMS",
            importance: Importance.max,
            icon: "ic_bg_service_small",
            ongoing: true,
            sound: UriAndroidNotificationSound("pop"),
          ),
        ));
  }

  void startLocationService() {
    BackgroundLocator.registerLocationUpdate(callback as void Function(LocationDto p1),
        initCallback: initCallback,
        // initDataCallback: data,
        // disposeCallback:  LocationCallbackHandler.disposeCallback,
        autoStop: false,
        androidSettings: const andoirdsettings.AndroidSettings(
            accuracy: settings.LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIcon: '',
                notificationIconColor: Colors.grey,
                notificationTapCallback: notificationCallback)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Background Locator 2 Example'),
        ),
        body: Center(
          child: Text('Tracking location in background...'),
        ),
      ),
    );
  }
}
