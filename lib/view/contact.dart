import 'package:flutter/material.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    debugPrint('============= height $height ... width $width==========');
    return Scaffold(
      appBar: AppBar(
          title: const Text('ContactView'), automaticallyImplyLeading: false),
      body: Center(
          child: Column(
        children: [
          ClipPath(
              clipper: CustomCurve(),
              child: Container(
                height: height * 0.24,
                width: double.infinity,
                color: Colors.amber,
              )),
          Expanded(
            child: Container(
              color: Colors.teal,
            ),
          ),
        ],
      )),
    );
  }
}

class CustomCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    final hf = h * 0.5;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, h - hf);
    path.quadraticBezierTo(w * 0.25, h, w * 0.5, h - hf);
    path.quadraticBezierTo(w * 0.75, h - (hf * 2), w, h-hf);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

extension Space on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
