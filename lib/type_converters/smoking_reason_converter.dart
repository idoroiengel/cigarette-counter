import 'package:enum_to_string/enum_to_string.dart';
import 'package:floor/floor.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class SmokingReasonConverter extends TypeConverter<SmokingReason, String> {
  @override
  SmokingReason decode(String databaseValue) {
    return EnumToString.fromString(SmokingReason.values, databaseValue,
        camelCase: false);
  }

  @override
  String encode(SmokingReason value) {
    return EnumToString.convertToString(value, camelCase: false);
  }
}
