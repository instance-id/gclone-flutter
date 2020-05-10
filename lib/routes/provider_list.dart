import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone_flutter/animations/animate_provider.dart';
import 'package:gclone_flutter/models/get_data.dart';
import 'package:gclone_flutter/models/provider_data.dart';
import 'package:gclone_flutter/models/stepper/stepper_settings.dart';
import 'package:gclone_flutter/routes/provider_details.dart';
import 'package:gclone_flutter/routes/provider_item.dart';
import 'package:provider/provider.dart';

ProviderData currentProvider = new ProviderData();
bool hasBuilt = false;

class ProviderList extends StatefulWidget {
  const ProviderList({Key key}) : super(key: key);

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
    var data = Provider.of<GetDataPlugin>(context);
    var stepperData = Provider.of<StepperSetting>(context);

    ProviderDetails().setDetails(currentProvider);

    Widget _providerList() {
      return new Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        // --------------------------------------------------------------------- List Builder
        child: new ListView.builder(
          itemCount: data.providerList.length,
          itemBuilder: (BuildContext context, int index) {
            if (!hasBuilt) {
              currentProvider = data.providerList[index];
              stepperData.setInitialSelectedProvider(currentProvider);
              hasBuilt = true;
            }
            return ProviderListItem(data.providerList[index], data);
          },
        ),
      );
    }

    Widget topContentData() {
      return Container(
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // ------------------------------------------------------------- Provider List
                Container(
                  height: MediaQuery.of(context).size.height * 1 - 155,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: _providerList(),
                ),
              ],
            ),
            Expanded(
              // --------------------------------------------------------------- Provider Details
              child: Container(
                height: MediaQuery.of(context).size.height * 1 - 155,
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.fromLTRB(5, 5, 25, 0),
                child: ProviderDetails(),
              ),
            )
          ],
        ),
      );
    }

    Widget topContent() {
      return Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                width: MediaQuery.of(context).size.width,
//                height: 55,
//                decoration: BoxDecoration(color: Color(0xFF424242), boxShadow: [
//                  BoxShadow(
//                      color: Colors.black26,
//                      spreadRadius: 5,
//                      offset: Offset(0, -1),
//                      blurRadius: 8)
//                ]),
//                child: Container(
//                  // ----------------------------------------------------------- Page Title
//                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                  child: Center(
//                    child: Text(
//                      "Select a storage provider",
//                      style: TextStyle(
//                        fontFamily: 'Roboto',
//                        fontWeight: FontWeight.w300,
//                        fontSize: 22,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
              topContentData(),
            ],
          ),
//          Positioned(
//            left: 15.0,
//            top: 17.0,
//            child: InkWell(
//              onTap: () {
//                Navigator.of(context).pop();
//              },
//              child: Icon(Icons.arrow_back, color: Colors.white),
//            ),
//          ),
        ],
      );
    }

    Widget _buildAnimation(BuildContext context, Widget child) {
      return new Container(
        color: Color(0xff303030),
        child: topContentData(), // topContent(),
      );
    }

    return AnimatedBuilder(
      animation: animation.controller,
      builder: _buildAnimation,
    );
  }
}
