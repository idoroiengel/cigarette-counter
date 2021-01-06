import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

void main() {
  group("statistics tests", () {
    AppDatabase database;

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test(
        "create two cigarettes smoked today, and one smoked not today, and verify "
        "that database returns correctly those smoked today, as passed by parameters",
        () async {
      var jiffy = new Jiffy();
      var startOfDay = jiffy.startOf(Units.DAY);
      var endOfDay = jiffy.endOf(Units.DAY);

      Cigarette cigarette1 = new Cigarette(timeOfSmoke: startOfDay);
      Cigarette cigarette2 = new Cigarette(timeOfSmoke: endOfDay);
      Cigarette cigarette3 =
          new Cigarette(timeOfSmoke: jiffy.startOf(Units.YEAR));
      database.addCigarette(cigarette1);
      database.addCigarette(cigarette2);
      database.addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesFromTo(startOfDay, endOfDay);

      expect(list.length, equals(2));
    }, tags: "statistics");

    test(
        "create two cigarettes smoked yesterday, and one smoked before, and verify "
        "that database returns correctly those smoked yesterday, as passed by parameters",
        () async {
      var jiffy = new Jiffy();
      var startOfYesterday =
          jiffy.startOf(Units.DAY).subtract(Duration(days: 1));
      var endOfYesterday = jiffy.endOf(Units.DAY).subtract(Duration(days: 1));

      Cigarette cigarette1 = new Cigarette(timeOfSmoke: startOfYesterday);
      Cigarette cigarette2 = new Cigarette(timeOfSmoke: endOfYesterday);
      Cigarette cigarette3 =
          new Cigarette(timeOfSmoke: jiffy.startOf(Units.YEAR));
      database.addCigarette(cigarette1);
      database.addCigarette(cigarette2);
      database.addCigarette(cigarette3);

      final list = await database.getAllSmokedCigarettesFromTo(
          startOfYesterday, endOfYesterday);

      expect(list.length, equals(2));
    }, tags: "statistics");

    test(
        "create two cigarettes smoked during this week, and one smoked before, and verify "
        "that database returns correctly those smoked this week, as passed by parameters",
        () async {
      var jiffy = new Jiffy();
      var startOfWeek = jiffy.startOf(Units.WEEK);
      var endOfWeek = jiffy.endOf(Units.WEEK);

      Cigarette cigarette1 = new Cigarette(timeOfSmoke: startOfWeek);
      Cigarette cigarette2 = new Cigarette(timeOfSmoke: endOfWeek);
      Cigarette cigarette3 =
          new Cigarette(timeOfSmoke: jiffy.startOf(Units.YEAR));
      database.addCigarette(cigarette1);
      database.addCigarette(cigarette2);
      database.addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesFromTo(startOfWeek, endOfWeek);

      expect(list.length, equals(2));
    });

    test(
        "create two cigarettes smoked during this month, and one smoked before, and verify "
        "that database returns correctly those smoked this week, as passed by parameters",
        () async {
      var jiffy = new Jiffy();
      var startOfMonth = jiffy.startOf(Units.MONTH);
      var endOfMonth = jiffy.endOf(Units.MONTH);

      Cigarette cigarette1 = new Cigarette(timeOfSmoke: startOfMonth);
      Cigarette cigarette2 = new Cigarette(timeOfSmoke: endOfMonth);
      Cigarette cigarette3;
      if (jiffy
          .startOf(Units.MONTH)
          .isAtSameMomentAs(jiffy.startOf(Units.YEAR))) {
        cigarette3 = new Cigarette(
            timeOfSmoke: jiffy.startOf(Units.YEAR).subtract(Duration(days: 1)));
      } else {
        cigarette3 = new Cigarette(timeOfSmoke: jiffy.startOf(Units.YEAR));
      }
      database.addCigarette(cigarette1);
      database.addCigarette(cigarette2);
      database.addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesFromTo(startOfMonth, endOfMonth);
      expect(list.length, equals(2));
    });
  });
}
