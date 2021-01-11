import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/convex_button.dart';
import 'package:vizable/flows/auth/common/view/image_banner.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/common/view/widgets/surface_button.dart';
import 'package:vizable/flows/auth/signup/view/pages/info_person_page.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ReturnBar(title: 'Sign Up'),
            ImageBanner(image: PICTURE.signup),
            SizedBox(height: 24.0),
            _whoWidget(),
            Expanded(child: Container(), flex: 1),
            ConvexButton(
              buttonColor: ButtonColor.blue,
              label: 'Young Person',
              onClick: () {
                Navigator.of(context).pushReplacementNamed(InfoPersonPage.routeName);
              },
            ),
            SizedBox(height: 10.0),
            ConvexButton(
              label: 'Organization',
              onClick: () {
                // Navigator.of(context).pushNamed('/signup');
              },
            ),
            SizedBox(height: 24.0),
            _cancelButton(context),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Container _whoWidget() {
    return Container(
        child: Center(
            child: Text(
      'Who are you?',
      style: STYLE.r_48_400.copyWith(color: COLOR.dark),
    )));
  }

  Container _cancelButton(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: SurfaceButton(
        label: 'Cancel',
        textStyle: STYLE.b_16_700.copyWith(color: COLOR.blue),
        onClick: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
