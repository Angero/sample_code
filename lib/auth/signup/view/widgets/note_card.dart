import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class NoteCard extends StatelessWidget {
  final String content;

  const NoteCard({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: COLOR.blue_thin,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
        child: Text(
          content,
          style: STYLE.b_12_700.copyWith(color: COLOR.blue_dark),
        ),
      ),
    );
  }
}
