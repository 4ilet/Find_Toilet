import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//* user info
class UserInfoProvider with ChangeNotifier {
  static String? _token, _refresh, _nickname;
  String? get token => _token;
  String? get refresh => _refresh;
  String? get nickname => _nickname;

  // void debugFillProperites(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('token', token));
  //   properties.add(StringProperty('refresh', refresh));
  //   properties.add(StringProperty('nickname', nickname));
  // }

  //* public

  FutureBool initVar() async {
    final userInfo = await _readStore();
    _setStoreToken(userInfo['token']);
    _setStoreRefresh(userInfo['refresh']);
    _setStoreName(userInfo['nickname']);
    notifyListeners();
    return true;
  }

  void setStoreToken(String? newToken) async {
    _setStoreToken(newToken);
    _setStore('token', newToken);
    notifyListeners();
  }

  void setStoreRefresh(String? newRefresh) {
    _setStoreRefresh(newRefresh);
    _setStore('refresh', newRefresh);
    notifyListeners();
  }

  void setStoreName(String? newName) {
    _setStoreName(newName);
    _setStore('nickname', newName);
    notifyListeners();
  }

  //* private
  void _setStoreToken(String? newToken) => _token = newToken;
  void _setStoreRefresh(String? newRefresh) => _refresh = newRefresh;
  void _setStoreName(String? newName) => _nickname = newName;

  void _setStore(String key, String? value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  Future<StringMap> _readStore() async {
    const storage = FlutterSecureStorage();
    final userInfo = await storage.readAll();
    return userInfo;
  }
}

//* refresh
class ApplyChangeProvider with ChangeNotifier {
  static Space _refresh = Space.empty;
  static String _convertedVar = '';
  static bool _pressedOnce = false;
  String get refresh => _convertedVar;
  bool get pressedOnce => _pressedOnce;

  void refreshPage() {
    _changeRefresh();
    _spaceToString();
    notifyListeners();
  }

  void _changeRefresh() =>
      _refresh = _refresh == Space.empty ? Space.one : Space.empty;

  void _spaceToString() => _convertedVar = convertedSpace(_refresh);

  FutureBool changePressed() => _changePressed();

  FutureBool _changePressed() {
    if (!_pressedOnce) {
      _pressedOnce = true;
      notifyListeners();
      Future.delayed(
          Duration(seconds: SettingsProvider().fontState == '기본' ? 2 : 3), () {
        _pressedOnce = false;
        notifyListeners();
      });
      return Future.value(false);
    }
    return Future.value(true);
  }
}

//* setttings
class SettingsProvider with ChangeNotifier {
  static late bool _hideModal;
  static late int _magnigyIdx, _radiusIdx;
  static int? _fontIdx;
  static String? _fontState;
  static late String _magnigyState, _radiusState;
  final List<StringList> _optionList = [
    ['표시 안 함', '표시함'],
    ['큰 글씨', '기본'],
    ['좁게', '보통', '넓게'],
  ];
  final _valueList = [500, 1000, 1500];

  get fontState => _fontState;
  get magnigyState => _magnigyState;
  get radiusState => _radiusState;
  get radius => _valueList[_radiusIdx];
  get hideModal => _hideModal;

  FutureBool initSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _magnigyIdx = prefs.getInt('magnigyIdx') ?? 0;
    _magnigyState = _optionList[0][_magnigyIdx];

    final font = prefs.getInt('fontIdx');
    if (font != null) {
      _fontIdx = font;
      _fontState = _optionList[1][_fontIdx!];
    }

    _radiusIdx = prefs.getInt('radiusIdx') ?? 1;
    _radiusState = _optionList[2][_radiusIdx];

    _hideModal = prefs.getBool('join') ?? false;
    notifyListeners();

    return true;
  }

//* public
  void initOption(bool option) {
    if (option) {
      _applyShowMagnify();
      _setShowMagnify();
    }
    _initFont(option);
    _setFont();
    notifyListeners();
  }

  void applyOption(int menuIdx) {
    switch (menuIdx) {
      case 0:
        _applyShowMagnify();
        _setShowMagnify();
        break;
      case 1:
        _applyFont();
        _setFont();
        break;
      default:
        _applyRadius();
        _setRadius();
    }
    notifyListeners();
  }

  void setJoin() {
    _setJoin();
    notifyListeners();
  }

//* private
  void _initFont(bool option) {
    _fontIdx = option ? 0 : 1;
    _fontState = _optionList[1][_fontIdx!];
  }

