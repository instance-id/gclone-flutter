import 'package:flutter/material.dart';
import 'package:gclone/animations/animate_provider.dart';
import 'package:gclone/models/get_data.dart';
import 'package:gclone/models/provider_data.dart';
import 'package:gclone/routes/provider_list.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

ProviderData providerDataDetails;

class ProviderDetails extends StatefulWidget {
  ProviderDetails();

  setDetails(ProviderData pData) {
    providerDataDetails = pData;
  }

  @override
  _ProviderDetailsState createState() => _ProviderDetailsState();
}

class _ProviderDetailsState extends State<ProviderDetails>
    with SingleTickerProviderStateMixin {
  final Logger log = new Logger('_ProviderDetailsState');

  AnimationController _detailsController;
  ProviderAnimation animation;

  void initState() {
    _detailsController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _detailsController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animation = new ProviderAnimation(_detailsController);

    var data = Provider.of<GetDataPlugin>(context);

    topContent(context, data) {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(45, 0, 5, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                // --------------------------------------------------------------- Left side top

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
//                  Hero(
//                    tag: data.selectedProvider.providerID.toString(),
                  Icon(
                    currentProvider.icon,
                    color: Colors.white,
                    size: 90.0,
//                    ),
//                    //createRectTween: _createRectTween,
                  ),
                  Container(
                    width: animation.dividerWidth.value,
                    child: new Divider(
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${currentProvider.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white
                            .withOpacity(animation.nameOpacity.value),
                        fontSize: 45.0),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Container(
              // ----------------------------------------------------------------- Right side top
              width: MediaQuery.of(context).size.width * 0.20,
              child: new Transform(
                transform: new Matrix4.translationValues(
                  0.0,
                  animation.chartPosition.value,
                  0.0,
                ),
                child: new Opacity(
                  opacity: animation.chartOpacity.value,
                  child: Text(
                    '${currentProvider.providerID}',
                  ), //use_LineChart(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    bottomContent(context, GetDataPlugin data) {
      return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                // --------------------------------------------------------------- Add new button
                width: MediaQuery.of(context).size.width * 0.30,
                child: RaisedButton(
                  child: Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Add new remote provider",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xDDFFFFFF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  elevation: 5,
                  onPressed: () {
                    log.shout(
                        'SHOUTING FROM DETAILS ${providerDataDetails.providerID}');
                  },
                ),
              ),
              // ----------------------------------------------------------------- Content
            ],
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                child: topContent(context, data),
              ),
            ),
            Expanded(
              child: Container(
                child: bottomContent(context, data),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
