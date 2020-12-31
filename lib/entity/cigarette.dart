import 'package:floor/floor.dart';

@entity
class Cigarette {

  @PrimaryKey(autoGenerate: true)
  final int id;
   String reasonToSmoke;

   // maybe make this an enum, as there are only a number of contexts one can smoke
   String smokingContext;
   int chainSmokingNum;

  Cigarette(
  {this.id, this.reasonToSmoke, this.smokingContext, this.chainSmokingNum});

  @override
  String toString() {
    return 'Cigarette{id: $id, reasonToSmoke: $reasonToSmoke, smokingContext: $smokingContext, chainSmokingNum: $chainSmokingNum}';
  }
}