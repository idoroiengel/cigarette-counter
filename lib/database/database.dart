import 'dart:async';

import 'package:floor/floor.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/dao/cigarette_dao.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/type_converters/date_time_converter.dart';
import 'package:my_cigarette_counter/type_converters/smoking_context_converter.dart';
import 'package:my_cigarette_counter/type_converters/smoking_reason_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Cigarette])
@TypeConverters([DateTimeConverter, SmokingReasonConverter, SmokingContextConverter])
abstract class AppDatabase extends FloorDatabase {
  CigaretteDao get _cigaretteDao;

  void initWithMockData() {
    var jiffy = new Jiffy();
    var cigarette1 = new Cigarette(
        timeOfSmoke: jiffy.startOf(Units.DAY),
        chainSmokingNum: 1,
        smokingContext: SmokingContext.busStop,
        reasonToSmoke: SmokingReason.bathroom);
    var cigarette2 = new Cigarette(
        timeOfSmoke: jiffy.startOf(Units.DAY),
        chainSmokingNum: 1,
        smokingContext: SmokingContext.friends,
        reasonToSmoke: SmokingReason.boring);
    var cigarette3 = new Cigarette(
        timeOfSmoke: jiffy.startOf(Units.DAY),
        chainSmokingNum: 1,
        smokingContext: SmokingContext.goingOut,
        reasonToSmoke: SmokingReason.food);
    addCigarette(cigarette1);
    addCigarette(cigarette2);
    addCigarette(cigarette3);
  }

  Future<int> addCigarette(Cigarette cigarette) async {
    return _cigaretteDao.insertCigarette(cigarette);
  }

  Future<List<Cigarette>> getAllSmokedCigarettes() async {
    return _cigaretteDao.getAllSmokedCigarettes();
  }

  Future<Cigarette> getCigarette(int id) async {
    return _cigaretteDao.getCigarette(id);
  }

  Future<List<Cigarette>> getAllSmokedCigarettesFromTo(
      DateTime from, DateTime to) {
    return _cigaretteDao.getAllSmokedCigarettesFromTo(from, to);
  }

  Future<List<Cigarette>> getAllSmokedCigarettesInContext(
      SmokingContext smokingContext) {
    return _cigaretteDao.getAlSmokedCigarettesInContext(smokingContext);
  }

  Future<List<Cigarette>> getAllSmokedCigarettesByReason(SmokingReason smokingReason){
    return _cigaretteDao.getAllSmokedCigarettesByReason(smokingReason);
  }
}
