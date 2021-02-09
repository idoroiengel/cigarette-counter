import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class SmokingStatisticsWidget extends StatefulWidget {
  final AppDatabase database;
  final SmokingStatisticsStatus status;

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
      return Container(child: todayStream());
    } else if (status == SmokingStatisticsStatus.YESTERDAY) {
      return Container(child: yesterdayStream());
    } else if (status == SmokingStatisticsStatus.DEFAULT) {
      return Container(child: allStream());
    }
    return null;
  }

  StreamBuilder<List<Cigarette>> allStream() {
    return StreamBuilder(
      initialData: [
        Cigarette(
            chainSmokingNum: 1,
            smokingContext: SmokingContext.home,
            timeOfSmoke: DateTime.now(),
            reasonToSmoke: SmokingReason.bedtimeCigarette)
      ],
      stream: widget.database.getAllSmokedCigarettes().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 1.0,
            ),
            children: populateTable(snapshot),
          );
        }
      },
    );
  }

  StreamBuilder<List<Cigarette>> yesterdayStream() {
    var jiffy = new Jiffy();
    return StreamBuilder(
      initialData: [
        Cigarette(
            chainSmokingNum: 1,
            smokingContext: SmokingContext.work,
            timeOfSmoke: DateTime.now(),
            reasonToSmoke: SmokingReason.bathroom)
      ],
      stream: widget.database
          .getAllSmokedCigarettesFromTo(
              jiffy.startOf(Units.DAY).subtract(Duration(days: 1)),
              jiffy.endOf(Units.DAY).subtract(Duration(days: 1)))
          .asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 1.0,
            ),
            children: populateTable(snapshot),
          );
        }
      },
    );
  }

  StreamBuilder<List<Cigarette>> todayStream() {
    var jiffy = new Jiffy();
    return StreamBuilder(
      initialData: [
        Cigarette(
            chainSmokingNum: 1,
            smokingContext: SmokingContext.goingOut,
            timeOfSmoke: DateTime.now(),
            reasonToSmoke: SmokingReason.hunger)
      ],
      stream: widget.database
          .getAllSmokedCigarettesFromTo(
              jiffy.startOf(Units.DAY), jiffy.endOf(Units.DAY))
          .asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 1.0,
            ),
            children: populateTable(snapshot),
          );
        }
      },
    );
  }

  TableRow titleRow() {
    return TableRow(
      children: [
        Container(
          child: Text(
            "time of smoke",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Text(
            "smoking context",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Text(
            "reason to smoke",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Text(
            "id",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  List<TableRow> populateTable(AsyncSnapshot snapshot) {
    Jiffy jiffy = new Jiffy(DateTime.now(), "yyyy-MM-dd");
    var list = List<TableRow>();
    list.add(titleRow());
    (snapshot.data as List<Cigarette>).forEach((element) {
      list.add(
        new TableRow(
          children: [
            Text(jiffy.from(element.timeOfSmoke)),
            Text(EnumToString.convertToString(element.smokingContext) ?? ""),
            Text(EnumToString.convertToString(element.reasonToSmoke) ?? ""),
            Text(element.id.toString())
          ],
        ),
      );
    });
    return list;
  }
}

enum SmokingStatisticsStatus {
  TODAY,
  YESTERDAY,
  LAST_WEEK,
  LAST_MONTH,
  DEFAULT
}
