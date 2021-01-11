import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vizable/common/const/barrel.dart';

class SwitchButton extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onSwitch;

  const SwitchButton({Key key, this.initialValue = false, this.onSwitch}) : super(key: key);
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _switchState;

  @override
  void initState() {
    super.initState();
    _switchState = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // color: Colors.yellow,
        width: 48.0,
        height: 48.0,
        child: Center(
          child: SvgPicture.asset(_switchState ? PICTURE.toggleOn : PICTURE.toggleOff),
        ),
      ),
      // onTap: () => widget.onSwitch(!_switchState),
      onTap: () {
        setState(() {
          _switchState = !_switchState;
          widget.onSwitch(_switchState);
        });
      },
    );
  }
}