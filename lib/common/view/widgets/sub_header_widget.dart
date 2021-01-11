import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class SubHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SubHeaderWidget({Key key, this.title, this.subtitle}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Text(this.title,
                style: STYLE.b_18_700.copyWith(color: COLOR.dark))),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: Text(this.subtitle,
              style: STYLE.r_12_400),
        ),
      ],
    );
  }
}