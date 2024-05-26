import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:practice/main.dart';

Future<void> intializeBgService() async {
  
  final FlutterBackgroundService service =
      FlutterBackgroundService(); // intialization of service

  //creating channel for android
  // AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //   "channle-id",
  //   "channel-name",
  //   description: "channel-description",
  //   importance: Importance.high,
  //   enableVibration: true,
  //   playSound: true,
  //   showBadge: true,
  // );

  // FlutterLocalNotificationsPlugin plugin =
  //     FlutterLocalNotificationsPlugin(); //creating plugin
  //initializing plugin for android and adding created channel
  // await plugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()!
  //     .createNotificationChannel(channel);

  // now configure service
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        autoStartOnBoot: true,
        // notificationChannelId: "channle-id",
        // initialNotificationTitle: "shake and send SMS",
        // initialNotificationContent: "initailizing shake feature",
        // foregroundServiceNotificationId: 8888,
      ));
  await service.startService();
}

@pragma('vm-entry-point') //for use of native side code
Future<void> onStart(ServiceInstance serviceInstance) async {
  DartPluginRegistrant.ensureInitialized();
  // FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  if (serviceInstance is AndroidServiceInstance) {
    serviceInstance.on("setAsForeground").listen((event) async {
      await serviceInstance.setAsForegroundService();
      // Call the method when setting as foreground
      await startListeningToPositionStream();
    });
    serviceInstance.on("setAsBackground").listen((event) async {
      await serviceInstance.setAsBackgroundService();
      // Call the method when setting as foreground
      await startListeningToPositionStream();
    });
  }
  serviceInstance.on('stopService').listen((event) async {
    await serviceInstance.stopSelf();
  });
  Timer(const Duration(seconds: 3), () async {
    if (serviceInstance is AndroidServiceInstance) {
      if (await serviceInstance.isForegroundService()) {
        await startListeningToPositionStream();
      }
    }
  });
}
