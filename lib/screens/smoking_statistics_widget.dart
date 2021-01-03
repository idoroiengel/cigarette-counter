import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class SmokingStatisticsWidget extends StatefulWidget {
  AppDatabase database;
  SmokingStatisticsStatus status;

  SmokingStatisticsWidget({this.database, @required this.status});

  @override
  _SmokingStatisticsWidgetState createState() =>
      _SmokingStatisticsWidgetState();
}

class _SmokingStatisticsWidgetState extends State<SmokingStatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Smoking statistics",
        ),
      ),
      body: Container(
        child: showStatistics(widget.status),
      ),
    );
  }

  Widget getArguments(BuildContext context) {
    return StreamBuilder(
      initialData: [
        Cigarette(
            chainSmokingNum: 1,
            smokingContext: "smoking context",
            timeOfSmoke: DateTime.now(),
            reasonToSmoke: "reason to smoke")
      ],
      stream: widget.database
          .getAllSmokedCigarettesFromTo(
            Jiffy().startOf(Units.DAY).subtract(Duration(days: 1)),
            Jiffy().endOf(Units.DAY).subtract(Duration(days: 1)),
          )
          .asStream(),
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

  Widget showStatistics(SmokingStatisticsStatus status) {
    if (status == SmokingStatisticsStatus.TODAY) {
      return StreamBuilder(
        initialData: [
          Cigarette(
              chainSmokingNum: 1,
              smokingContext: "smoking context",
              timeOfSmoke: DateTime.now(),
              reasonToSmoke: "reason to smoke")
        ],
        stream: widget.database
            .getAllSmokedCigarettesFromTo(
                Jiffy().startOf(Units.DAY), Jiffy().endOf(Units.DAY))
            .asStream(),
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
                return Text(
                    (snapshot.data as List<Cigarette>)[index].toString());
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
            );
          }
        },
      );
    } else if (status == SmokingStatisticsStatus.YESTERDAY) {
      return StreamBuilder(
        initialData: [
          Cigarette(
              chainSmokingNum: 1,
              smokingContext: "smoking context",
              timeOfSmoke: DateTime.now(),
              reasonToSmoke: "reason to smoke")
        ],
        stream: widget.database
            .getAllSmokedCigarettesFromTo(
              Jiffy().startOf(Units.DAY).subtract(Duration(days: 1)),
              Jiffy().endOf(Units.DAY).subtract(Duration(days: 1)),
            )
            .asStream(),
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
                return Text(
                    (snapshot.data as List<Cigarette>)[index].toString());
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
            );
          }
        },
      );
    }
    return null;
  }
}

enum SmokingStatisticsStatus {
  TODAY,
  YESTERDAY,
  LAST_WEEK,
  LAST_MONTH
}
