import 'package:find_toilet/models/toilet_model.dart';
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
Future<bool?> Function() routerPush(BuildContext context,
    {required Widget page, ReturnVoid? afterPush}) {
  return () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) {
      if (afterPush != null) {
        afterPush();
      }
    });
    return Future.value(false);
  };
}

//* 나가기, 뒤로 가기
ReturnVoid routerPop(BuildContext context) {
  return () => Navigator.pop<Future<bool?>>(context);
}

//* 모달 띄우기
Future<bool?> showModal(BuildContext context, {required Widget page}) =>
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => page,
    );

//* 토큰 받아오기
String? readToken(BuildContext context) =>
    context.read<UserInfoProvider>().token;

String? getToken(BuildContext context) =>
    context.watch<UserInfoProvider>().token;

//* 토큰 변경
void changeToken(BuildContext context, {String? token, String? refresh}) {
  final userInfo = context.read<UserInfoProvider>();
  userInfo.setStoreToken(token);
  userInfo.setStoreRefresh(refresh);
}

//* 닉네임
void changeName(BuildContext context, String? name) =>
    context.read<UserInfoProvider>().setStoreName(name);

String? getName(BuildContext context) =>
    context.read<UserInfoProvider>().nickname;

//* 현재 글자 크기
String? getFontSize(BuildContext context) =>
    context.read<SettingsProvider>().fontState;

bool isDefaultTheme(BuildContext context) =>
    context.watch<SettingsProvider>().fontState == '기본';

String getThemeState(BuildContext context) =>
    context.watch<SettingsProvider>().fontState;

FontSize applyDefaultTheme(BuildContext context, FontSize defaultFont) {
  if (isDefaultTheme(context)) {
    return defaultFont;
  } else {
    switch (defaultFont) {
      case FontSize.titleSize:
        return FontSize.largeTitleSize;
      case FontSize.largeSize:
        return FontSize.largeLargeSize;
      case FontSize.defaultSize:
        return FontSize.largeDefaultSize;
      default:
        return FontSize.largeSmallSize;
    }
  }
}

//* 화면 확대/축소 버튼
String watchMagnify(BuildContext context) =>
    context.watch<SettingsProvider>().magnigyState;

//* 지도 반경
String getRadius(BuildContext context) =>
    context.watch<SettingsProvider>().radiusState;

int getIntRadius(BuildContext context) =>
    context.read<SettingsProvider>().radius;

//* 메뉴 옵션 변경
void changeOptions(BuildContext context, int menuIdx) {
  context.read<SettingsProvider>().applyOption(menuIdx);
  if (menuIdx == 1) {
    setRadius(context);
  }
}

//* 뒤로 가기 버튼 눌렀을 경우 (메인, 테마 선택)
FutureBool exitApp(BuildContext context) =>
    context.read<ApplyChangeProvider>().changePressed();

//* 뒤로 가기 버튼 눌림 여부
bool watchPressed(BuildContext context) =>
    context.watch<ApplyChangeProvider>().pressedOnce;

//* 로그인
FutureDynamicMap login(BuildContext context) async {
  final DynamicMap result = await UserProvider().login();
  if (result['result'] != false) {
    // ignore: use_build_context_synchronously
    changeToken(context, token: result['token'], refresh: result['refresh']);
    if (result['state'] != 'login' || result['nickname'] == null) {
      // ignore: use_build_context_synchronously
      showModal(context, page: const NicknameInputModal(isAlert: true));
    } else {
      // ignore: use_build_context_synchronously
      changeName(context, result['nickname']);
    }
    return result;
  }
  return {};
}

//* 새로고침 확인
String onRefresh(BuildContext context) =>
    context.watch<ApplyChangeProvider>().refresh.trim();

//* 새로고침
void changeRefresh(BuildContext context) =>
    context.read<ApplyChangeProvider>().refreshPage();

//* 너비, 높이
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double statusBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top;

//* 총 페이지 수
int? getTotal(BuildContext context) =>
    context.read<ScrollProvider>().totalPages;
void setTotal(BuildContext context, int? newTotal) =>
    context.read<ScrollProvider>().setTotal(newTotal);

//* 필터
void setFilter(BuildContext context, int index, bool value) =>
    context.read<MainSearchProvider>().setFilter(index, value);

bool readFilter(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.read<MainSearchProvider>().diaper;
    case 1:
      return context.read<MainSearchProvider>().kids;
    case 2:
      return context.read<MainSearchProvider>().disabled;
    default:
      return context.read<MainSearchProvider>().allDay;
  }
}

bool getFilter(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.watch<MainSearchProvider>().diaper;
    case 1:
      return context.watch<MainSearchProvider>().kids;
    case 2:
      return context.watch<MainSearchProvider>().disabled;
    default:
      return context.watch<MainSearchProvider>().allDay;
  }
}

//* 정렬
void setSortIdx(BuildContext context, int index) =>
    context.read<MainSearchProvider>().setSortIdx(index);
int getSortIdx(BuildContext context) =>
    context.read<MainSearchProvider>().sortIdx;

