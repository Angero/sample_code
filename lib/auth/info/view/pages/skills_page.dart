import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:vizable/common/view/widgets/circle_button.dart';
import 'package:vizable/common/view/widgets/down_button_panel.dart';
import 'package:vizable/flows/auth/info/view/pages/hobbies_page.dart';
import 'package:vizable/flows/auth/info/view/widgets/cicrles_title.dart';
import 'package:vizable/flows/auth/info/view/widgets/header_widget.dart';
import 'package:vizable/common/view/widgets/sub_header_widget.dart';

class SkillsPage extends StatelessWidget {
  static const routeName = '/skills';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // NextPanel(),
            _contentWidget(context),
            _nextPanel(context),
          ],
        ),
      ),
    );
  }

  Positioned _nextPanel(BuildContext context) {
    return Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: DownButtonPanel(title: 'Next', onClick: () {
              Navigator.of(context).pushNamed(HobbiesPage.routeName);
        },),
          );
  }

  Column _contentWidget(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(title: 'Personal info', step: 4),
        SizedBox(height: 20.0),
        SubHeaderWidget(
          title: 'Tell us more about your skills',
          subtitle: 'You can make your job search so much easier',
        ),
        SizedBox(height: 45.0),
        CirclesTitle(title: 'Choose your skills'.toUpperCase()),
        SizedBox(height: 16.0),
        Expanded(child: _gridView(context)),
      ],
    );
  }

  Widget _gridView(BuildContext context) {
    List<Widget> widgets = List();
    for(int i = 0; i < 33; i++) {
      widgets.add(
        CircleButton(
          title: faker.lorem.word(),
          selected: faker.randomGenerator.boolean(),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        padding: EdgeInsets.only(bottom: 100.0),
        crossAxisCount: 5,
        childAspectRatio: 2 / 3,
        children: widgets,
      ),
    );
  }
}
