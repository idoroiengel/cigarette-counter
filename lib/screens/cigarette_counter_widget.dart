import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class CigaretteCounterWidget extends StatefulWidget {
  AppDatabase database;

  CigaretteCounterWidget({this.database});

  @override
  _CigaretteCounterWidgetState createState() => _CigaretteCounterWidgetState();
}

class _CigaretteCounterWidgetState extends State<CigaretteCounterWidget> {
  Widget activeView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cigarette counter"),
      ),
      drawer: Drawer(
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
              onTap: showToday,
            ),
            ListTile(
              title: Text(
                "second tile",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () => widget.database.addCigarette(
          Cigarette(
            timeOfSmoke: DateTime.now(),
            smokingContext: "adding a cigarette to test system",
            reasonToSmoke: "test system",
            chainSmokingNum: 1,
          ),
        ),
        child: Text("smoke a cigarette"),
      ),
      body: Container(child: activeView),
    );
  }

  Cigarette showCigarette() {
    Cigarette returnValue;
    widget.database
        .getCigarette(2)
        .then((value) => {
              returnValue = value,
              print(value.reasonToSmoke),
            })
        .catchError((error) => {
              print("no cigarettes yet!"),
            });
    return returnValue;
  }

  @override
  void initState() {
    super.initState();
    activeView = StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Text((snapshot.data as List<Cigarette>)[index].toString());
          },
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          // itemCount: 2,
          itemCount: (snapshot.data as List<Cigarette>).length,
        );
      },
      stream: widget.database.getAllSmokedCigarettes().asStream(),
    );
  }

  void showToday() {
    setState(() {
      activeView = StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return Text(
                    (snapshot.data as List<Cigarette>)[index].toString());
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
              itemCount: (snapshot.data as List<Cigarette>).length,
            );
          },
          stream: widget.database
              .getAllSmokedCigarettesFromTo(
                  Jiffy().startOf(Units.DAY).microsecondsSinceEpoch,
                  Jiffy().endOf(Units.DAY).microsecondsSinceEpoch)
              .asStream());
    });
  }
}
