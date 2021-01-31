import 'package:floor/floor.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/type_converters/date_time_converter.dart';
import 'package:my_cigarette_counter/type_converters/smoking_context_converter.dart';
import 'package:my_cigarette_counter/type_converters/smoking_reason_converter.dart';

@dao
@TypeConverters([DateTimeConverter, SmokingReasonConverter, SmokingContextConverter])
abstract class CigaretteDao {
  @insert
  Future<int> insertCigarette(Cigarette cigarette);

  @Query("SELECT * FROM Cigarette WHERE id= :id")
  Future<Cigarette> getCigarette(int id);

  @Query("SELECT * FROM Cigarette")
  Future<List<Cigarette>> getAllSmokedCigarettes();

  @Query(
      "SELECT * FROM Cigarette WHERE timeOfSmoke BETWEEN :startDate AND :endDate")
  Future<List<Cigarette>> getAllSmokedCigarettesFromTo(
      DateTime startDate, DateTime endDate);

  @Query("SELECT * FROM Cigarette WHERE smokingContext = :smokingContext")
  Future<List<Cigarette>> getAlSmokedCigarettesInContext(SmokingContext smokingContext);
}
