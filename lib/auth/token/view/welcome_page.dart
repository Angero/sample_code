import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/convex_button.dart';
import 'package:vizable/flows/auth/signin/sign_in_page.dart';
import 'package:vizable/flows/auth/signup/view/pages/sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: Container(), flex: 1),
              Image.asset(PICTURE.logo),
              SizedBox(height: 48.0),
              Text('Welcome', style: STYLE.l_60_300.copyWith(color: COLOR.blue_dark)),
              Expanded(child: Container(), flex: 1),
              ConvexButton(
                buttonColor: ButtonColor.blue,
                label: 'Sign In',
                onClick: () {
                  Navigator.of(context).pushNamed(SignInPage.routeName);
                },
              ),
              SizedBox(height: 10.0),
              ConvexButton(
                label: 'Sign Up',
                onClick: () {
                  Navigator.of(context).pushNamed(SignUpPage.routeName);
                },
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