  void _setFont() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontIdx', _fontIdx!);
  }

  void _applyFont() {
    _fontIdx = 1 - _fontIdx!;
    _fontState = _optionList[1][_fontIdx!];
  }

  void _setRadius() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('radiusIdx', _radiusIdx);
  }

  void _applyRadius() {
    _radiusIdx += 1;
    if (_radiusIdx >= 3) _radiusIdx = 0;
    _radiusState = _optionList[2][_radiusIdx];
  }

  void _setShowMagnify() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('magnigyIdx', _magnigyIdx);
  }

  void _applyShowMagnify() {
    _magnigyIdx = 1 - _magnigyIdx;
    _magnigyState = _optionList[0][_magnigyIdx];
  }

  void _setJoin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('join', true);
    _hideModal = true;
  }
}

//* width, height
// class SizeProvider with ChangeNotifier {
//   static double _screenWidth = 0.0;
//   static double _screenHeight = 0.0;
//   double get screenWidth => _screenWidth;
//   double get screenHeight => _screenHeight;

//   void _initWidthHeight(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     _screenWidth = size.width;
//     _screenHeight = size.height;
//   }

//   void initWidthHeight(BuildContext context) => _initWidthHeight(context);
// }

class ScrollProvider with ChangeNotifier {
  static int? _totalPages;
  static bool _loading = true;
  static int _page = 0;
  static bool _working = false;
  static bool _additional = false;

  bool get loading => _loading;
  bool get working => _working;
  bool get additional => _additional;
  int? get totalPages => _totalPages;
  int get page => _page;

  void increasePage() {
    _setPage(_page + 1);
    notifyListeners();
  }

  void initPage() {
    _setPage(0);
    notifyListeners();
  }

  void setWorking(bool newVal) {
    _setWorking(newVal);
    notifyListeners();
  }

  void setAdditional(bool newVal) {
    _setAdditional(newVal);
    notifyListeners();
  }

  void setTotal(int? newVal) {
    _setTotal(newVal);
    notifyListeners();
  }

  void setLoading(bool value) {
    _setLoading(value);
    notifyListeners();
  }

  //* private
  void _setWorking(bool newVal) => _working = newVal;
  void _setAdditional(bool newVal) => _additional = newVal;
  void _setPage(int newVal) => _page = newVal;
  void _setTotal(int? newVal) => _totalPages = newVal;
  void _setLoading(bool value) => _loading = value;
}

//* main, search, review, book mark
class ReviewBookMarkProvider with ChangeNotifier {
  static ToiletModel? _toiletInfo;
  static int? _toiletId;
  static double? _itemHeight;
  static final ReviewList _reviewList = [];
  static final ToiletList _bookmarkList = [];
  static final List<double> _heightList = [];

  //* get
  ToiletModel? get toiletInfo => _toiletInfo;
  int? get toiletId => _toiletId;
  double? get itemHeight => _itemHeight;
  ReviewList get reviewList => _reviewList;
  ToiletList get bookmarkList => _bookmarkList;
  List<double> get heightList => _heightList;

  //* private
  //* review
  FutureReviewList _getReviewList(int page) async {
    final reviewData = await ReviewProvider().getReviewList(_toiletId!, page);
    _addReviewList(reviewData);
    notifyListeners();
    return reviewData;
  }

  void _addReviewList(ReviewList reviewData) => _reviewList.addAll(reviewData);
  void _initReviewList() => _reviewList.clear();
  void _setItemHeight(int i) => _itemHeight = _heightList[i];
  void _setToiletInfo(ToiletModel toiletData) {
    _toiletInfo = toiletData;
    _toiletId = toiletData.toiletId;
  }

  void _initToiletInfo() {
    _toiletInfo = null;
    _toiletId = null;
  }

  void _initHeightList() => _heightList.clear();

  void _setHeightListSize() =>
      _heightList.addAll(List.generate(20, (index) => 0));

  void _setHeight(int i, double newHeight) => _heightList[i] = newHeight;

  //* bookmark
  FutureToiletList _getBookmarkList(int folderId, int page) async {
    final bookmarkList = await BookMarkProvider().getToiletList(folderId, page);
    _addBookmarkList(bookmarkList);
    return bookmarkList;
  }

  void _addBookmarkList(ToiletList bookmarkList) =>
      _bookmarkList.addAll(bookmarkList);

  void _initBookmarkList() => _bookmarkList.clear();

  //* public
  void addReviewList(ReviewList reviewData) => _addReviewList(reviewData);

  FutureToiletList getBookmarkList(int folderId, int page) =>
      _getBookmarkList(folderId, page);

  void initReviewList() => _initReviewList();
  FutureReviewList getReviewList(int page) => _getReviewList(page);

  void setItemHeight(int i) {
    _setItemHeight(i);
    notifyListeners();
  }

  void setToiletInfo(ToiletModel toiletData) {
    _setToiletInfo(toiletData);
    notifyListeners();
  }

  void initToiletInfo() => _initToiletInfo();

  void initBookmarkList() => _initBookmarkList();

  void initHeightList() => _initHeightList();

  void setHeightListSize() {
    _setHeightListSize();
    notifyListeners();
  }

  void setHeight(int i, double newHeight) {
    _setHeight(i, newHeight);
    notifyListeners();
  }
}

