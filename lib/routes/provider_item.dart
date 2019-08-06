import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone/models/get_data.dart';
import 'package:gclone/models/provider_data.dart';
import 'package:gclone/models/stepper/stepper_settings.dart';
import 'package:gclone/routes/provider_list.dart';
import 'package:provider/provider.dart';

class ProviderListItem extends StatefulWidget {
  final ProviderData _providerData;
  final GetDataPlugin data;

  ProviderListItem(this._providerData, this.data);

  @override
  _ProviderListItemState createState() => _ProviderListItemState();
}

class _ProviderListItemState extends State<ProviderListItem> {
  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataPlugin>(context);
    var stepper = Provider.of<StepperSetting>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(30, 2, 5, 2),
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            stepper.stepContinue();
            stepper.setSelectedProvider(widget._providerData);
            data.setCurrentDetails(widget._providerData.providerID);
            currentProvider = data.getCurrentDetails();

            print('Provider pressed : ${widget._providerData.providerID}');
            print(
                'Provider set in get_date : ${data.getCurrentDetails().providerID}');

            //_launchURL(repo.htmlUrl);
          },
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.red,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
//                      child: Hero(
//                        createRectTween: _createRectTween,
//                        tag: _providerData[index],
                      child: Icon(
                        (widget._providerData.icon != null)
                            ? widget._providerData.icon
                            : '',
                      ),
                    ),
//                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(widget._providerData.name,
                          style: Theme.of(context).textTheme.subhead),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                      widget._providerData.note != null
                          ? widget._providerData.note
                          : 'No desription',
                      style: Theme.of(context).textTheme.body1),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
//                      Expanded(
////                        child: ,
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
