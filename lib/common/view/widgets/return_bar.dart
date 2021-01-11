import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class ReturnBar extends StatelessWidget {
  final String title;
  final Function onClickSuffix;

  const ReturnBar({Key key, this.title = '', this.onClickSuffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        color: COLOR.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(7, 7), // changes position of shadow
          ),
        ],
      ),
      // color: Colors.amberAccent,
      child: Row(
        children: [
          InkWell(
            child: Container(
              width: 48.0,
              height: 48.0,
              // color: Colors.cyan,
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                    width: 16.0,
                    height: 16.0,
                    // color: Colors.indigoAccent,
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: COLOR.grey_dark,
                      size: 16.0,
                    )),
              ),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              this.title,
              style: STYLE.r_20_400.copyWith(color: COLOR.grey_dark),
            ),
          ),
          _suffixWidget(),
        ],
      ),
    );
  }

  Widget _suffixWidget() {
    return GestureDetector(
      child: Container(
        width: 48.0,
        height: 48.0,
        child: Icon(
          Icons.more_vert,
          color: COLOR.grey,
        ),
      ),
      onTap: () => onClickSuffix(),
    );
  }
}
