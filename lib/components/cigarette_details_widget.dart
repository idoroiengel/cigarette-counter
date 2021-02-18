import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class CigaretteDetailsWidget extends StatefulWidget {
  @override
  _CigaretteDetailsWidgetState createState() => _CigaretteDetailsWidgetState();

  Cigarette cigarette;

  CigaretteDetailsWidget({this.cigarette});
}

class _CigaretteDetailsWidgetState extends State<CigaretteDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(AppColors.celadonBluePaletteColor),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/cigarettes/smoking_red_circle.svg',
          height: ScreenUtil().setHeight(80),
        ),
        title: Text(
          "Context: " +
              EnumToString.convertToString(
                widget.cigarette.smokingContext,
                camelCase: true,
              ),
          style: TextStyle(
            color: Color(AppColors.isabellinePaletteColor),
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(34),
          ),
        ),
        subtitle: Text(
          "Reason: " +
              EnumToString.convertToString(
                widget.cigarette.reasonToSmoke,
                camelCase: true,
              ),
          style: TextStyle(
            color: Color(AppColors.isabellinePaletteColor),
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(34),
          ),
        ),
        trailing: Text(
          "When: " + Jiffy(widget.cigarette.timeOfSmoke).fromNow(),
          style: TextStyle(
            color: Color(AppColors.isabellinePaletteColor),
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(34),
          ),
        ),
      ),
    );
  }
}
