import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/flows/person/view/pages/watch_video_page.dart';

class VideoPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _videoWidget(context);
  }

  Widget _videoWidget(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    double height = width / 2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              PICTURE.image3,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            child: Center(
              child: Image.asset(
                PICTURE.play,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(WatchVideoPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
