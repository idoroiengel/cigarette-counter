import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_cigarette_counter/colors.dart';
import 'package:my_cigarette_counter/routes.dart';

class AddCigaretteWidget extends StatefulWidget {
  @override
  _AddCigaretteWidgetState createState() => _AddCigaretteWidgetState();
}

class _AddCigaretteWidgetState extends State<AddCigaretteWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: ScreenUtil.defaultSize, allowFontScaling: false);
    return Container(
      color: Color(AppColors.celadonBluePaletteColor),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            "Tap for cigarette smoked",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(50),
              color: Color(AppColors.isabellinePaletteColor),
            ),
          ),
          padding: EdgeInsets.only(bottom: 30.0),
        ),
        Container(
          height: ScreenUtil().setHeight(250),
          // TODO optimize the AnimatedBuilder's rebuilds
          child: AnimatedBuilder(
            animation: CurvedAnimation(
                parent: _controller, curve: Curves.fastOutSlowIn),
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _buildContainer(150 * _controller.value),
                  _buildContainer(200 * _controller.value),
                  _buildContainer(250 * _controller.value),
                  _buildContainer(300 * _controller.value),
                  _buildContainer(350 * _controller.value),
                  GestureDetector(
                    child: Align(
                      child: SvgPicture.asset(
                        'assets/cigarettes/smoking_red_circle.svg',
                        height: ScreenUtil().setHeight(300),
                        width: ScreenUtil().setWidth(300),
                      ),
                    ),
                    onTap: () => {
                      Navigator.pushNamed(context, Routes.add_cigarette_details)
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.withOpacity(1 - _controller.value),
      ),
    );
  }
}
