import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice/utils/sharedpref.dart';

const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.medium,
  // distanceFilter: 50,
);

StreamSubscription<Position>? stream;
bool isDataUploaded = false;
Future<void> startListeningToPositionStream() async {
  try {
    debugPrint('==>LINE:=>[]enter in,,,,,,');
    stream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) async {
      try {
        final DateTime now = DateTime.now();
        final DateTime pauseTime =
            DateTime(now.year, now.month, now.day, 19); // 6 PM
        final DateTime resumeTime =
            DateTime(now.year, now.month, now.day, 5); // 8 AM next day
        debugPrint('current time : $now');
        debugPrint('pause time : $pauseTime');
        debugPrint('resume time : $resumeTime');
        if (now.isAfter(pauseTime) || now.isBefore(resumeTime)) {
          debugPrint('== Stream should be paused');
          stream!.pause();
          debugPrint('---is paused ${stream!.isPaused}');
          // Schedule a periodic timer to check if the time has passed
          if (stream!.isPaused) {
            // await Firebase.initializeApp();
            // await checkAndPushData();
            debugPrint('before updating the pause.........');
            Timer.periodic(const Duration(seconds: 10), (timer) async {
              debugPrint('paused.. now ... updating.........');
              if (!isDataUploaded) {
                debugPrint('paused....');
                // await Firebase.initializeApp();
                // await checkAndPushData();
              }
              final DateTime currentTime = DateTime.now();
              if (currentTime.isAfter(resumeTime) &&
                  currentTime.isBefore(pauseTime)) {
                stream!.resume();
                debugPrint('--->>>>>>>>>>>>>>is paused ${stream!.isPaused}');
                timer.cancel();
              }
            });
          }
          debugPrint('${position.latitude.toString()}, ${position.longitude}');
        } else {
          if (!stream!.isPaused) {
            debugPrint('streaming.....');
            await setCoordinates(
                    latitude: position.latitude.toString(),
                    longitude: position.longitude.toString(),
                    timeStamp: DateTime.now().toString())
                .then(
              (value) {
                debugPrint('data add to sp successfully');
              },
            ).onError(
              (error, stackTrace) {
                debugPrint('==>error in sp .... $error');
              },
            );
          }
        }
      } catch (e) {
        debugPrint('==>....$e');
      }
    })
      ..onError((e) async {
        debugPrint('==>...nmn...$e');
        if (stream!.isPaused) {
          debugPrint('==>stream paused .$e');
        } else {
          debugPrint('==>stream not paused.$e');
          await checkLocationPermission();
        }
      });
  } catch (e) {
    debugPrint('==> --->$e');
  }
}

Future<bool> isPermissionDenied() async {
  LocationPermission permission = await Geolocator.checkPermission();
  return permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever ||
      permission == LocationPermission.unableToDetermine;
}

Future<void> checkLocationPermission() async 
{
  try {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (await isPermissionDenied()) {
      debugPrint('==>LINE: Not Permitted..  requesting');
      await Geolocator.requestPermission();
      if (!isLocationServiceEnabled) await Geolocator.openLocationSettings();
    }
    if (!isLocationServiceEnabled) {
      debugPrint('service not opened');
      await Geolocator.openLocationSettings();
    } else {
      debugPrint('>>>Location permission allowed...service also enable');
    }
  } catch (e) {
    debugPrint('==>LINE:$e');
  }
}

// Future<void> uploadData() async {
//   FirebaseRepository repository = FirebaseRepository();
//   await Firebase.initializeApp();
//   try {
//     List<String> coordinates = await getCoordinates();
//     debugPrint('==>.... &$coordinates');
//     if (await checkInternetConnection()) {
//       if (coordinates.isNotEmpty) {
//         debugPrint('==> &ehehhe');
//         await repository.addLocationToDb(coordinates).then(
//           (value) async {
//             debugPrint('+++++++\t\t\t\tcleared sp coordinate.....');
//             await clearCoordinates();
//             isDataUploaded = true;
//             debugPrint('+++++++\t\t\tsp coordinate cleared.....');
//           },
//         );
//       }
//     }
//     // Send success message to the main thread
//   } catch (e) {
//     // Send failure message to the main thread
//     isDataUploaded = false;
//     debugPrint('==>LINE:=>[]$e');
//   }
// }

// Future<void> checkAndPushData() async {
//   if (await checkInternetConnection() && await getCoordinates() != []) {
//     uploadData();
//   }
// }
