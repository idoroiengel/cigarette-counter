import 'package:flutter/material.dart';

import 'dao/cigarette_dao.dart';
import 'database/database.dart';
import 'screens/cigarette_counter_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  database.test();
  final cigaretteDao = database.cigaretteDao;

  runApp(CigaretteCounterApp(
    cigaretteDao: cigaretteDao,
  ));
}

class CigaretteCounterApp extends StatelessWidget {
  const CigaretteCounterApp({this.cigaretteDao});

  final CigaretteDao cigaretteDao;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cigarette Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CigaretteCounterWidget(
        cigaretteDao: cigaretteDao,
      ),
    );
  }
}
