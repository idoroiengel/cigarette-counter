import 'package:floor/floor.dart';

@entity
class Cigarette {
  @PrimaryKey(autoGenerate: true)
  final int id;
  String reasonToSmoke;

  // maybe make this an enum, as there are only a number of contexts one can smoke
  String smokingContext;
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
