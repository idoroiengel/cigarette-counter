import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';
import 'package:my_cigarette_counter/view_models/smoking_statistics_view_model.dart';

class SmokingStatisticsViewModelImpl implements SmokingStatisticsViewModel {
  @override
  Stream<List<Cigarette>> get todaySmokedCigarettes =>
      MainViewModel.database
          .getAllSmokedCigarettesFromTo(
          Jiffy().startOf(Units.DAY), Jiffy().endOf(Units.DAY))
          .asStream();

  @override
  Stream<List<Cigarette>> get yesterdaySmokedCigarettes =>
      MainViewModel.database
          .getAllSmokedCigarettesFromTo(
          Jiffy().startOf(Units.DAY).subtract(Duration(days: 1)),
          Jiffy().endOf(Units.DAY).subtract(Duration(days: 1)))
          .asStream();

  @override
  Stream<List<Cigarette>> cigarettesBySmokingContext(
      SmokingContext smokingContext) =>
      MainViewModel.database
          .getAllSmokedCigarettesInContext(smokingContext)
          .asStream();

  @override
  // TODO: implement allSmokedCigarettes
  Stream<List<Cigarette>> get allSmokedCigarettes =>
      MainViewModel.database.getAllSmokedCigarettes().asStream();

  @override
  Stream<List<Cigarette>> cigaretteBySmokingReason(
      SmokingReason smokingReason) =>
      MainViewModel.database.getAllSmokedCigarettesByReason(smokingReason)
          .asStream();
}
