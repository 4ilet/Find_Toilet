import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

//* 색 관련
const mainColor = Color(0xFF5957D4);
const whiteColor = Colors.white;
const blackColor = Colors.black;
const redColor = Colors.red;
const yellowColor = Color(0xFFFFBF44);
const greyColor = Colors.grey;
Color convertedColor(CustomColors color) {
  switch (color) {
    case CustomColors.whiteColor:
      return whiteColor;
    case CustomColors.mainColor:
      return mainColor;
    case CustomColors.blackColor:
      return blackColor;
    case CustomColors.redColor:
      return redColor;
    default:
      return yellowColor;
  }
}

//* 글씨 관련
const double titleSize = 30;
const double largeSize = 24;
const double defaultSize = 19;
const double smallSize = 15;

double convertedSize(FontSize size) {
  switch (size) {
    case FontSize.titleSize:
      return titleSize;
    case FontSize.largeSize:
      return largeSize;
    case FontSize.smallSize:
      return smallSize;
    default:
      return defaultSize;
  }
}

//* 그림자
const defaultShadow = BoxShadow(
    color: greyColor, blurRadius: 1, spreadRadius: 0.1, offset: Offset(0, 1));

//* 글씨체 관련
const notoSans = 'Noto Sans';
