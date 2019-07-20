import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

import '../helpers/tab_item.dart';

class TabMenu extends StatefulWidget {
  final ValueChanged<int> onChanged;

  TabMenu({Key key, @required this.onChanged}) : super(key: key);

  @override
  TabMenuState createState() => TabMenuState();
}

class TabMenuState extends State<TabMenu> with TickerProviderStateMixin {
  AnimationController _animationController;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;

  AnimationController _fadeOutController;
  Animation<double> _fadeFabOutAnimation;
  Animation<double> _fadeFabInAnimation;

  double fabIconAlpha = 1;
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 1;

  void move(int idx) {
    switch (idx) {
      case 0:
        navScheduleJobs();
        break;
      case 1:
        navRemotes();
        break;
      case 2:
        navJobStatus();
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIM_DURATION));
    _fadeOutController = AnimationController(
        vsync: this, duration: Duration(milliseconds: (ANIM_DURATION ~/ 5)));

    _positionTween = Tween<double>(begin: 0, end: 0);
    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _fadeFabOutAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabOutAnimation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    _fadeFabInAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabInAnimation.value;
        });
      });
  }

  void navScheduleJobs() {
    setState(() {
      nextIcon = Icons.clear_all;
      currentSelected = 0;
    });

    _initAnimationAndStart(_positionAnimation.value, -1);
  }

  void navRemotes() {
    setState(() {
      nextIcon = Icons.insert_chart;
      currentSelected = 1;
    });

    _initAnimationAndStart(_positionAnimation.value, 0);
  }

  void navJobStatus() {
    setState(() {
      nextIcon = Icons.shopping_cart;
      currentSelected = 2;
    });

    _initAnimationAndStart(_positionAnimation.value, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppColors.PRIMARY_LIGHT,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 65,
            margin: EdgeInsets.only(top: 45),
            decoration:
                BoxDecoration(color: Color.fromRGBO(35, 35, 35, 1), boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 5,
                  offset: Offset(0, -1),
                  blurRadius: 8)
            ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TabItem(
                    selected: currentSelected == 0,
                    iconData: Icons.home,
                    title: "SCHEDULE JOBS",
                    callbackFunction: () {
                      navScheduleJobs();
                      widget.onChanged(0);
                    }),
                TabItem(
                    selected: currentSelected == 1,
                    iconData: Icons.search,
                    title: "REMOTES",
                    callbackFunction: () {
                      navRemotes();
                      widget.onChanged(1);
                    }),
                TabItem(
                    selected: currentSelected == 2,
                    iconData: Icons.person,
                    title: "JOB STATUS",
                    callbackFunction: () {
                      navJobStatus();
                      widget.onChanged(2);
                    })
              ],
            ),
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Align(
                heightFactor: 1,
                alignment: Alignment(_positionAnimation.value, 0),
                child: FractionallySizedBox(
                  widthFactor: 1 / 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: ClipRect(
                            clipper: HalfClipper(),
                            child: Container(
                              child: Center(
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color:
                                            // --- Above Circle -----------------------------------
                                            Color.fromRGBO(175, 175, 175, 0.8),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              // --- Above circle shadow --------------------------
                                              color:
                                                  Color.fromRGBO(1, 1, 1, 0.5),
                                              offset: Offset(0, -1),
                                              spreadRadius: 4,
                                              blurRadius: 8)
                                        ])),
                              ),
                            )),
                      ),
                      SizedBox(
                          height: 70,
                          width: 90,
                          child: CustomPaint(
                            painter: HalfPainter(),
                          )),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // --------- Main Circle --------------------------------------------
                              color: Color(0xffacacac),
                              //color: Color(0xFF484848),
                              border: Border.all(
                                  // ----------- Inner circle ring --------------------------------
                                  color: Color.fromRGBO(30, 30, 30, 0.6),
                                  width: 3,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Opacity(
                              opacity: fabIconAlpha,
                              child: Icon(
                                activeIcon,
                                // --- Middle Icon ------------------------------------------------
                                color: Color(0xcc454449),
                                //color: Color(0xcc82b9ff),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
        Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();
    canvas.drawPath(
      path, // --- Background Upper Ring ---------------------------------------
      Paint()..color = Color.fromRGBO(15, 15, 15, 0.5),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
