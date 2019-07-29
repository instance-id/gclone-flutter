import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone/models/provider_data.dart';

class ProviderListItem extends StatelessWidget {
  final ProviderData _providerData;

  ProviderListItem(this._providerData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 2, 5, 2),
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            //_launchURL(repo.htmlUrl);
          },
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.red,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_providerData.name,
                    style: Theme.of(context).textTheme.subhead),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                      _providerData.note != null
                          ? _providerData.note
                          : 'No desription',
                      style: Theme.of(context).textTheme.body1),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Icon(
                          (_providerData.icon != null)
                              ? _providerData.icon
                              : '',
                        ),
                      )
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
