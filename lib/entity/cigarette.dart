import 'package:floor/floor.dart';

@entity
class Cigarette {
  @PrimaryKey(autoGenerate: true)
  final int id;
  SmokingReason reasonToSmoke;
  SmokingContext smokingContext;
  int chainSmokingNum;
  DateTime timeOfSmoke;

  // TODO add a smokingLocation property to this entity, and make adjustments appropriately
  Cigarette(
      {this.id,
      this.reasonToSmoke,
      this.smokingContext,
      this.chainSmokingNum,
      this.timeOfSmoke});

  @override
  String toString() {
    return 'Cigarette{id: $id, reasonToSmoke: $reasonToSmoke, smokingContext: $smokingContext, chainSmokingNum: $chainSmokingNum, timeOfSmoke: $timeOfSmoke}';
  }
}

enum SmokingReason {
  boring,
  hunger,
  sex,
  food,
  bathroom,
  morningCigarette,
  bedtimeCigarette,
}

enum SmokingContext {
  home,
  work,
  busStop,
  friends,
  goingOut,
}
