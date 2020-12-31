import 'dart:async';

import 'package:floor/floor.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/dao/cigarette_dao.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/type_converters/date_time_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Cigarette])
@TypeConverters([DateTimeConverter])
abstract class AppDatabase extends FloorDatabase {
  CigaretteDao get _cigaretteDao;


  void initWithMOckData(){
    _cigaretteDao.insertCigarette(Cigarette(
      chainSmokingNum: 1,
      reasonToSmoke: "I felt like it",
      smokingContext: "testing",
      timeOfSmoke: Jiffy().startOf(Units.MONTH)
    ));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I felt like it",
        smokingContext: "testing",
        timeOfSmoke: Jiffy().endOf(Units.MONTH)
    ));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I felt like it",
        smokingContext: "testing",
        timeOfSmoke: Jiffy().startOf(Units.WEEK)
    ));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I felt like it",
        smokingContext: "testing",
        timeOfSmoke: Jiffy().endOf(Units.WEEK)
    ));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I felt like it",
        smokingContext: "testing",
        timeOfSmoke: Jiffy().startOf(Units.DAY)
    ));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I felt like it",
        smokingContext: "testing",
        timeOfSmoke: Jiffy().endOf(Units.DAY)
    ));
  }

  Future<void> addCigarette(Cigarette cigarette) async {
    return _cigaretteDao.insertCigarette(cigarette);
  }

  Future<List<Cigarette>> getAllSmokedCigarettes() async {
    return _cigaretteDao.getAllSmokedCigarettes();
  }

  Future<Cigarette> getCigarette(int id) async {
    return _cigaretteDao.getCigarette(id);
  }

  Future<List<Cigarette>> getAllSmokedCigarettesFromTo(int from, int to){
    return _cigaretteDao.getAllSmokedCigarettesFromTo(from, to);
  }

  Future<void> initDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final cigaretteDao = database._cigaretteDao;
  }
}
