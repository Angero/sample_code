import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/flows/auth/common/view/image_banner.dart';
import 'package:vizable/common/view/widgets/surface_button.dart';
import 'package:vizable/flows/auth/info/view/pages/almost_there_page.dart';

class VerifyPage extends StatelessWidget {
  static const routeName = '/verify';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ImageBanner(image: PICTURE.verification),
            Container(
              child: Center(
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 48.0),
                        Text('Verification process',
                            style: STYLE.b_24_700.copyWith(color: COLOR.dark)),
                        SizedBox(height: 10.0),
                        Text('We will inform you via email & push notification',
                            style: STYLE.r_15_400),
                        SizedBox(height: 48.0),
                        SurfaceButton(
                          label: 'IF VERIFICATION HAS COMPLETED',
                          textStyle: STYLE.b_16_700
                              .copyWith(color: COLOR.blue),
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(AlmostTherePage.routeName);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
