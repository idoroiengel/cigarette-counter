import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';

abstract class CigaretteCounterModalBottomSheetViewModel extends MainViewModel{

  Sink get statisticsChoice;
  Sink get smokingReasonChoice;
  Sink get smokingContextChoice;

  // TODO move this field with impl to PickTimeOrReasonViewModel (temp name)
  Stream<List<SmokingContext>> get outputSmokingContext;

  Stream<List<Cigarette>> get outputRecentCigarettes;
}