import 'package:floor/floor.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';


@dao
abstract class CigaretteDao {

  @insert
  Future<void> insertCigarette(Cigarette cigarette);

  @Query("SELECT * FROM Cigarette WHERE id= :id")
  Future<Cigarette> getCigarette(int id);

  @Query("SELECT * FROM Cigarette")
  Future<List<Cigarette>> getAllSmokedCigarettes();

}