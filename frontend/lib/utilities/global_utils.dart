import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 함수

//* 화면 이동 (뒤로 가기 적용 X)
Future<bool?> removedRouterPush(BuildContext context, {required Widget page}) =>
    Navigator.pushAndRemoveUntil<bool>(
      context,
      MaterialPageRoute(builder: (context) => page),
      (router) => false,
    );

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
Future<bool?> showModal(BuildContext context, {required Widget page}) =>
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => page,
    );

//* 화면 너비, 높이 (intro에서 실행)
late var screenWidth, screenHeight;
void initWidthHeight(BuildContext context) {
  final size = MediaQuery.of(context).size;
  screenWidth = size.width;
  screenHeight = size.height;
}

//* 토큰 받아오기
String? getToken(BuildContext context) =>
    context.read<UserInfoProvider>().token;

//* 토큰 변경
void changeToken(BuildContext context, {String? token, String? refresh}) {
  final userInfo = context.read<UserInfoProvider>();
  userInfo.setStoreToken(token);
  userInfo.setStoreRefresh(refresh);
}

//* 현재 글자 크기
bool? getFontSize(BuildContext context) =>
    context.read<SettingsProvider>().hasLargeFont;

void applyFontSize(BuildContext context, bool newValue) {
  context.read<SettingsProvider>().applyHasLargeFont(newValue);
}

FutureBool exitApp(context) =>
    context.read<ApplyChangeProvider>().changePressed();
bool watchPressed(context) => context.watch<ApplyChangeProvider>().pressedOnce;
