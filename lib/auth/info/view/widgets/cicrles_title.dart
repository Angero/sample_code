import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class CirclesTitle extends StatelessWidget {
  final String title;

  const CirclesTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: Text(this.title.toUpperCase(), style: STYLE.r_12_400),
        ),
      ],
    );;
  }
}