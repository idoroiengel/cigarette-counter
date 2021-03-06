import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/screens/add_cigarette_details_widget.dart';
import 'package:my_cigarette_counter/screens/cigarette_counter_widget.dart';
import 'package:my_cigarette_counter/screens/smoking_choices_widget.dart';
import 'package:my_cigarette_counter/screens/smoking_statistics_widget.dart';

class Routes {
  static const String today_statistics = '/statistics_today';
  static const String yesterday_statistics = '/statistics_yesterday';
  static const String smoking_context_statistics =
      '/smoking_context_statistics';
  static const String smoking_reason_statistics = '/smoking_reason_statistics';
  static const String cigarette_counter = '/cigarette_counter';
  static const String add_cigarette_details = '/add_cigarette_details';
  static const String smoking_context_choices = '/smoking_context_choices';
  static const String smoking_reason_choices = '/smoking_reason_choices';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.cigarette_counter: (context) => CigaretteCounterWidget(),
      Routes.today_statistics: (context) => SmokingStatisticsWidget(
            status: SmokingStatisticsStatus.TODAY,
          ),
      Routes.yesterday_statistics: (context) => SmokingStatisticsWidget(
            status: SmokingStatisticsStatus.YESTERDAY,
          ),
      Routes.smoking_context_statistics: (context) => SmokingStatisticsWidget(
            status: SmokingStatisticsStatus.SMOKING_CONTEXT,
          ),
      Routes.smoking_reason_statistics: (context) => SmokingStatisticsWidget(
            status: SmokingStatisticsStatus.SMOKING_REASON,
          ),
      Routes.add_cigarette_details: (context) => AddCigaretteDetailsWidget(),
      Routes.smoking_context_choices: (context) => SmokingChoicesWidget(
            routeArguments: "smokingContext",
          ),
      Routes.smoking_reason_choices: (context) => SmokingChoicesWidget(
            routeArguments: "smokingReason",
          ),
    };
  }
}
