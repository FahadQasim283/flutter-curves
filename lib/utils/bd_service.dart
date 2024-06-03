import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:practice/utils/location.dart';

Future<void> intializeBgService() async {
  debugPrint('================>LINE:3');
  final FlutterBackgroundService service =
      FlutterBackgroundService(); // intialization of service
  // now configure service
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        autoStartOnBoot: true,
      ));
  await service.startService();
}

@pragma('vm-entry-point') //for use of native side code
Future<void> onStart(ServiceInstance serviceInstance) async {
  debugPrint('================>LINE:2');
  DartPluginRegistrant.ensureInitialized();
  if (serviceInstance is AndroidServiceInstance) {
    serviceInstance.on("setAsForeground").listen((event) async {
      await serviceInstance.setAsForegroundService();
      // Call the method when setting as foreground
      debugPrint('================>LINE:1');
      await startListeningToPositionStream();
    });
    serviceInstance.on("setAsBackground").listen((event) async {
      debugPrint('================>LINE:5');
      await serviceInstance.setAsBackgroundService();
      await startListeningToPositionStream();
    });
  }
  // serviceInstance.on('stopService').listen((event) async
  // {
  //   await serviceInstance.stopSelf();
  // });
  Timer(const Duration(seconds: 5), () async {
    if (serviceInstance is AndroidServiceInstance) {
      if (await serviceInstance.isForegroundService()) {
        debugPrint('================>LINE:6');
        await startListeningToPositionStream();
      }
    }
  });
}

Future<bool> isServiceRunning() async {
  final FlutterBackgroundService service = FlutterBackgroundService();
  return await service.isRunning();
}

Future<void> stopBgService() async {
  final FlutterBackgroundService service = FlutterBackgroundService();
  if (await isServiceRunning()) {
    if (stream != null) {
      await stream!.cancel();
      stream = null;
      return;
    }
  }
  service.invoke('stopService');
}
