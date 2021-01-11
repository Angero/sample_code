import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/convex_button.dart';
import 'package:vizable/flows/auth/common/view/image_banner.dart';
import 'package:vizable/flows/auth/common/view/step_counter.dart';
import 'package:vizable/flows/auth/common/view/step_progress.dart';

class DenyPage extends StatelessWidget {
  static const routeName = '/deny';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            _stepCounterWidget(),
            SizedBox(height: 4.0),
            _processWidget(),
            SizedBox(height: 16.0),
            StepProgress(step: 2, steps: 6),
            ImageBanner(image: PICTURE.denied),
            SizedBox(height: 48.0),
            Text(
              'Denied verification',
              textAlign: TextAlign.start,
              style: STYLE.b_24_700.copyWith(color: COLOR.dark),
            ),
            SizedBox(height: 8.0),
            Text('Reason of verification failure', style: STYLE.r_15_400),
            Expanded(child: Container(), flex: 1),
            ConvexButton(
              label: 'Back to Sign Up',
              buttonColor: ButtonColor.blue,
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  Container _processWidget() {
    return Container(
      // color: Colors.yellow,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          'Verification process',
          textAlign: TextAlign.start,
          style: STYLE.b_24_700.copyWith(color: COLOR.dark),
        ),
      ),
    );
  }

  Padding _stepCounterWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: StepCounter(step: 2, steps: 6),
    );
  }

}
