import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/modal.dart';
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
String? getFontSize(BuildContext context) =>
    context.read<SettingsProvider>().fontState;

//* 화면 확대/축소 버튼
String getMagnify(BuildContext context) =>
    context.read<SettingsProvider>().magnigyState;

//* 지도 반경
String getRadius(BuildContext context) =>
    context.read<SettingsProvider>().radiusState;

//* 메뉴 옵션 변경
void changeOptions(BuildContext context, int menuIdx) {
  context.read<SettingsProvider>().applyOption(menuIdx);
}

//* 뒤로 가기 버튼 눌렀을 경우 (메인, 테마 선택)
FutureBool exitApp(BuildContext context) =>
    context.read<ApplyChangeProvider>().changePressed();

//* 뒤로 가기 버튼 눌림 여부
bool watchPressed(BuildContext context) =>
    context.watch<ApplyChangeProvider>().pressedOnce;

//* 로그인
FutureBool login(BuildContext context) async {
  final result = await UserProvider().login();
  if (!context.mounted) throw Error();
  changeToken(context, token: result['token'], refresh: result['refresh']);
  if (result['state'] != 'login') {
    showModal(context,
        page: const InputModal(
          title: '닉네임 설정',
          buttonText: '확인',
          isAlert: true,
          kindOf: 'nickname',
        ));
  }
  return true;
}

//* 새로고침 확인
String onRefresh(BuildContext context) =>
    context.watch<ApplyChangeProvider>().refresh.trim();

//* 새로고침
void changeRefresh(BuildContext context) =>
    context.read<ApplyChangeProvider>().refreshPage();

//* 너비, 높이
double screenWidth(BuildContext context) =>
    context.read<SizeProvider>().screenWidth;

double screenHeight(BuildContext context) =>
    context.read<SizeProvider>().screenHeight;

//* 총 페이지 수
int? getTotal(BuildContext context) =>
    context.read<GlobalProvider>().totalPages;
void setTotal(BuildContext context, int? newTotal) =>
    context.read<GlobalProvider>().setTotal(newTotal);

//* 필터
void setFilter(BuildContext context, int index) =>
    context.read<GlobalProvider>().setFilter(index);
bool readFilter(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.read<GlobalProvider>().diaper;
    case 1:
      return context.read<GlobalProvider>().child;
    case 2:
      return context.read<GlobalProvider>().disabled;
    default:
      return context.read<GlobalProvider>().allDay;
  }
}

bool getFilter(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.watch<GlobalProvider>().diaper;
    case 1:
      return context.watch<GlobalProvider>().child;
    case 2:
      return context.watch<GlobalProvider>().disabled;
    default:
      return context.watch<GlobalProvider>().allDay;
  }
}

//* 정렬
void setSortIdx(BuildContext context, int index) =>
    context.read<GlobalProvider>().setSortIdx(index);
int getSortIdx(BuildContext context) => context.read<GlobalProvider>().sortIdx;


//* 반경