//* 현위치
double? readLat(BuildContext context) => context.read<MainSearchProvider>().lat;
double? readLng(BuildContext context) => context.read<MainSearchProvider>().lng;
void setLatLng(BuildContext context, double newLat, double newLng) =>
    context.read<MainSearchProvider>().setLatLng(newLat, newLng);

//* main toilet list
void setRadius(BuildContext context) =>
    context.read<MainSearchProvider>().setRadius(getIntRadius(context));

void addToiletList(BuildContext context, ToiletList toiletList) =>
    context.read<MainSearchProvider>().addToiletList(toiletList);

DynamicMap mainToiletData(BuildContext context) =>
    context.read<MainSearchProvider>().mainToiletData;

ToiletList mainToiletList(BuildContext context) =>
    context.read<MainSearchProvider>().mainToiletList;

FutureToiletList getMainToiletList(BuildContext context) =>
    context.read<MainSearchProvider>().getMainToiletList(getPage(context));

void initToiletList(BuildContext context) =>
    context.read<MainSearchProvider>().initToiletList();

void setMainPage(BuildContext context, int newVal) =>
    context.read<MainSearchProvider>().setMainPage(newVal);

//* review list
void addReviewList(BuildContext context, ReviewList reviewData) =>
    context.read<ReviewBookMarkProvider>().addReviewList(reviewData);

ReviewList reviewList(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().reviewList;

ToiletModel? getToilet(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().toiletInfo;

void setToilet(BuildContext context, ToiletModel toiletModel) =>
    context.read<ReviewBookMarkProvider>().setToiletInfo(toiletModel);

double? getItemHeight(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().itemHeight;

void setItemHeight(BuildContext context, int i) =>
    context.read<ReviewBookMarkProvider>().setItemHeight(i);

int? getToiletId(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().toiletId;

FutureReviewList getReviewList(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().getReviewList(getPage(context));

void initReviewList(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().initReviewList();

double? getHeight(BuildContext context, int i) =>
    context.read<ReviewBookMarkProvider>().heightList.length > i
        ? context.read<ReviewBookMarkProvider>().heightList[i]
        : null;

void setHeightListSize(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().setHeightListSize();

void setHeight(BuildContext context, int i, double newHeight) =>
    context.read<ReviewBookMarkProvider>().setHeight(i, newHeight);

void initHeightList(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().initHeightList();

//* bookmark list
ToiletList bookmarkList(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().bookmarkList;
FutureToiletList getBookmarkList(
  BuildContext context, {
  required int folderId,
}) =>
    context
        .read<ReviewBookMarkProvider>()
        .getBookmarkList(folderId, getPage(context));

void initBookmarkList(BuildContext context) =>
    context.read<ReviewBookMarkProvider>().initBookmarkList();

//* search list
ToiletList searchToiletList(BuildContext context) =>
    context.read<MainSearchProvider>().searchToiletList;
FutureToiletList getSearchList(BuildContext context) =>
    context.read<MainSearchProvider>().getSearchList(getPage(context));

void initSearchList(BuildContext context) =>
    context.read<MainSearchProvider>().initSearchList();

void setSearchPage(BuildContext context, int newVal) =>
    context.read<MainSearchProvider>().setSearchPage(newVal);

//* init main data
FutureList initMainData(
  BuildContext context, {
  required bool showReview,
  required bool needClear,
}) {
  if (needClear) {
    showReview ? initReviewList(context) : initToiletList(context);
  }
  return showReview ? getReviewList(context) : getMainToiletList(context);
}

//* scroll

bool readLoading(BuildContext context) =>
    context.read<ScrollProvider>().loading;

bool getLoading(BuildContext context) =>
    context.watch<ScrollProvider>().loading;

void setLoading(BuildContext context, bool value) =>
    context.read<ScrollProvider>().setLoading(value);

int getPage(BuildContext context) => context.read<ScrollProvider>().page;

void increasePage(BuildContext context) =>
    context.read<ScrollProvider>().increasePage();

void initPage(BuildContext context) =>
    context.read<ScrollProvider>().initPage();

bool getWorking(BuildContext context) => context.read<ScrollProvider>().working;

void setWorking(BuildContext context, bool value) =>
    context.read<ScrollProvider>().setWorking(value);

bool getAdditional(BuildContext context) =>
    context.read<ScrollProvider>().additional;

void setAdditional(BuildContext context, bool value) =>
    context.read<ScrollProvider>().setAdditional(value);

void initLoadingData(BuildContext context, {bool? isMain, bool? isSearch}) {
  if (isMain == true) {
    setMainPage(context, 0);
  } else if (isSearch == true) {
    setSearchPage(context, 0);
  }
  setLoading(context, true);
  initPage(context);
  setAdditional(context, false);
  setWorking(context, false);
}

//* key
void setKey(BuildContext context, GlobalKey key) =>
    context.read<MainSearchProvider>().setKey(key);
GlobalKey? getKey(BuildContext context) =>
    context.read<MainSearchProvider>().globalKey;

//* 회원가입 모달
bool hideModal(BuildContext context) =>
    context.read<SettingsProvider>().hideModal;

void setJoin(BuildContext context) =>
    context.read<SettingsProvider>().setJoin();
