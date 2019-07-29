import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone/animations/animate_provider.dart';
import 'package:gclone/models/provider_data.dart';
import 'package:gclone/routes/provider_details.dart';
import 'package:gclone/routes/provider_item.dart';

class ProviderList extends StatefulWidget {
  @override
  _ProviderListState createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList>
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
    //var _providerList = Provider.of<ProviderData>(context).providerList;
    var list = new ProviderData();
    var _providerList = getProviderList();
    Widget providerList() {
      return new Container(
        child: new ListView.builder(
          itemCount: _providerList.length,
          itemBuilder: (BuildContext context, int index) {
            var provider = _providerList[index];

            return ProviderListItem(provider);
          },
        ),
      );
    }

    Widget topContentData() {
      return Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height,
                  child: providerList(),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.fromLTRB(5, 5, 25, 0),
                child: ProviderDetails(),
              ),
            ),
          ],
        ),
      );
    }

    Widget topContent() {
      return Stack(
        children: <Widget>[
          Positioned(
            left: 8.0,
            top: 5.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFF424242), boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 5,
                      offset: Offset(0, -1),
                      blurRadius: 8)
                ]),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Center(
                    child: Text(
                      "Select a storage provider",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              topContentData(),
            ],
          ),
        ],
      );
    }

    Widget _buildAnimation(BuildContext context, Widget child) {
      return new Container(
        child: topContent(),
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
