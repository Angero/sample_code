import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/convex_button.dart';

class DownButtonPanel extends StatelessWidget {
  final String title;
  final Function() onClick;

  const DownButtonPanel({Key key, @required this.title, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Opacity(
          opacity: 0.7,
          child: Container(
            height: 100.0,
            color: COLOR.white,
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 10.0),
            child: ConvexButton(
              label: this.title,
              buttonColor: ButtonColor.blue,
              onClick: () => this.onClick(),
            ))
      ],
    );
  }
}
