import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

//** 색 관련
const mainColor = Color(0xFF5957D4);
const whiteColor = Colors.white;
const blackColor = Colors.black;
const redColor = Colors.red;
Color convertedColor(CustomColors color) {
  switch (color) {
    case CustomColors.whiteColor:
      return whiteColor;
    case CustomColors.mainColor:
      return mainColor;
    case CustomColors.blackColor:
      return blackColor;
    default:
      return redColor;
  }
}

//** 글씨 관련
const double titleSize = 30;
const double largeSize = 24;
const double defaultSize = 19;

double convertedSize(FontSize size) {
  switch (size) {
    case FontSize.titleSize:
      return titleSize;
    case FontSize.largeSize:
      return largeSize;
    default:
      return defaultSize;
  }
}
