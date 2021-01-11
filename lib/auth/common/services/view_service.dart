import 'package:flutter/material.dart';

class ViewService {

  static double getFreeSpace(BuildContext context, double closedSpace) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    double bottom = MediaQuery.of(context).padding.bottom;
    double heightImage = width / 4 * 3;
    double busySpace = heightImage + closedSpace;
    double freeSpace = height - top - bottom - busySpace;
    return freeSpace;
  }

}