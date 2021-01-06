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

  void initWithMockData() {
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "my girlfriend broke up with me",
        smokingContext: "In the street",
        timeOfSmoke: Jiffy().startOf(Units.MONTH)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I was happy!",
        smokingContext: "First thing in the morning",
        timeOfSmoke: Jiffy().endOf(Units.MONTH)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I got a promotion",
        smokingContext: "At work",
        timeOfSmoke: Jiffy().startOf(Units.WEEK)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I needed some time off",
        smokingContext: "in the balcony",
        timeOfSmoke: Jiffy().endOf(Units.WEEK)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "My parents upsetting me",
        smokingContext: "At my folks\'",
        timeOfSmoke: Jiffy().startOf(Units.DAY)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "With the coffee",
        smokingContext: "early morning",
        timeOfSmoke: Jiffy().endOf(Units.DAY)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "I had to get up early",
        smokingContext: "the bus station",
        timeOfSmoke: Jiffy().startOf(Units.HOUR)));
    _cigaretteDao.insertCigarette(Cigarette(
        chainSmokingNum: 1,
        reasonToSmoke: "After dinner",
        smokingContext: "in the balcony",
        timeOfSmoke: Jiffy().endOf(Units.HOUR)));
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
      String smokingContext) {
    return _cigaretteDao.getAlSmokedCigarettesInContext(smokingContext);
  }
}
