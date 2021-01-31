import 'package:flutter_test/flutter_test.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

void main() {
  group('database tests', () {
    AppDatabase database;

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test(
        "Create a cigarette object, and insert into db, and verify we get an id back",
        () async {
      Cigarette cigarette = new Cigarette(
          chainSmokingNum: 1,
          smokingContext: SmokingContext.busStop,
          timeOfSmoke: DateTime.now(),
          reasonToSmoke: SmokingReason.hunger);

      final newlyCreatedId = await database.addCigarette(cigarette);
      bool assumption = newlyCreatedId > 0;

      expect(assumption, true);
    }, tags: "cigarette");

    test(
        "Create two cigarette objects, and save into db, then try to get all cigarettes in db, and verify there are two existing in db",
        () async {
      Cigarette cigarette1 = new Cigarette(
          chainSmokingNum: 1,
          smokingContext: SmokingContext.home,
          timeOfSmoke: DateTime.now(),
          reasonToSmoke: SmokingReason.sex);
      Cigarette cigarette2 = new Cigarette(
          chainSmokingNum: 1,
          smokingContext: SmokingContext.goingOut,
          timeOfSmoke: DateTime.now(),
          reasonToSmoke: SmokingReason.morningCigarette);
      database..addCigarette(cigarette1)..addCigarette(cigarette2);

      final List<Cigarette> list = await database.getAllSmokedCigarettes();
      bool assumption = list.length == 2;

      expect(assumption, true);
    }, tags: "cigarette");

    test(
        "Verify that getAllSmokedCigarettes returns an empty list when no cigarettes were added to it",
        () async {
      final List<Cigarette> list = await database.getAllSmokedCigarettes();

      expect(list.length, equals(0));
    });
  });
}
