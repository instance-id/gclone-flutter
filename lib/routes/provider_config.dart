import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone/animations/animate_provider.dart';

class ProviderConfig extends StatefulWidget {
  @override
  _ProviderConfigState createState() => _ProviderConfigState();
}

class _ProviderConfigState extends State<ProviderConfig>
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
      return Stack(
        children: <Widget>[
          // ------------------------------------------------------- Content ---

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

    Widget bottomContent() {
      return Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.fromLTRB(60.0, 30, 60, 60),
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
