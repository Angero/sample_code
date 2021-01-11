import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String image;

  const ImageBanner({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heightImage = width / 3 * 2;
    return Container(
      width: width,
      height: heightImage,
      decoration: new BoxDecoration(
          image: new DecorationImage(
        fit: BoxFit.cover,
        alignment: FractionalOffset.topCenter,
        image: AssetImage(this.image),
      )),
    );
  }
}
