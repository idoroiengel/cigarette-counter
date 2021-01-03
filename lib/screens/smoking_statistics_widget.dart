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
        padding: EdgeInsets.all(10.0),
        child: showStatistics(widget.status),
      ),
    );
  }

  Widget showStatistics(SmokingStatisticsStatus status) {
    if (status == SmokingStatisticsStatus.TODAY) {
      return todayStream();
    } else if (status == SmokingStatisticsStatus.YESTERDAY) {
      return yesterdayStream();
    } else if (status == SmokingStatisticsStatus.DEFAULT) {
      return allStream();
    }
    return null;
  }

  StreamBuilder<List<Cigarette>> allStream() {
    return StreamBuilder(
      initialData: [
        Cigarette(
            chainSmokingNum: 1,
            smokingContext: "smoking context",
            timeOfSmoke: DateTime.now(),
            reasonToSmoke: "reason to smoke")
      ],
      stream: widget.database.getAllSmokedCigarettes().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => populateTable(snapshot, index),
            itemCount: (snapshot.data as List<Cigarette>).length,
          );
        }
      },
    );
  }

  StreamBuilder<List<Cigarette>> yesterdayStream() {
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
          return ListView.builder(
            itemBuilder: (context, index) => populateTable(snapshot, index),
            itemCount: (snapshot.data as List<Cigarette>).length,
          );
        }
      },
    );
  }

  StreamBuilder<List<Cigarette>> todayStream() {
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
          return ListView.builder(
            itemCount: (snapshot.data as List<Cigarette>).length,
            itemBuilder: (context, index) => populateTable(snapshot, index),
          );
        }
      },
    );
  }
}

populateTable(snapshot, index) {
  Jiffy jiffy = new Jiffy(DateTime.now(), "yyyy-MM-dd");
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    border: TableBorder.all(
      color: Colors.black,
      width: 1.0,
    ),
    children: [
      TableRow(
        children: [
          Text(jiffy
              .from((snapshot.data as List<Cigarette>)[index].timeOfSmoke)),
          Text((snapshot.data as List<Cigarette>)[index].smokingContext),
          Text((snapshot.data as List<Cigarette>)[index].reasonToSmoke),
          Text((snapshot.data as List<Cigarette>)[index].id.toString()),
        ],
      ),
    ],
  );
}

enum SmokingStatisticsStatus {
  TODAY,
  YESTERDAY,
  LAST_WEEK,
  LAST_MONTH,
  DEFAULT
}
