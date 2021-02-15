import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/smoking_choices_view_model.dart';

class SmokingChoicesViewModelImpl implements SmokingChoicesViewModel{
  @override
  // TODO: implement outputSmokingContext
  Stream<List<SmokingContext>> get outputSmokingContext => Stream.value(SmokingContext.values);

  @override
  Stream<List<SmokingReason>> get outputSmokingReason => Stream.value(SmokingReason.values);

}