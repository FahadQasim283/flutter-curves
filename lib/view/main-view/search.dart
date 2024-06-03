import 'package:flutter/material.dart';
import 'package:practice/utils/location.dart';
import 'package:practice/utils/sharedpref.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List lts = [];

  getLatsLongs() async {
    lts = await getCoordinates();
  }

  @override
  void initState() {
    getLatsLongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () async {},
              child: const Text("Initialize  Service"),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {});
              },
              child: const Text("Clear Preferences"),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: lts.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  onTap: () {
                    
                  },
                  title: Text("${lts[index]}"),
                  leading: CircleAvatar(child: Text('${index + 1}'))));
        },
      ),
    );
  }
}
