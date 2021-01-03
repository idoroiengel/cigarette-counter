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
                "yesterday",
              ),
              onTap: showYesterday,
            ),
            ListTile(
              title: Text(
                "smoking context",
              ),
              onTap: smokingContext,
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
      stream: widget.database.getAllSmokedCigarettes().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView.separated(
            itemCount: (snapshot.data as List<Cigarette>).length,
            itemBuilder: (context, index) {
              return Text((snapshot.data as List<Cigarette>)[index].toString());
            },
            separatorBuilder: (context, index) => Divider(color: Colors.black),
          );
        }
      },
    );
  }

  void showToday() {
    setState(() {
      activeView = StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.separated(
              itemCount: (snapshot.data as List<Cigarette>).length,
              itemBuilder: (context, index) {
                return Text(
                    (snapshot.data as List<Cigarette>)[index].toString());
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
            );
          },
          stream: widget.database
              .getAllSmokedCigarettesFromTo(
                  Jiffy().startOf(Units.DAY), Jiffy().endOf(Units.DAY))
              .asStream());
    });
  }

  void showYesterday() {
    setState(() {
      activeView = StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.separated(
              itemCount: (snapshot.data as List<Cigarette>).length,
              itemBuilder: (context, index) {
                return Text(
                    (snapshot.data as List<Cigarette>)[index].toString());
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
            );
          },
          stream: widget.database
              .getAllSmokedCigarettesFromTo(
                  Jiffy().startOf(Units.DAY).subtract(Duration(days: 1)),
                  Jiffy().endOf(Units.DAY).subtract(Duration(days: 1)))
              .asStream());
    });
  }

  void smokingContext() {
    setState(() {
      activeView = StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.separated(
              itemCount: (snapshot.data as List<Cigarette>).length,
              itemBuilder: (context, index) {
                return Text(
                    (snapshot.data as List<Cigarette>)[index].toString());
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
            );
          },
          stream: widget.database
              .getAllSmokedCigarettesInContext("start of day")
              .asStream());
    });
  }
}
