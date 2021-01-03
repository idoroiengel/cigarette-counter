import 'package:flutter/material.dart';

class SmokingCounterDrawerWidget extends Drawer {
  SmokingCounterDrawerWidget({
    this.onSmokingContextTapped,
    this.onTodayTapped,
    this.onYesterdayTapped,
  });

  final Function onSmokingContextTapped;
  final Function onYesterdayTapped;
  final Function onTodayTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              "statistics",
            ),
          ),
          ListTile(
            title: Text(
              "today",
            ),
            onTap: onTodayTapped,
          ),
          ListTile(
            title: Text(
              "yesterday",
            ),
            onTap: onYesterdayTapped,
          ),
          ListTile(
            title: Text(
              "smoking context",
            ),
            onTap: onSmokingContextTapped,
          ),
        ],
      ),
    );
  }
}
