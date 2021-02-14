import 'dart:async';

import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/cigarette_counter_modal_bottom_sheet_view_model.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';

class CigaretteCounterModalBottomSheetViewModelImpl
    implements CigaretteCounterModalBottomSheetViewModel {
  @override
  // TODO: implement smokingContextChoice
  Sink get smokingContextChoice => throw UnimplementedError();

  @override
  // TODO: implement smokingReasonChoice
  Sink get smokingReasonChoice => throw UnimplementedError();

  @override
  // TODO: implement statisticsChoice
  Sink get statisticsChoice => throw UnimplementedError();

  @override
  // TODO: implement outputSmokingContext
  Stream<List<SmokingContext>> get outputSmokingContext =>
      Stream<List<SmokingContext>>.value(SmokingContext.values);

  @override
  // TODO: implement outputRecentCigarettes
  Stream<List<Cigarette>> get outputRecentCigarettes =>
      MainViewModel.database.getAllSmokedCigarettes().asStream().take(4);
}
