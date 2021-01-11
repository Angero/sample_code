import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/flows/auth/common/view/step_counter.dart';
import 'package:vizable/flows/auth/common/view/step_progress.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final int step;
  final bool comeBack;

  const HeaderWidget({Key key, this.title, this.step, this.comeBack = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        this.comeBack ? ReturnBar(title: '') : Container(),
        SizedBox(height: 16.0),
        _stepCounterWidget(),
        SizedBox(height: 4.0),
        _processWidget(),
        SizedBox(height: 16.0),
        StepProgress(step: this.step, steps: 6),
      ],
    );
  }

  Padding _stepCounterWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: StepCounter(step: this.step, steps: 6),
    );
  }

  Container _processWidget() {
    return Container(
      // color: Colors.yellow,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          this.title,
          textAlign: TextAlign.start,
          style: STYLE.b_24_700.copyWith(color: COLOR.dark),
        ),
      ),
    );
  }

}