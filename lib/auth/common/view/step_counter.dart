import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class StepCounter extends StatelessWidget {
  final int step;
  final int steps;

  const StepCounter({Key key, this.step, this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'STEP ' + step.toString(),
          style: STYLE.r_12_400.copyWith(color: COLOR.blue),
        ),
        Text(
          ' / ' + steps.toString(),
          style: STYLE.r_12_400.copyWith(color: COLOR.grey),
        )
      ],
    );
  }
}
