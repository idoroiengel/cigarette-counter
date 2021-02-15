import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/smoking_statistics_view_model_impl.dart';

class SmokingStatisticsWidget extends StatefulWidget {
  final SmokingStatisticsStatus status;

  SmokingStatisticsWidget({@required this.status});

  @override
  _SmokingStatisticsWidgetState createState() =>
      _SmokingStatisticsWidgetState();
}

class _SmokingStatisticsWidgetState extends State<SmokingStatisticsWidget> {
  SmokingStatisticsViewModelImpl _smokingStatisticsViewModelImpl;
  var routeData;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: ScreenUtil.defaultSize, allowFontScaling: false);
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text(
              "Smoking Statistics",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
            padding: EdgeInsets.only(top: 10),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: showStatistics(widget.status),
          ),
        ],
      ),
    );
  }

  Widget showStatistics(SmokingStatisticsStatus status) {
    if (status == SmokingStatisticsStatus.TODAY) {
      return Container(
          child: loadStreamData(
              _smokingStatisticsViewModelImpl.todaySmokedCigarettes));
    } else if (status == SmokingStatisticsStatus.YESTERDAY) {
      return Container(
          child: loadStreamData(
              _smokingStatisticsViewModelImpl.yesterdaySmokedCigarettes));
    } else if (status == SmokingStatisticsStatus.DEFAULT) {
      return Container(
          child: loadStreamData(
              _smokingStatisticsViewModelImpl.allSmokedCigarettes));
    } else if (status == SmokingStatisticsStatus.SMOKING_CONTEXT) {
      return Container(
          child: loadStreamData(_smokingStatisticsViewModelImpl
              .cigarettesBySmokingContext(routeData)));
    } else if (status == SmokingStatisticsStatus.SMOKING_REASON) {
      return Container(
          child: loadStreamData(_smokingStatisticsViewModelImpl
              .cigaretteBySmokingReason(routeData)));
    }
    return null;
  }

  StreamBuilder<List<Cigarette>> loadStreamData(
      Stream<List<Cigarette>> stream) {
    return StreamBuilder(
      initialData: [
        Cigarette(
          chainSmokingNum: 1,
          smokingContext: SmokingContext.home,
          timeOfSmoke: DateTime.now(),
          reasonToSmoke: SmokingReason.bedtimeCigarette,
        )
      ],
      stream: stream,
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
            Text(
              EnumToString.convertToString(
                    element.smokingContext,
                    camelCase: true,
                  ) ??
                  "",
            ),
            Text(
              EnumToString.convertToString(
                    element.reasonToSmoke,
                    camelCase: true,
                  ) ??
                  "",
            ),
            Text(element.id.toString())
          ],
        ),
      );
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    _smokingStatisticsViewModelImpl = SmokingStatisticsViewModelImpl();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeData = ModalRoute.of(context).settings.arguments;
  }
}

enum SmokingStatisticsStatus {
  TODAY,
  YESTERDAY,
  LAST_WEEK,
  LAST_MONTH,
  DEFAULT,
  SMOKING_CONTEXT,
  SMOKING_REASON,
}
