import 'package:flutter/material.dart';
import 'package:practice/view/menue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practice',
      theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: true),
      home: const MenueView(),
      // initialRoute:/
      // onGenerateRoute: GenerateRoutes.generateRoutes,
    );
  }
}
