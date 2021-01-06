import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/routes.dart';

import 'database/database.dart';
import 'screens/cigarette_counter_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // database.initWithMockData();
  runApp(CigaretteCounterApp(database: database));
}

class CigaretteCounterApp extends StatelessWidget {
  const CigaretteCounterApp({this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cigarette Counter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CigaretteCounterWidget(
          database: database,
        ),
        routes: Routes.getRoutes(database));
  }
}
