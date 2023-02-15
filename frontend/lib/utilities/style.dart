import 'package:flutter/material.dart';

//** 색 관련
const mainColor = Color(0xFF5957D4);
const whiteColor = Colors.white;

//** 글씨 관련
const double titleSize = 30;
const double largeSize = 24;
const double defaultSize = 19;

enum FontSize { titleSize, largeSize, defaultSize }

double convedSize(FontSize size) {
  switch (size) {
    case FontSize.titleSize:
      return titleSize;
    case FontSize.largeSize:
      return largeSize;
    default:
      return defaultSize;
  }
}

class WhiteText extends StatelessWidget {
  final String title;
  final FontSize fontSize;
  const WhiteText({super.key, required this.title, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: whiteColor, fontSize: convedSize(fontSize)),
    );
  }
}
