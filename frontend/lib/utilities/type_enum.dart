import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

//* types
typedef WidgetList = List<Widget>;
typedef StringList = List<String>;
typedef IntList = List<int>;
typedef BoolList = List<bool>;
typedef IconDataList = List<IconData>;
typedef ReturnVoid = void Function();
typedef VoidFuncList = List<ReturnVoid>;
typedef ShadowList = List<BoxShadow>;

//* model type
typedef DynamicMap = Map<String, dynamic>;
typedef DynamicMapList = List<DynamicMap>;
typedef StringMap = Map<String, String>;
typedef FutureList = Future<List>;
typedef FutureVoid = Future<void>;
typedef FutureBool = Future<bool>;
typedef FutureDynamicMap = Future<DynamicMap>;

typedef ReviewList = List<ReviewModel>;
typedef FolderList = List<FolderModel>;
typedef ToiletList = List<ToiletModel>;
typedef FutureToiletList = Future<ToiletList>;
typedef FutureReviewList = Future<ReviewList>;

//* enums

enum FontSize {
  largeTitleSize,
  titleSize,
  largeLargeSize,
  largeSize,
  largeDefaultSize,
  defaultSize,
  largeSmallSize,
  smallSize,
}

enum CustomColors {
  whiteColor,
  mainColor,
  redColor,
  blackColor,
  yellowColor,
  lightBlueColor,
}

enum MapRadius { three, five, seven }

enum Space { empty, one }

//* enum to Color, double, int, ...
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
    case CustomColors.yellowColor:
      return yellowColor;
    default:
      return lightBlueColor;
  }
}

double convertedSize(FontSize size) {
  switch (size) {
    case FontSize.largeTitleSize:
      return largeTitleSize;
    case FontSize.titleSize:
      return titleSize;
    case FontSize.largeLargeSize:
      return largeLargeSize;
    case FontSize.largeSize:
      return largeSize;
    case FontSize.largeSmallSize:
      return largeSmallSize;
    case FontSize.smallSize:
      return smallSize;
    case FontSize.largeDefaultSize:
      return largeDefaultSize;
    default:
      return defaultSize;
  }
}

int convertedRadius(MapRadius radius) {
  switch (radius) {
    case MapRadius.three:
      return 0;
    case MapRadius.five:
      return 1;
    default:
      return 2;
  }
}

MapRadius toMapRadius(int index) {
  switch (index) {
    case 0:
      return MapRadius.three;
    case 1:
      return MapRadius.five;
    default:
      return MapRadius.seven;
  }
}

String convertedSpace(Space space) => space == Space.empty ? '' : ' ';
