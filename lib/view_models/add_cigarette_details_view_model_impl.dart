import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/view_models/add_cigarette_details_view_model.dart';
import 'package:my_cigarette_counter/view_models/main_view_model.dart';

class AddCigaretteDetailsViewModelImpl implements AddCigaretteDetailsViewModel {
  @override
  Stream<int> inputAddCigarette(Cigarette cigarette) =>
      MainViewModel.database.addCigarette(cigarette).asStream();
}
