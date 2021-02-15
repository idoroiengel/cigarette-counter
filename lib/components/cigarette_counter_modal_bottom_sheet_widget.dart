import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/components/cigarette_details_widget.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/routes.dart';
import 'package:my_cigarette_counter/view_models/cigarette_counter_modal_bottom_sheet_view_model_impl.dart';

class CigaretteCounterModalBottomSheetWidget extends StatefulWidget {
  @override
  _CigaretteCounterModalBottomSheetWidgetState createState() =>
      _CigaretteCounterModalBottomSheetWidgetState();
}

class _CigaretteCounterModalBottomSheetWidgetState
    extends State<CigaretteCounterModalBottomSheetWidget> {
  CigaretteCounterModalBottomSheetViewModelImpl
      _cigaretteCounterModalBottomSheetViewModelImpl;

  static const recent_cigarettes_number = 4;

  @override
  void initState() {
    super.initState();
    _cigaretteCounterModalBottomSheetViewModelImpl =
        CigaretteCounterModalBottomSheetViewModelImpl();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: ScreenUtil.defaultSize, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(AppColors.isabellinePaletteColor),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(30.0),
            child: Text(
              "My Cigarettes",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(34),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              "Recent cigarettes",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(40),
                  fontWeight: FontWeight.bold,
                  color: Color(AppColors.celadonBluePaletteColor)),
            ),
          ),
          StreamBuilder(
            stream: _cigaretteCounterModalBottomSheetViewModelImpl
                .outputRecentCigarettes,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Cigarette> items = snapshot.data;
              if (snapshot.hasData && !snapshot.hasError) {
                return ListView.builder(
                  itemCount: recent_cigarettes_number,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // TODO implement a RecentCigaretteWidget and show recent cigarettes in that widget
                    return CigaretteDetailsWidget(
                      cigarette: items[index],
                    );
                  },
                );
              }
              return Container(
                child: Text(snapshot.data.runtimeType.toString()),
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            constraints:
                BoxConstraints.expand(height: ScreenUtil().setHeight(120)),
            child: Card(
              elevation: 3,
              child: InkWell(
                splashColor:
                    Color(AppColors.fireEngineRedPaletteColor).withAlpha(30),
                onTap: () => Navigator.pushNamed(
                    context, Routes.smoking_context_choices),
                child: Center(
                  child: Text("Smoking context"),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            constraints:
                BoxConstraints.expand(height: ScreenUtil().setHeight(120)),
            child: Card(
              elevation: 3,
              child: InkWell(
                splashColor:
                    Color(AppColors.fireEngineRedPaletteColor).withAlpha(30),
                onTap: () =>
                    Navigator.pushNamed(context, Routes.smoking_reason_choices),
                child: Center(
                  child: Text("Smoking reason"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
