import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/flows/person/view/pages/photos_carousel_page.dart';

class PhotosGrid extends StatelessWidget {
  final bool canDelete;
  final Function() onDelete;

  const PhotosGrid({Key key, this.canDelete = true, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _gridWidget(context);
  }

  Widget _gridWidget(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    List<String> _images = List();
    _images.add(PICTURE.image1);
    _images.add(PICTURE.image2);
    _images.add(PICTURE.image1);
    _images.add(PICTURE.image2);
    List<Widget> widgets = List();
    for (int i = 0; i < _images.length; i++)
      widgets.add(_photoWidget(context, _images.elementAt(i), i));
    if (widgets.length == 0) return Container();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: width,
        child: GridView.count(
          crossAxisCount: 2,
          children: widgets,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
      ),
    );
  }

  Widget _photoWidget(BuildContext context, String image, int index) {
    double size = (MediaQuery.of(context).size.width - 42) / 2;
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          child: Center(
            child: Image.asset(
              PICTURE.increase,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(PhotosCarouselPage.routeName);
          },
        ),
        this.canDelete ? _deleteWidget(index) : Container(),
      ],
    );
  }

  Positioned _deleteWidget(int index) {
    return Positioned(
      right: 0.0,
      top: 0.0,
      child: GestureDetector(
        child: Container(
          width: 36.0,
          height: 36.0,
          // color: Colors.yellow,
          child: Icon(
            Icons.cancel_rounded,
            color: COLOR.white,
            size: 16.0,
          ),
        ),
        onTap: () => this.onDelete(),
        // onTap: () {
        //   setState(() {
        //     _index = index;
        //     _popup = true;
        //   });
        // },
      ),
    );
  }
}
