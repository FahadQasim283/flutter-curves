import'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

 @override
State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsView'),
        automaticallyImplyLeading: false
      ),
      body: const Center(
        child: Text('SettingsView'),
      ),
    );
  }
}