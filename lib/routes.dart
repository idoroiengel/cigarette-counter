import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/screens/cigarette_counter_widget.dart';
import 'package:my_cigarette_counter/screens/smoking_statistics_widget.dart';

class Routes {
  static const String today_statistics = '/statistics_today';
  static const String yesterday_statistics = '/statistics_yesterday';
  static const String cigarette_counter = '/cigarette_counter';

  static Map<String, WidgetBuilder> getRoutes(AppDatabase database) {
    return {
      Routes.cigarette_counter: (context) => CigaretteCounterWidget(
            database: database,
          ),
      Routes.today_statistics: (context) => SmokingStatisticsWidget(
            database: database,
            status: SmokingStatisticsStatus.TODAY,
          ),
      Routes.yesterday_statistics: (context) => SmokingStatisticsWidget(
            database: database,
            status: SmokingStatisticsStatus.YESTERDAY,
          ),
    };
  }
}
