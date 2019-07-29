import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:gclone/routes/provider_config.dart';

import 'animations/animate_details.dart';
import 'helpers/animate_route.dart';
import 'helpers/charts/a_line_chart3.dart';
import 'models/provider_data.dart';

class DetailPage extends StatefulWidget {
  final ProviderData providerData;
  DetailPage({
    Key key,
    this.providerData,
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
      duration: const Duration(milliseconds: 1000),
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

    Widget topContentText() {
      return Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Hero(
                    tag: widget.providerData.key,
                    child: Icon(
                      widget.providerData.icon,
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
                    widget.providerData.provider,
                    style: TextStyle(
                        color: Colors.white
                            .withOpacity(animation.nameOpacity.value),
                        fontSize: 45.0),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Container(
              //padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.62,
              child: new Transform(
                transform: new Matrix4.translationValues(
                  0.0,
                  animation.chartPosition.value,
                  0.0,
                ),
                child: new Opacity(
                  opacity: animation.chartOpacity.value,
                  child: use_LineChart(animation),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget topContent() {
      return Stack(
        children: <Widget>[
          Container(
            //height: MediaQuery.of(context).size.,
            padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xFF424242)),
            child: Center(
              child: topContentText(),
            ),
          ),
          Positioned(
            left: 8.0,
            top: 5.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          )
        ],
      );
    }

    Widget backupResults() {
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFF424242), boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 5,
                  offset: Offset(0, -1),
                  blurRadius: 8)
            ]),
            child: Container(
              padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0x00424242)),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.providerData.level,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(flex: 8, child: levelIndicator),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    final bottomContentText = Text(
      widget.providerData.content,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white.withOpacity(animation.descriptionOpacity.value),
      ),
    );

    final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
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
              onPressed: () {
                Navigator.push(
                  context,
                  AnimateRoute(
                    fullscreenDialog: true,
                    builder: (context) => ProviderConfig(),
                  ),
                );
              },
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
        padding: EdgeInsets.fromLTRB(60.0, 30, 60, 60),
        child: Center(
          child: Column(
            children: <Widget>[
              bottomContentText,
              readButton,
            ],
          ),
        ),
      );
    }

    Widget _buildAnimation(BuildContext context, Widget child) {
      return new Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              child: topContent(),
            ),
          ),
          Expanded(
            flex: 1,
            child: backupResults(),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: bottomContent(),
            ),
          ),
        ],
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: new AnimatedBuilder(
          animation: animation.controller,
          builder: _buildAnimation,
        ),
      ),
    );
  }
}
