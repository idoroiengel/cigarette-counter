import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/screens/cigarette_counter_widget.dart';
import 'package:my_cigarette_counter/screens/smoking_statistics_widget.dart';

class Routes {
  static const String Today_Statistics = '/statistics_today';
  static const String Yesterday_Statistics = '/statistics_yesterday';
  static const String CigaretteCounter = '/cigarette_counter';

  static Map<String, WidgetBuilder> getRoutes(AppDatabase database) {
    return {
      Routes.CigaretteCounter: (context) => CigaretteCounterWidget(
            database: database,
          ),
      Routes.Today_Statistics: (context) => SmokingStatisticsWidget(
            database: database,
            status: SmokingStatisticsStatus.TODAY,
          ),
      Routes.Yesterday_Statistics: (context) => SmokingStatisticsWidget(
            database: database,
            status: SmokingStatisticsStatus.YESTERDAY,
          ),
    };
  }
}