class MainSearchProvider with ChangeNotifier {
  static GlobalKey? _globalKey;
  static bool checked = false;
  static final StringList _sortValues = ['distance', 'score', 'comment'];
  // static int _cnt = 20;
  // static final Map<String, String?> _query = {'value': null};
  static double? _lat = 37.537229;
  static double? _lng = 127.005515;
  static int _sortIdx = 0;
  static final ToiletList _mainToiletList = [];
  static final DynamicMap _mainToiletData = {
    'allDay': false,
    'diaper': false,
    'disabled': false,
    'kids': false,
    'lat': _lat,
    'lon': _lng,
    'radius': 1000,
    'page': 0,
    'size': 20,
  };

  static final ToiletList _searchToiletList = [];

  static final DynamicMap _searchData = {
    'allDay': false,
    'diaper': false,
    'disabled': false,
    'kids': false,
    'keyword': null,
    'lat': _lat,
    'lon': _lng,
    'page': 0,
    'size': 20,
    'order': _sortValues[_sortIdx]
  };

  //* getter
  GlobalKey? get globalKey => _globalKey;

  bool get diaper => _mainToiletData['diaper'];
  bool get kids => _mainToiletData['kids'];
  bool get disabled => _mainToiletData['disabled'];
  bool get allDay => _mainToiletData['allDay'];
  int get sortIdx => _sortIdx;

  double? get lat => _lat;
  double? get lng => _lng;
  // int get cnt => _cnt;
  ToiletList get mainToiletList => _mainToiletList;
  DynamicMap get mainToiletData => _mainToiletData;

  ToiletList get searchToiletList => _searchToiletList;
  //* public
  void setKey(GlobalKey key) {
    _setKey(key);
    notifyListeners();
  }
  // void setQuery(String? value) {
  //   _setQuery(value);
  // }

  // void setCnt(int newVal) {
  //   _setCnt(newVal);
  //   notifyListeners();
  // }

  void setFilter(int index, bool value) {
    _setFilter(index, value);
    notifyListeners();
  }

  void setSortIdx(int index) {
    _setSortIdx(index);
    notifyListeners();
  }

  void addToiletList(ToiletList toiletList) {
    _addToiletList(toiletList);
    notifyListeners();
  }

  void initToiletList() => _initToiletList();

  void setLatLng(double newLat, double newLng) {
    _setLatLng(newLat, newLng);
    _applyLatLng();
    notifyListeners();
  }

  void setMainPage(int newVal) => _setMainPage(newVal);
  void setSearchPage(int newVal) => _setSearchPage(newVal);

  FutureToiletList getMainToiletList(int page) => _getMainToiletList(page);

  FutureToiletList getSearchList(int page) => _getSearchList(page);

  void setSearchData(DynamicMap newData) => _setSearchData(newData);

  void initSearchList() => _initSearchList();

  //* private
  FutureToiletList _getMainToiletList(int page) async {
    final toiletData = await ToiletProvider().getNearToilet(_mainToiletData);
    _setMainPage(page + 1);
    _addToiletList(toiletData);
    notifyListeners();
    return toiletData;
  }

  FutureToiletList _getSearchList(int page) async {
    final toiletData = await ToiletProvider().searchToilet(_searchData);
    _setSearchPage(page + 1);
    _searchToiletList.addAll(toiletData);
    notifyListeners();
    return toiletData;
  }

  void _initSearchList() => _searchToiletList.clear();

  void _setSearchData(DynamicMap newData) async {
    _searchData.addAll(newData);
    _searchData['order'] = _sortValues[_sortIdx];
    notifyListeners();
  }

  void _setLatLng(double newLat, double newLng) {
    _lat = newLat;
    _lng = newLng;
  }

  void _applyLatLng() {
    _mainToiletData['lat'] = _lat;
    _mainToiletData['lon'] = _lng;
    _searchData['lat'] = _lat;
    _searchData['lon'] = _lng;
  }

  void _setMainPage(int newVal) => _mainToiletData['page'] = newVal;
  void _setSearchPage(int newVal) => _searchData['page'] = newVal;

  // void _setCnt(int newVal) => _cnt = newVal;
  // void _setQuery(String? value) => _query['value'] = value;
  void _setKey(GlobalKey key) => _globalKey = key;

  void _setFilter(int index, bool value) {
    switch (index) {
      case 0:
        _mainToiletData['diaper'] = value;
        return;
      case 1:
        _mainToiletData['kids'] = value;
        return;
      case 2:
        _mainToiletData['disabled'] = value;
        return;
      default:
        _mainToiletData['allDay'] = value;
        return;
    }
  }

  void _setSortIdx(int index) => _sortIdx = index;

  void _addToiletList(ToiletList toiletList) =>
      _mainToiletList.addAll(toiletList);

  void _initToiletList() => _mainToiletList.clear();
}
