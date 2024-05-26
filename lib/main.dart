import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice/utils/bd_service.dart';
import 'package:practice/utils/sharedpref.dart';
import 'package:practice/view/menue.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPrefference.init();
  await checkLocationPermission();
  await intializeBgService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MySharedPrefference.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practice',
      theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: true),
      home: const MenueView(),
    );
  }
}

const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  // distanceFilter: 30,
);

Future<void> saveCoordinates(String lats, String longs) async {
  try {
    await MySharedPrefference.setLongs(lats);
    await MySharedPrefference.setLongs(longs);
    debugPrint('==> added  $lats,$longs');
  } catch (e) {
    debugPrint('==> ---$e');
  }
}

Future<void> startListeningToPositionStream() async {
  debugPrint('==>LINE:=>[]enter in,,,,,,');
  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
    saveCoordinates(
        position.latitude.toString(), position.longitude.toString());
    print(position == null
        ? 'Unknown'
        : '${position.latitude.toString()}, ${position.longitude.toString()}');
  });
}

Future<bool> isPermissionDenied() async {
  LocationPermission permission = await Geolocator.checkPermission();
  return permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever ||
      permission == LocationPermission.unableToDetermine;
}

Future<void> checkLocationPermission() async {
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
