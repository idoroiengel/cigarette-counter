import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';

abstract class SmokingStatisticsViewModel extends MainViewModel {
  Stream<List<Cigarette>> get todaySmokedCigarettes;

  Stream<List<Cigarette>> get yesterdaySmokedCigarettes;

  Stream<List<Cigarette>> get allSmokedCigarettes;

  Stream<List<Cigarette>> cigarettesBySmokingContext(
      SmokingContext smokingContext);
}
