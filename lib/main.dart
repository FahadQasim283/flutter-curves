import 'dart:async';
import 'package:flutter/material.dart';
import 'package:practice/utils/bd_service.dart';
import 'package:practice/utils/location.dart';
import 'package:practice/view/main-view/menue.dart';

Future<void> main() async {
 
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
