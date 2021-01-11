import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/switch_button.dart';

class SwitchItem extends StatelessWidget {
  final String title;
  final String comment;
  final bool initialValue;
  final Function(bool) onSwitch;

  const SwitchItem({
    Key key,
    this.title,
    this.comment,
    this.initialValue,
    this.onSwitch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.title,
                style: STYLE.r_17_400.copyWith(color: COLOR.dark),
              ),
              SizedBox(height: 4.0),
              Text(
                this.comment,
                style: STYLE.r_15_400,
              ),
            ],
          )),
          SwitchButton(
            initialValue: this.initialValue,
            onSwitch: (value) => onSwitch(value),
          ),
        ],
      ),
    );
  }
}
