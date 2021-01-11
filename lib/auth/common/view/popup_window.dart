import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class PopupWindow extends StatelessWidget {
  final String title;
  final String content;
  final Function() onClick;

  const PopupWindow({
    @required this.title,
    @required this.content,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              color: Colors.black,
            ),
          ),
          Center(
            child: Wrap(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 48.0),
                        Expanded(
                          child: _windowWidget(),
                        ),
                        SizedBox(width: 48.0),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () => onClick(),
    );
  }

  Container _windowWidget() {
    return Container(
      decoration: BoxDecoration(
          color: COLOR.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(7, 7), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          SizedBox(height: 32.0),
          _titleWidget(),
          SizedBox(height: 8.0),
          _contentWidget(),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }

  Container _titleWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        width: double.infinity,
        child: Text(
          this.title,
          textAlign: TextAlign.start,
          style: STYLE.b_24_700.copyWith(color: COLOR.dark),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Container _contentWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        width: double.infinity,
        child: Text(
          this.content,
          style: STYLE.r_15_400,
        ));
  }
}
