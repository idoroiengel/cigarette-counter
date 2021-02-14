import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';
import 'package:my_cigarette_counter/routes.dart';
import 'package:my_cigarette_counter/view_models/smoking_context_choices_view_model_impl.dart';

class SmokingContextChoicesWidget extends StatefulWidget {
  @override
  _SmokingContextChoicesWidgetState createState() =>
      _SmokingContextChoicesWidgetState();
}

class _SmokingContextChoicesWidgetState
    extends State<SmokingContextChoicesWidget> {
  SmokingContextChoicesViewModelImpl _smokingContextChoicesViewModelImpl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Color(AppColors.fireEngineRedPaletteColor),
      child: StreamBuilder(
        stream: _smokingContextChoicesViewModelImpl.outputSmokingContext,
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
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.smoking_context_statistics,
                    arguments: SmokingContext.values[index],
                  ),
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

  @override
  void initState() {
    super.initState();
    _smokingContextChoicesViewModelImpl = SmokingContextChoicesViewModelImpl();
  }
}
