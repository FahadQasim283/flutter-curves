import 'package:flutter/material.dart';
import 'package:practice/view/contact.dart';
import 'package:practice/view/home.dart';
import 'package:practice/view/search.dart';
import 'package:practice/view/settings.dart';

class MenueView extends StatefulWidget {
  const MenueView({super.key});

  @override
  State<MenueView> createState() => _MenueViewState();
}

class _MenueViewState extends State<MenueView> {
  int pageIndex = 0;
  List screens = const [
    ContactView(),
    HomeView(),
    SearchView(),
    SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomSheet: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 234, 74, 53),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(icons.length, (index) {
            bool matched = pageIndex == index;
            return Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: matched ? const Color.fromARGB(77, 0, 0, 0) : null),
                child: getIcon(
                    index: index,
                    color: matched ? Colors.white  : Colors.black));
          }),
        ),
      ),
    );
  }

  List<IconData> icons = [
    Icons.search,
    Icons.home,
    Icons.add_box,
    Icons.settings
  ];
  IconButton getIcon({required int index, required Color color}) {
    return IconButton(
        onPressed: () {
          pageIndex = index;
          setState(() {});
        },
        icon: Icon(icons[index], color: color));
  }
}
