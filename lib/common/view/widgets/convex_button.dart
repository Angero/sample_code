import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

enum ButtonColor { white, blue }

class ConvexButton extends StatelessWidget {
  final ButtonColor buttonColor;
  final String label;
  final bool active;
  final IconData iconData;
  final Function() onClick;
  final double minWidth;

  const ConvexButton({
    Key key,
    this.buttonColor = ButtonColor.white,
    this.label,
    this.active = true,
    this.iconData,
    this.onClick,
    this.minWidth = 180.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: this.minWidth,
        ),
        child: Opacity(
          opacity: this.active ? 1.0 : 0.5,
          child: Container(
            height: 54.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors(),
                ),
                boxShadow: this.buttonColor == ButtonColor.white
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(7, 7), // changes position of shadow
                        ),
                      ]
                    : null),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  this.iconData != null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                            this.iconData,
                            color: this.buttonColor == ButtonColor.white
                                ? COLOR.blue
                                : COLOR.white,
                          ),
                      )
                      : Container(),
                  Text(
                    this.label,
                    textAlign: TextAlign.center,
                    style: this.buttonColor == ButtonColor.white
                        ? STYLE.b_18_700.copyWith(color: COLOR.blue_dark)
                        : STYLE.b_18_700.copyWith(color: COLOR.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => this.active ? onClick() : null,
    );
  }

  List<Color> gradientColors() {
    if (this.buttonColor == ButtonColor.white)
      return [COLOR.white, COLOR.grey_light];
    if (this.buttonColor == ButtonColor.blue)
      return [COLOR.blue_middle, COLOR.blue];
    return [Colors.white, Colors.black];
  }
}
