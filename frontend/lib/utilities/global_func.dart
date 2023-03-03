import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

//* 화면 이동
ReturnVoid routerPush({required BuildContext context, required Widget page}) {
  return () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

//* 나가기, 뒤로 가기
ReturnVoid routerPop({required BuildContext context}) {
  return () => Navigator.pop(context);
}

//* 모달 띄우기
ReturnVoid showModal({required BuildContext context, required Widget page}) {
  return () {
    showDialog(context: context, builder: (context) => page);
  };
}

//* 화면 너비, 높이 (intro에서 실행)
late final screenWidth, screenHeight;
void initWidthHeight(BuildContext context) {
  final size = MediaQuery.of(context).size;
  screenWidth = size.width;
  screenHeight = size.height;
}
