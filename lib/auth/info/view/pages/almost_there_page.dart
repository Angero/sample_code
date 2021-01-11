import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/view/widgets/convex_button.dart';
import 'package:vizable/common/view/widgets/sub_header_widget.dart';
import 'package:vizable/common/view/widgets/switch_button.dart';
import 'package:vizable/common/view/widgets/universal_text_field.dart';
import 'package:vizable/flows/auth/info/view/pages/skills_page.dart';
import 'package:vizable/flows/auth/info/view/widgets/header_widget.dart';

class AlmostTherePage extends StatefulWidget {
  static const routeName = '/almost';

  @override
  _AlmostTherePageState createState() => _AlmostTherePageState();
}

class _AlmostTherePageState extends State<AlmostTherePage> {
  bool _switchExtra;

  @override
  void initState() {
    super.initState();
    _switchExtra = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            HeaderWidget(
              title: 'Verification process',
              step: 3,
              comeBack: false,
            ),
            _contentWidget(),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: ListView(
        children: [
          SizedBox(height: 20.0),
          SubHeaderWidget(
            title: 'Almost there',
            subtitle: 'You can always change it in your profile settings.',
          ),
          SizedBox(height: 30.0),
          UniversalTextField(
            label: 'Short profile description',
            title: 'Short profile description',
            maxLines: null,
            action: TextInputAction.next,
          ),
          SizedBox(height: 20.0),
          UniversalTextField(
            label: 'Favourite Quote',
            title: 'Favourite Quote',
            maxLines: null,
            action: TextInputAction.next,
          ),
          SizedBox(height: 20.0),
          UniversalTextField(
            label: 'Inspirational People',
            title: 'Inspirational People',
            maxLines: null,
            action: TextInputAction.next,
          ),
          SizedBox(height: 20.0),
          UniversalTextField(
            label: 'Subjects',
            title: 'Subjects',
            maxLines: null,
            action: TextInputAction.next,
          ),
          SizedBox(height: 20.0),
          UniversalTextField(
            label: 'Aspirations',
            title: 'Aspirations',
            maxLines: null,
            action: TextInputAction.done,
          ),
          SizedBox(height: 20.0),
          _switchWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: COLOR.grey,
            ),
          ),
          SizedBox(height: 8.0),
          _switchExtra
              ? UniversalTextField(
                  label: 'Area / region',
                  title: 'Area / region',
                  maxLines: null,
                  action: TextInputAction.next,
                )
              : Container(),
          _switchExtra ? SizedBox(height: 20.0) : Container(),
          _switchExtra
              ? UniversalTextField(
                  label: 'Work categories',
                  title: 'Work categories',
                  maxLines: null,
                  action: TextInputAction.done,
                )
              : Container(),
          SizedBox(height: 30.0),
          _nextButton(),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  // todo: you can change it with switch_item
  Widget _switchWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Open for job opportunities',
                style: STYLE.r_17_400.copyWith(color: COLOR.dark),
              ),
              SizedBox(height: 4.0),
              Text(
                'Your profile will appear in the employer search',
                style: STYLE.r_15_400,
              ),
            ],
          )),
          SwitchButton(
            initialValue: _switchExtra,
            onSwitch: (value) {
              setState(() {
                _switchExtra = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Container _nextButton() {
    return Container(
        child: Center(
            child: ConvexButton(
      label: 'Next',
      buttonColor: ButtonColor.blue,
      onClick: () {
        Navigator.of(context).pushNamed(SkillsPage.routeName);
      },
    )));
  }
}
