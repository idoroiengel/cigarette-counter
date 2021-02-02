import 'package:dialog_spinner/dialog_spinner.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/database/database.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class CigaretteDetailsWidget extends StatefulWidget {
  AppDatabase database;

  @override
  _CigaretteDetailsWidgetState createState() => _CigaretteDetailsWidgetState();

  CigaretteDetailsWidget({this.database});
}

class _CigaretteDetailsWidgetState extends State<CigaretteDetailsWidget> {
  var smokingReason;
  var smokingContext;

  @override
  void initState() {
    super.initState();
  }

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
      body: Stack(
        children: [
          Column(
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
              ),
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Material(
                  elevation: 2,
                  child: Container(
                    color: Color(AppColors.isabellinePaletteColor),
                    child: StreamBuilder(
                        // TODO add initial data to avoid having null value at first
                        stream: Stream.periodic(Duration(seconds: 5), (i) {
                          return Jiffy().format('MMMM do yyyy, h:mm:ss a');
                        }),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Center(
                            child: Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                color:
                                    Color(AppColors.fireEngineRedPaletteColor),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () => {
                widget.database
                    .addCigarette(
                      Cigarette(
                        smokingContext: this.smokingContext,
                        reasonToSmoke: this.smokingReason,
                        timeOfSmoke: Jiffy().dateTime,
                        chainSmokingNum: 1,
                      ),
                    )
                    .whenComplete(() => Navigator.pop(context))
              },
              child: Text("OK"),
              textColor: Color(AppColors.isabellinePaletteColor),
              color: Color(AppColors.celadonBluePaletteColor),
            ),
          )
        ],
      ),
    );
  }
}
