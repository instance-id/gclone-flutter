import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'animations/animate_details.dart';
import 'models/lesson.dart';

class DetailPage extends StatefulWidget {
  final Lesson lesson;
  DetailPage({
    Key key,
    this.lesson,
  }) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var animation = new DetailsAnimation(_controller);

    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            value: animation
                .completionValue.value, // widget.lesson.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15.0),
        Hero(
          tag: widget.lesson.key,
          child: Icon(
            widget.lesson.icon,
            color: Colors.white,
            size: 90.0,
          ),
          //createRectTween: _createRectTween,
        ),
        Container(
          width: animation.dividerWidth.value,
          child: new Divider(
            color: Colors.green,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.lesson.title,
          style: TextStyle(
              color: Colors.white.withOpacity(animation.nameOpacity.value),
              fontSize: 45.0),
        ),
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 2, child: levelIndicator),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.lesson.level,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    Widget topContent() {
      return Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.all(60.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xFF424242)),
            child: Center(
              child: topContentText,
            ),
          ),
          Positioned(
            left: 8.0,
            top: 5.0,
            child: InkWell(
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          )
        ],
      );
    }

    final bottomContentText = Text(
      widget.lesson.content,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white.withOpacity(animation.descriptionOpacity.value),
      ),
    );
    final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: new Transform(
        transform: new Matrix4.translationValues(
          animation.buttonXTranslation.value,
          0.0,
          0.0,
        ),
        child: new Opacity(
          opacity: animation.videoScrollerOpacity.value,
          child: new SizedBox.fromSize(
            size: new Size.fromHeight(50.0),
            child: RaisedButton(
              onPressed: () => {},
              color: Color(0xFF424242),
              child: Text(
                "Configure this provider",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Widget bottomContent() {
      return Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.fromLTRB(60.0, 20, 60, 60),
        child: Center(
          child: Column(
            children: <Widget>[bottomContentText, readButton],
          ),
        ),
      );
    }

    Widget _buildAnimation(BuildContext context, Widget child) {
      return new Column(
        children: <Widget>[
          new Opacity(
            opacity: animation.backdropOpacity.value,
            child: topContent(),
          ),
          new Opacity(
            opacity: animation.backdropOpacity.value,
            child: bottomContent(),
          ),
        ],
      );
    }

    return Scaffold(
      body: new AnimatedBuilder(
        animation: animation.controller,
        builder: _buildAnimation,
      ),
    );
  }
}
