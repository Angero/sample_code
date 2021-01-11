import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class StepProgress extends StatelessWidget {
  final int step;
  final int steps;

  const StepProgress({
    @required this.step,
    @required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
              height: 5.0,
              color: COLOR.blue,
            ),
            flex: step),
        Expanded(
            child: Container(
              height: 5.0,
              color: COLOR.blue_light,
            ),
            flex: steps - step),
      ],
    );
  }
}
