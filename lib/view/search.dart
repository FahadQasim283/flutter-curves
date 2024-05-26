import 'package:flutter/material.dart';
import 'package:practice/main.dart';
import 'package:practice/utils/bd_service.dart';
import 'package:practice/utils/sharedpref.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List lts = [];
  List longs = [];
  List timeStmp = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lts = MySharedPrefference.getLats();
    longs = MySharedPrefference.getLongs();
    timeStmp = MySharedPrefference.getTimeStamp();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
              },
              child: const Text("Initialize  Service"),
            ),
            ElevatedButton(
              onPressed: () async {
                await MySharedPrefference.clear();
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
                  onTap: () {},
                  title: Text(
                      "Latitude: ${lts[index]}  Longitude: ${longs[index]}"),
                  subtitle: Text("Time: ${timeStmp[index]}"),
                  leading: CircleAvatar(child: Text('${index + 1}'))));
        },
      ),
    );
  }
}
