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

    test("add new cigarette", () async {
      Cigarette cigarette = new Cigarette(
          chainSmokingNum: 1,
          smokingContext: "smoking context",
          timeOfSmoke: DateTime.now(),
          reasonToSmoke: "reason to smoke");
      final newlyCreatedId = await database.addCigarette(cigarette);
      bool assumption = newlyCreatedId > 0;

      expect(assumption, true);
    }, tags: "cigarette");
  });
}
