import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//* 함수

//* 화면 이동
ReturnVoid routerPush(BuildContext context, {required Widget page}) {
  return () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

//* 나가기, 뒤로 가기
ReturnVoid routerPop(BuildContext context) {
  return () => Navigator.pop(context);
}

//* 모달 띄우기
ReturnVoid showModal(BuildContext context, {required Widget page}) {
  return () {
    showDialog(context: context, builder: (context) => page);
  };
}

//* 화면 너비, 높이 (intro에서 실행)
late var screenWidth, screenHeight;
void initWidthHeight(BuildContext context) {
  final size = MediaQuery.of(context).size;
  screenWidth = size.width;
  screenHeight = size.height;
}

//* 앱 데이터 저장
void setVisited() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasVisited', true);
}

void setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', token);
}

void setTheme(Themes theme) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('themeIdx', convertedTheme(theme));
}

void setRadius(MapRadius radius) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('radiusIdx', convertedRadius(radius));
}

//* 앱 데이터 가져오기/초기화
void initData() async {
  final prefs = await SharedPreferences.getInstance();
  final hasVisited = prefs.getBool('hasVisited');
  final loggedIn = prefs.getString('accessToken');
  final themeIdx = prefs.getInt('themeIdx');
  final radiusIdx = prefs.getInt('radiusIdx');
  if (hasVisited != null) {
    isFirstVisit = false;
  }
  if (loggedIn != null) {
    accessToken = loggedIn;
  }
  if (themeIdx != null) {
    // theme = ;
  }
  if (radiusIdx != null) {
    // mapRadius =
  }
}

//* 변수
// late final memberId;
const memberId = 13;
const token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwdWJoYW4zNUBnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuuCmOybkOqyvSIsImlkIjoxMywiZXhwIjoxNjc5OTIwNDYyfQ.CNTbGdjf6G9cNRsBHDvoh9WN3EoIHaZb9G-lXPO4ACJ4b26fYsGSbZ988RpBQpcSJV-_DOyFLoQBsggQiOep1w';
