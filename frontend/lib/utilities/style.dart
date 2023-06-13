import 'package:flutter/material.dart';

//* 색 관련
const mainColor = Color(0xFF5957D4);
const whiteColor = Colors.white;
const blackColor = Colors.black;
const redColor = Colors.red;
const yellowColor = Color(0xFFFFBF44);
const greyColor = Colors.grey;
const lightGreyColor = Color(0xFFE5E5E5);
const lightBlueColor = Colors.lightBlue;

//* 글씨 관련
const double largeTitleSize = 33;
const double titleSize = 30;
const double largeLargeSize = 27;
const double largeSize = 24;
const double largeDefaultSize = 22;
const double defaultSize = 19;
const double largeSmallSize = 16;
const double smallSize = 13;

//* 그림자
const defaultShadow = BoxShadow(
  color: greyColor,
  blurRadius: 1,
  spreadRadius: 0.1,
  offset: Offset(0, 1),
);
const highlightShadow = BoxShadow(
  color: mainColor,
  blurRadius: 3,
  spreadRadius: 3,
);

const redShadow = BoxShadow(blurRadius: 10, spreadRadius: 5, color: Colors.red);

//* 글씨체 관련
const kimm = 'Kimm';
