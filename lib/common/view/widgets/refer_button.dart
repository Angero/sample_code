import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class ReferButton extends StatelessWidget {
  final String title;
  final String subtitle;

  const ReferButton({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 56.0,
      decoration: BoxDecoration(
        color: COLOR.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(7, 7), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          Text(
            this.title,
            style: STYLE.r_18_400.copyWith(color: COLOR.grey_dark),
          ),
          SizedBox(width: 4.0),

          Text(
            '|',
            style: STYLE.r_18_400.copyWith(color: COLOR.grey),
          ),
          SizedBox(width: 4.0),
          Text(this.subtitle,
              style: STYLE.r_18_400.copyWith(color: COLOR.grey)),
          Expanded(child: Container(), flex: 1),
          Icon(
            Icons.chevron_right,
            color: COLOR.grey,
          )
        ],
      ),
    );
  }
}
