import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/routes.dart';
import 'package:my_cigarette_counter/components/smoking_counter_drawer_widget.dart';

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
      drawer: SmokingCounterDrawerWidget(
        onSmokingContextTapped: smokingContext,
        onTodayTapped: showToday,
        onYesterdayTapped: showYesterday,
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
    Navigator.pushNamed(
      context,
      Routes.Today_Statistics,
    );
  }

  void showYesterday() {
    Navigator.pushNamed(
      context,
      Routes.Yesterday_Statistics,
    );
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
