import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';

abstract class SmokingChoicesViewModel extends MainViewModel {

  Stream<List<SmokingContext>> get outputSmokingContext;

  Stream<List<SmokingReason>> get outputSmokingReason;

}