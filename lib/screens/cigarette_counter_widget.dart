import 'package:flutter/material.dart';
import 'package:my_cigarette_counter/dao/cigarette_dao.dart';
import 'package:my_cigarette_counter/entity/cigarette.dart';

class CigaretteCounterWidget extends StatefulWidget {
  CigaretteDao cigaretteDao;

  CigaretteCounterWidget({this.cigaretteDao});

  @override
  _CigaretteCounterWidgetState createState() => _CigaretteCounterWidgetState();
}

class _CigaretteCounterWidgetState extends State<CigaretteCounterWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Text((snapshot.data as List<Cigarette>)[index].toString());
          },
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemCount: (snapshot.data as List<Cigarette>).length,
        );
      },
      stream: widget.cigaretteDao.getAllSmokedCigarettes().asStream(),
    );
  }

  Cigarette showCigarette() {
    Cigarette returnValue;
    widget.cigaretteDao
        .getCigarette(2)
        .then((value) => {
              returnValue = value,
              print(value.reasonToSmoke),
            })
        .catchError((error) => {
              print("no cigarettes yet!"),
            });
    return returnValue;
  }
}
