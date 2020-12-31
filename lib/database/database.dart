import 'dart:async';

import 'package:cigarette_counter/dao/cigarette_dao.dart';
import 'package:cigarette_counter/entity/cigarette.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Cigarette])
abstract class AppDatabase extends FloorDatabase {

  CigaretteDao get cigaretteDao;

  Future<void> test() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final cigaretteDao = database.cigaretteDao;

    final cigarette = Cigarette(chainSmokingNum: 1, reasonToSmoke: "I got angry", smokingContext: "in the porch");
    await cigaretteDao.insertCigarette(cigarette);

    final result = await cigaretteDao.getCigarette(1);

    print("my cigarette: " + result.smokingContext);

  }

}
