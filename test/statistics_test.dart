import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

void main() {
  group("statistics tests - timeOfSmoke tests", () {
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
      var startOfToday = jiffy.startOf(Units.DAY);
      var endOfToday = jiffy.endOf(Units.DAY);

      Cigarette cigarette1 = new Cigarette(timeOfSmoke: startOfToday);
      Cigarette cigarette2 = new Cigarette(timeOfSmoke: endOfToday);
      Cigarette cigarette3 =
          new Cigarette(timeOfSmoke: jiffy.startOf(Units.YEAR));
      database
        ..addCigarette(cigarette1)
        ..addCigarette(cigarette2)
        ..addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesFromTo(startOfToday, endOfToday);

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
      database
        ..addCigarette(cigarette1)
        ..addCigarette(cigarette2)
        ..addCigarette(cigarette3);

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
      database
        ..addCigarette(cigarette1)
        ..addCigarette(cigarette2)
        ..addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesFromTo(startOfWeek, endOfWeek);

      expect(list.length, equals(2));
    }, tags: "statistics");

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
      database
        ..addCigarette(cigarette1)
        ..addCigarette(cigarette2)
        ..addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesFromTo(startOfMonth, endOfMonth);
      expect(list.length, equals(2));
    }, tags: "statistics");
  });

  group("statistics tests - smoking context tests", () {
    AppDatabase database;
    final smokingContext = "This is a const final context";
    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test(
        "create three cigarettes, two of which has identical context, "
        "and check that they are retrieved when correct parameter is called to the method",
        () async {
      var cigarette1 = new Cigarette(smokingContext: smokingContext);
      var cigarette2 = new Cigarette(smokingContext: smokingContext);
      var cigarette3 =
          new Cigarette(smokingContext: "I am a different context");

      database
        ..addCigarette(cigarette1)
        ..addCigarette(cigarette2)
        ..addCigarette(cigarette3);

      final list =
          await database.getAllSmokedCigarettesInContext(smokingContext);

      expect(list.length, equals(2));
    });
  });
}
