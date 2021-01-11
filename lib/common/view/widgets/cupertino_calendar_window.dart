import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class CupertinoCalendarWindow extends StatelessWidget {
  final DateTime initialDateTime;
  final Function() onOpenSpaceClick;
  final Function(DateTime) onSelectDate;

  const CupertinoCalendarWindow({
    this.initialDateTime,
    this.onOpenSpaceClick,
    this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Opacity(
          opacity: 0.0,
          child: GestureDetector(
            child: Container(
              color: Colors.black,
            ),
            onTap: () => onOpenSpaceClick(),
          ),
        ),
        Container(
            height: 200.0,
            color: COLOR.white,
            child: CupertinoDatePicker(
              initialDateTime: this.initialDateTime,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (dt) => this.onSelectDate(dt),
            )),
      ],
    );
  }
}
