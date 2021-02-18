import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';

abstract class CigaretteCounterModalBottomSheetViewModel extends MainViewModel {
  Stream<List<Cigarette>> get outputRecentCigarettes;
}
