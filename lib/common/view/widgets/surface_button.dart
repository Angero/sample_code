import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class SurfaceButton extends StatelessWidget {
  final String label;
  final Function() onClick;
  final TextStyle textStyle;

  const SurfaceButton({Key key, this.textStyle, @required this.label, @required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        label,
        style:
            this.textStyle ?? STYLE.r_20_400,
      ),
      onTap: () => onClick(),
    );
  }
}
