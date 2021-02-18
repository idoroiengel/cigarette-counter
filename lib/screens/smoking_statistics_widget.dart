import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_cigarette_counter/components/cigarette_details_widget.dart';
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
      appBar: AppBar(
        title: Text(showTitle()),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: showStatistics(widget.status),
      ),
    );
  }

  String showTitle() {
    switch (widget.status) {
      case SmokingStatisticsStatus.DEFAULT:
        return "All smoked cigarettes";
        break;
      case SmokingStatisticsStatus.TODAY:
        return "Sorted by date: Today";
        break;
      case SmokingStatisticsStatus.YESTERDAY:
        return "Sorted by date: Yesterday";
        break;
      case SmokingStatisticsStatus.LAST_WEEK:
        return "Sorted by date: Last Week";
        break;
      case SmokingStatisticsStatus.LAST_MONTH:
        return "Sorted by date: Last Month";
        break;
      case SmokingStatisticsStatus.SMOKING_CONTEXT:
        return "Sorted by context: " +
            EnumToString.convertToString(routeData, camelCase: true);
        break;
      case SmokingStatisticsStatus.SMOKING_REASON:
        return "Sorted by reason: " +
            EnumToString.convertToString(routeData, camelCase: true);
        break;
    }
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
          // TODO implement scenario where there are no cigarettes for selected cigarette detail
          return ListView.builder(
            itemBuilder: (context, index) {
              return CigaretteDetailsWidget(
                cigarette: snapshot.data[index],
              );
            },
            itemCount: (snapshot.data as List).length,
          );
        }
      },
    );
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
