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
const double largeTitleSize = 34;
const double titleSize = 31;
const double largeLargeSize = 28;
const double largeSize = 25;
const double largeDefaultSize = 23;
const double defaultSize = 20;
const double largeSmallSize = 17;
const double smallSize = 14;

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
