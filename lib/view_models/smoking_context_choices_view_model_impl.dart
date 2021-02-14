import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/smoking_context_choices_view_model.dart';

class SmokingContextChoicesViewModelImpl implements SmokingContextChoicesViewModel{
  @override
  // TODO: implement outputSmokingContext
  Stream<List<SmokingContext>> get outputSmokingContext => Stream.value(SmokingContext.values);

}