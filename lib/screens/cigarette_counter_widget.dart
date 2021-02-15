import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/components/add_cigarette_widget.dart';
import 'package:my_cigarette_counter/components/cigarette_counter_modal_bottom_sheet_widget.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class CigaretteCounterWidget extends StatefulWidget {
  final AppDatabase database;

  CigaretteCounterWidget({this.database});

  @override
  _CigaretteCounterWidgetState createState() => _CigaretteCounterWidgetState();
}

class _CigaretteCounterWidgetState extends State<CigaretteCounterWidget> {
  Widget activeView;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: ScreenUtil.defaultSize, allowFontScaling: false);
    return Scaffold(
      body: Center(
        child: AddCigaretteWidget(),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          color: Color(AppColors.celadonBluePaletteColor),
          child: Container(
            decoration: BoxDecoration(
              color: Color(AppColors.isabellinePaletteColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: ScreenUtil().setHeight(100),
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "My Cigarettes",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () => buildShowMaterialModalBottomSheet(context),
        onVerticalDragStart: (details) =>
            buildShowMaterialModalBottomSheet(context),
      ),
    );
  }

  Future buildShowMaterialModalBottomSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      expand: true,
      barrierColor: Color(AppColors.isabellinePaletteColor),
      builder: (context) => Container(
        child: CigaretteCounterModalBottomSheetWidget(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    activeView = StreamBuilder(
      stream: widget.database.getAllSmokedCigarettes().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView.separated(
            itemCount: (snapshot.data as List<Cigarette>).length,
            itemBuilder: (context, index) {
              return Text((snapshot.data as List<Cigarette>)[index].toString());
            },
            separatorBuilder: (context, index) => Divider(color: Colors.black),
          );
        }
      },
    );
  }
}
