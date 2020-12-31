import 'dart:async';

import 'package:floor/floor.dart';
import 'package:my_cigarette_counter/dao/cigarette_dao.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/type_converters/date_time_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Cigarette])
@TypeConverters([DateTimeConverter])
abstract class AppDatabase extends FloorDatabase {
  CigaretteDao get _cigaretteDao;

  Future<void> addCigarette(Cigarette cigarette) async {
    return _cigaretteDao.insertCigarette(cigarette);
  }

  Future<List<Cigarette>> getAllSmokedCigarettes() async {
    return _cigaretteDao.getAllSmokedCigarettes();
  }

  Future<Cigarette> getCigarette(int id) async {
    return _cigaretteDao.getCigarette(id);
  }

  Future<void> initDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final cigaretteDao = database._cigaretteDao;
  }
}
