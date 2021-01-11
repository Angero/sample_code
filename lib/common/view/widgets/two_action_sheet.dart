import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class TwoActionSheet extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final Function() firstAction;
  final Function() secondAction;

  const TwoActionSheet({
    Key key,
    this.firstTitle,
    this.secondTitle,
    this.firstAction,
    this.secondAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          dialogBackgroundColor: COLOR.white,
          dialogTheme: DialogTheme(backgroundColor: COLOR.white)),
      child: CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(this.firstTitle,
                style: STYLE.r_15_400.copyWith(color: COLOR.dark)),
            onPressed: () {
              Navigator.of(context).pop();
              this.firstAction();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(this.secondTitle,
                style: STYLE.r_15_400.copyWith(color: COLOR.dark)),
            onPressed: () {
              Navigator.of(context).pop();
              this.secondAction();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child:
              Text('Cancel', style: STYLE.r_18_400.copyWith(color: COLOR.dark)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
