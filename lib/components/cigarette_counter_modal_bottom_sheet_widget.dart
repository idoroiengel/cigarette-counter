import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: Colors.green,
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
          StreamBuilder(
            stream: _cigaretteCounterModalBottomSheetViewModelImpl
                .outputRecentCigarettes,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Cigarette> items = snapshot.data;
              if(snapshot.hasData && !snapshot.hasError){
                return ListView.builder(
                  itemCount: recent_cigarettes_number,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // TODO implement a RecentCigaretteWidget and show recent cigarettes in that widget
                    return Container(
                      child: Text(
                        EnumToString.convertToString(items[index].smokingContext, camelCase: true)
                      ),
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
                BoxConstraints.expand(height: ScreenUtil().setHeight(90)),
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () => Navigator.pushNamed(context, Routes.smoking_context_choices),
                child: Container(
                  child: Text("Smoking context"),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            constraints:
                BoxConstraints.expand(height: ScreenUtil().setHeight(90)),
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print("card tapped...");
                },
                child: Container(
                  child: Text("Smoking reason"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//       children: [

//         StreamBuilder(
//           stream: _cigaretteCounterModalBottomSheetViewModelImpl
//               .outputSmokingContext,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return Container(
//               child: Text(snapshot.data.toString()),
//             );
//           },
//         )
//       ],
//     ),
//   );
// }
}
