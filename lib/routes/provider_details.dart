import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone/animations/animate_provider.dart';
import 'package:gclone/models/provider_data.dart';

class ProviderDetails extends StatefulWidget {
  final ProviderData providerData;
  ProviderDetails({
    Key key,
    this.providerData,
  }) : super(key: key);
  @override
  _ProviderDetailsState createState() => _ProviderDetailsState();
}

class _ProviderDetailsState extends State<ProviderDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
    var animation = new ProviderAnimation(_controller);

    Widget topContent() {
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
              width: MediaQuery.of(context).size.width * 0.25,
              child: new Transform(
                transform: new Matrix4.translationValues(
                  0.0,
                  animation.chartPosition.value,
                  0.0,
                ),
                child: new Opacity(
                    opacity: animation.chartOpacity.value,
                    child: Text("Sup?") //use_LineChart(),
                    ),
              ),
            ),
          ],
        ),
      );
    }

    Widget bottomContent() {
      return Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.5,

        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
        child: Center(
          child: Column(
            children: <Widget>[
              // --------------------------------------------------- Content ---
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
        body: new AnimatedBuilder(
          animation: animation.controller,
          builder: _buildAnimation,
        ),
      ),
    );
  }
}
