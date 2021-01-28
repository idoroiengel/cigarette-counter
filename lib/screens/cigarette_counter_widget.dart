import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/components/add_cigarette_widget.dart';
import 'package:my_cigarette_counter/components/smoking_counter_drawer_widget.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/routes.dart';

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
      drawer: SmokingCounterDrawerWidget(
        // TODO implement an input for the String parameter in smokingContext
        onSmokingContextTapped: () => smokingContext(""),
        onTodayTapped: showToday,
        onYesterdayTapped: showYesterday,
      ),
      body: Center(
        child: AddCigaretteWidget(),
      ),
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
      Routes.today_statistics,
    );
  }

  void showYesterday() {
    Navigator.pushNamed(
      context,
      Routes.yesterday_statistics,
    );
  }

  void smokingContext(String context) {
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
              .getAllSmokedCigarettesInContext(context)
              .asStream());
    });
  }
}
