import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

enum CircleButtonType { blue, pink, yellow }

class CircleButton extends StatefulWidget {
  final String title;
  final bool selected;
  final CircleButtonType type;
  final bool isButtonSelectable;

  const CircleButton({
    Key key,
    this.title = '',
    this.selected = false,
    this.type = CircleButtonType.blue,
    this.isButtonSelectable = true,
  }) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    String _normalPicture = PICTURE.blueUnselected;
    String _selectedPicture = PICTURE.blueSelected;
    if (widget.type == CircleButtonType.pink) {
      _normalPicture = PICTURE.pinkUnselected;
      _selectedPicture = PICTURE.blueSelected; //todo:
    }
    if (widget.type == CircleButtonType.yellow) {
      _normalPicture = PICTURE.yellowUnselected;
      _selectedPicture = PICTURE.blueSelected; //todo:
    }
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Image.asset(_selected ? _selectedPicture : _normalPicture),
            onTap: () {
              if (widget.isButtonSelectable)
              setState(() {
                _selected = !_selected;
              });
            },
          ),
          SizedBox(height: 8.0),
          Text(
            widget.title,
            style: STYLE.r_15_400.copyWith(color: COLOR.dark),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
