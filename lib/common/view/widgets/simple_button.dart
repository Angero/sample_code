import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class SimpleButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onClick;

  const SimpleButton(
      {Key key, this.title, this.color = COLOR.blue, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 120.0,
      ),
      child: GestureDetector(
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: Offset(7, 7), // changes position of shadow
                ),
              ]),
          child: Center(
            child: Text(this.title,
                style: STYLE.r_17_400.copyWith(color: this.color)),
          ),
        ),
        onTap: () => onClick(),
      ),
    );
  }
}
