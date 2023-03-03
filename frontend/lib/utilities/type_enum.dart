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

//* enums
enum Themes { largeFont, defaultFont }

enum FontSize { titleSize, largeSize, defaultSize, smallSize }

enum ExtendedFontSize { titleSize, largeSize, defaultSize }

enum CustomColors { whiteColor, mainColor, redColor, blackColor, yellowColor }
