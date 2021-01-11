import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';

class TermsPage extends StatelessWidget {
  static const routeName = '/terms';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _contentWidget(),
            ReturnBar(title: 'Terms'),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget() {
    List<Widget> widgets = List();
    List<String> sentences = faker.lorem.sentences(20);
    widgets.add(SizedBox(height: 84.0));
    widgets.add(Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Terms of Use',
        style: STYLE.b_24_700.copyWith(color: COLOR.dark),
      ),
    ));
    widgets.add(SizedBox(height: 16.0));
    for(int i = 0; i < 12; i++) {
      widgets.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(faker.lorem.sentences(3).toString(), style: STYLE.r_15_400),
      ));
      widgets.add(SizedBox(height: 16.0));
    }
    return ListView(
      children: widgets,
    );
  }
}
