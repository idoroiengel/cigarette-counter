import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/routes.dart';
import 'package:my_cigarette_counter/view_models/smoking_choices_view_model_impl.dart';

class SmokingChoicesWidget extends StatefulWidget {
  var routeArguments;

  SmokingChoicesWidget({this.routeArguments});

  @override
  _SmokingChoicesWidgetState createState() => _SmokingChoicesWidgetState();
}

class _SmokingChoicesWidgetState extends State<SmokingChoicesWidget> {
  SmokingChoicesViewModelImpl _smokingChoicesViewModelImpl;

  // var routeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Color(AppColors.fireEngineRedPaletteColor),
      child: StreamBuilder(
        stream: determineStreamType(),
        builder: (context, snapshot) {
          return GridView.builder(
            itemCount: SmokingContext.values.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  color: Color(AppColors.isabellinePaletteColor),
                  // TODO implement with SmokingContext route, and show statistics according to choice
                  onPressed: () => buildPushNamed(context, index),
                  child: Text(
                    EnumToString.convertToString(snapshot.data[index],
                        camelCase: true),
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(AppColors.fireEngineRedPaletteColor),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<Object> buildPushNamed(BuildContext context, int index) {
    if (widget.routeArguments == "smokingContext") {
      return Navigator.pushNamed(
        context,
        Routes.smoking_context_statistics,
        arguments: SmokingContext.values[index],
      );
    } else {
      return Navigator.pushNamed(context, Routes.smoking_reason_statistics,
          arguments: SmokingReason.values[index]);
    }
  }

  Stream<List> determineStreamType() {
    if (widget.routeArguments == "smokingContext") {
      print("routeData smoking context");
      return _smokingChoicesViewModelImpl.outputSmokingContext;
    } else {
      print("routeData smoking reason");
      return _smokingChoicesViewModelImpl.outputSmokingReason;
    }
  }

  @override
  void initState() {
    super.initState();
    _smokingChoicesViewModelImpl = SmokingChoicesViewModelImpl();
  }
}
