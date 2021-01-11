import 'package:flutter/material.dart';
import 'package:vizable/flows/intro/view/intro_item.dart';

class IndicatorWidget extends StatelessWidget {
  final IntroItems introItems;
  final int currentIndex;
  final Color basicColor;
  final Color activeColor;

  const IndicatorWidget({
    Key key,
    @required this.introItems,
    @required this.currentIndex,
    this.basicColor = const Color(0xFFD3E3F2),
    this.activeColor = const Color(0xFF1865D8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _indicator();
  }

  Widget _indicator() {
    List<Widget> list = List();
    for (IntroItem item in introItems.items) {
      list.add(_dotWidget(selected: item.index == currentIndex));
      double gap = item.index == introItems.items.length - 1 ? 0.0 : 9.0;
      list.add(SizedBox(width: gap));
    }
    list.insert(0, Expanded(child: Container(), flex: 1));
    list.add(Expanded(child: Container(), flex: 1));
    return Row(children: list);
  }

  Widget _dotWidget({bool selected = false}) {
    return Container(
      width: 7.0,
      height: 7.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? this.activeColor : this.basicColor),
    );
  }
}


