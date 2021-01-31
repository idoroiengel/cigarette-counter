import 'package:dialog_spinner/dialog_spinner.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class AddCigaretteDetailsWidget extends StatefulWidget {
  @override
  _AddCigaretteDetailsWidgetState createState() =>
      _AddCigaretteDetailsWidgetState();
}

class _AddCigaretteDetailsWidgetState extends State<AddCigaretteDetailsWidget> {
  var smokingReason;
  var smokingContext;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: ScreenUtil.defaultSize, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Current cigarette",
        ),
      ),
      body: Column(
        children: [
          // Smoking reason input
          DialogSpinner(
            spinnerList: EnumToString.toList(
              SmokingReason.values,
              camelCase: true,
            ),
            onValueChanged: (index) {
              setState(() {
                smokingReason = SmokingReason.values[index];
              });
            },
            color: Color(AppColors.isabellinePaletteColor),
            style: TextStyle(
              color: Color(AppColors.fireEngineRedPaletteColor),
            ),
            elevation: 3,
            margin: EdgeInsets.all(10),
          ),
          // Smoking context input
          DialogSpinner(
            spinnerList: EnumToString.toList(
              SmokingContext.values,
              camelCase: true,
            ),
            onValueChanged: (index) {
              setState(() {
                smokingContext = SmokingContext.values[index];
              });
            },
            color: Color(AppColors.isabellinePaletteColor),
            style: TextStyle(
              color: Color(AppColors.fireEngineRedPaletteColor),
            ),
            elevation: 3,
            margin: EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}
