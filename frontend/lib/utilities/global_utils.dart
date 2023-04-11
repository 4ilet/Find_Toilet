import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => page,
    );
  };
}

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
void getFontSize(BuildContext context) {
  context.read<SettingsProvider>().hasLargeFont;
}

void changeFontSize(BuildContext context, bool newValue) {
  context.read<SettingsProvider>().applyHasLargeFont(newValue);
}
