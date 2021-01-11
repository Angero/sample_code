import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

enum ConfirmDialogActions { confirm, cancel }

class ConfirmDialog {
  static void show({
    @required BuildContext context,
    @required String title,
    @required String content,
    Function() onConfirm,
  }) {
    if (content.isEmpty) return;

    AlertDialog dialog = AlertDialog(
      title: Text(
        title,
        style: STYLE.b_24_700.copyWith(color: COLOR.dark),
      ),
      content: Text(
        content,
        style: STYLE.r_15_400,
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'.toUpperCase(), style: STYLE.b_14_700)),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              'Confirm'.toUpperCase(),
              style: STYLE.b_14_700.copyWith(color: COLOR.blue),
            )),
      ],
      backgroundColor: COLOR.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
    );
  }
}
