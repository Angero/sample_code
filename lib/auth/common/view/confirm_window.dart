import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class ConfirmWindow extends StatelessWidget {
  final String title;
  final String content;
  final Function() onCancel;
  final Function() onConfirm;

  const ConfirmWindow({
    @required this.title,
    @required this.content,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Opacity(
            opacity: 0.5,
            child: Container(
              color: Colors.black,
            ),
          ),
          onTap: () => onCancel(),
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
          SizedBox(height: 28.0),
          _titleWidget(),
          SizedBox(height: 6.0),
          _contentWidget(),
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buttonWidget(
                  label: 'Cancel',
                  onClick: () => onCancel(),
                ),
                SizedBox(width: 20.0),
                _buttonWidget(
                  label: 'Confirm',
                  active: true,
                  onClick: () => onConfirm(),
                ),
              ],
            ),
          ),
          SizedBox(height: 26.0),
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

  Widget _buttonWidget(
      {String label, bool active = false, Function() onClick}) {
    return InkWell(
      child: Text(
        label.toUpperCase(),
        style: active
            ? STYLE.b_14_700.copyWith(color: COLOR.blue)
            : STYLE.b_14_700,
      ),
      onTap: () => onClick(),
    );
  }
}
