import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'domain.dart';

class StatusCard extends StatefulWidget {
  StatusCard({Key key}) : super(key: key);

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  SpotStatus spotStatus = null;
  TextStyle h1 = kFilledStyles["h1"];
  TextStyle p = kFilledStyles['p'];
  String iconPath = 'assets/icons/filled.png';

  void fetchSpotStatus() async {
    var spotStatusRes = await http
        .get('https://us-central1-baywatch-6dd1b.cloudfunctions.net/status');

    setState(() {
      spotStatus = new SpotStatus(spotStatusRes.body);

      if (spotStatus.status == 'empty') {
        h1 = kEmptyStyles["h1"];
        p = kEmptyStyles["p"];
        iconPath = 'assets/icons/empty.png';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSpotStatus();
  }

  @override
  Widget build(BuildContext context) {
    print('spot status $spotStatus');
    return Container(
      height: 195,
      width: 195,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
          color: kColors["black1"],
          boxShadow: [BoxShadow()]),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (spotStatus == null)
              ? CircularProgressIndicator()
              : Image.asset(iconPath),
          (spotStatus == null)
              ? Text(
                  "loading...",
                  style: h1,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spotStatus.status,
                      style: h1,
                    ),
                    Text(
                      'last change: ${spotStatus.happened}',
                      style: p,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
