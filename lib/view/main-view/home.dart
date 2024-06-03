import 'dart:ui';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget customMenuList() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          InkWell(
            onTap: () {
              isOpend = isOpend ? false : true;
              setState(() {});
            },
            child: Card(
                color: const Color.fromARGB(255, 243, 235, 235),
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(selectedText),
                )),
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 244, 237, 237),
                border: Border.all(color: const Color.fromARGB(19, 0, 0, 0))),
            curve: Curves.bounceOut,
            onEnd: () {},
            duration: const Duration(seconds: 1),
            height: isOpend ? 240 : 0,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(items.length, (index) {
                    return InkWell(
                        onTap: () {
                          selectedText = items[index];
                          isOpend = false;
                          setState(() {});
                        },
                        child: getItem(index));
                  })),
            ),
          ),
        ]),
      ),
    );
  }

  List<String> items = const [
    "Computer Scirence",
    "Mathematics",
    "Physics",
    "Chemistary",
    "English",
  ];
  Widget getItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(items[index]),
    );
  }

  String selectedText = "Select an Option";
  bool isOpend = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text('HomeView'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            customMenuList(),
            CustomPaint(
              painter: PantagonePainter(),
              size: const Size(200, 100),
            ),
            ...List.generate(
              messagesList.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomPaint(
                    painter: MessageBubble(
                        color: messagesList[index].isMe
                            ? const Color(0xffE3D4EE)
                            : const Color(0xffDAF0F3),
                        alignment: messagesList[index].isMe
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        tail: true),
                    child: Container(
                      height: 100,
                      width: 200,
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .7,
                      ),
                      child: const Text("data"),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PantagonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.teal;
    Path path = Path();

    const double borderRadius = 40.0; // Adjust the border radius as needed
    final double h = size.height;
    final  double w = size.width;

    path.moveTo(borderRadius, 0);
    path.lineTo(w - borderRadius, 0);
    path.arcToPoint(
      Offset(w, borderRadius),
      radius: const Radius.circular(borderRadius),
      clockwise: true,
    );

    path.lineTo(w, h - borderRadius);
    path.arcToPoint(
      Offset(w - borderRadius, size.height),
      radius: const Radius.circular(borderRadius),
      clockwise: true,
    );

    path.lineTo(borderRadius, h);
    path.arcToPoint(
      Offset(0, h-10),
      radius: const Radius.circular(100),
      clockwise: true,
    );
    path.lineTo(20, h-10);
    

    //top left
    path.lineTo(20, borderRadius);
    path.arcToPoint(
      const Offset(borderRadius + 20, 0),
      radius: const Radius.circular(borderRadius),
      clockwise: true,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// creating bubble
class MessageBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  MessageBubble({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    if (alignment == Alignment.topRight) {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right bubble curve
        path.quadraticBezierTo(
            w - _radius * 1.5, h, w - _radius * 1.5, h - _radius * 0.6);

        /// bottom-right tail curve 1
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            w - _radius * 0.8, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);

        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right curve
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);
        // bottom-right tail curve 1
        path.quadraticBezierTo(_radius * .8, h, 0, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            _radius * 1, h, _radius * 1.5, h - _radius * 0.6);

        /// bottom-left bubble curve
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        /// bottom-left curve
        path.quadraticBezierTo(_radius, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue)!,
      lerpDouble(begin!.top, end!.top, elasticCurveValue)!,
      lerpDouble(begin!.right, end!.right, elasticCurveValue)!,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue)!,
    );
  }
}

List<MessageModel> messagesList = [
  //adding data into model for Today date
  MessageModel(
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      message:
          'Hello Today Message and testing long thread for this i hope this will work',
      isMe: true),
  MessageModel(
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      message: 'Hello Today Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      message: 'Hello Today Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      message: 'Hello Today Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      message: 'Hello Today Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      message: 'Hello Today Message',
      isMe: false),

  //adding data into model for yesterday date
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1, 11, 30)
          .microsecondsSinceEpoch,
      message: 'Yesterday Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1, 11, 30)
          .microsecondsSinceEpoch,
      message: 'Yesterday Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1, 11, 30)
          .microsecondsSinceEpoch,
      message: 'Yesterday Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Yesterday Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Yesterday Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Yesterday Message',
      isMe: false),

  //adding data into model date
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 2, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 2, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 2, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 2, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 2, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: true),

  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 3, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 3, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 3, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 3, 14, 30)
          .microsecondsSinceEpoch,
      message: 'Some Message',
      isMe: true),

  MessageModel(
      timeStamp: DateTime(2023, 02, 08, 15, 20).microsecondsSinceEpoch,
      message: 'Feb 8th Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(2023, 02, 08, 15, 20).microsecondsSinceEpoch,
      message: 'Feb 8th Message',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(2023, 02, 08, 15, 20).microsecondsSinceEpoch,
      message: 'Feb 8th Message',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(2023, 01, 20, 15, 20).microsecondsSinceEpoch,
      message: '20 JanMessage',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(2023, 01, 20, 15, 20).microsecondsSinceEpoch,
      message: '20 JanMessage',
      isMe: false),
  MessageModel(
      timeStamp: DateTime(2023, 01, 20, 15, 20).microsecondsSinceEpoch,
      message: '20 JanMessage',
      isMe: true),
  MessageModel(
      timeStamp: DateTime(2023, 01, 20, 15, 20).microsecondsSinceEpoch,
      message: '20 JanMessage',
      isMe: false),
];

class MessageModel {
  int timeStamp;
  String message;
  bool isMe;
  MessageModel(
      {required this.timeStamp, required this.message, required this.isMe});
}
