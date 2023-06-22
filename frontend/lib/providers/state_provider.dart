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
  static late int _magnigyIdx, _radiusIdx;
  static int? _fontIdx;
  static String? _fontState;
  static late String _magnigyState, _radiusState;
  final List<StringList> _optionList = [
    ['표시 안 함', '표시함'],
    ['큰 글씨', '기본'],
    ['좁게', '보통', '넓게'],
  ];
  final _valueList = [700, 1000, 2000];

  get fontState => _fontState;
  get magnigyState => _magnigyState;
  get radiusState => _radiusState;
  get radius => _valueList[_radiusIdx];

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
}

//* width, height
class SizeProvider with ChangeNotifier {
  static double _screenWidth = 0.0;
  static double _screenHeight = 0.0;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  void _initWidthHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  void initWidthHeight(BuildContext context) => _initWidthHeight(context);
}

//* main, search
class GlobalProvider with ChangeNotifier {
  static GlobalKey? _globalKey;
  static int? _totalPages;
  static bool _loading = true;
  static int _page = 0;
  // static int _cnt = 20;
  static bool _working = false;
  static bool _additional = false;
  static bool _diaper = false;
  static bool _kids = false;
  static bool _disabled = false;
  static bool _allDay = false;
  static int _sortIdx = 0;
  static double _lat = 37.537229;
  static double _lng = 127.005515;
  // static final Map<String, String?> _query = {'value': null};
  static final ReviewList _reviewList = [];
  static final ToiletList _mainToiletList = [];
  static final DynamicMap _mainToiletData = {
    'allDay': _allDay,
    'diaper': _diaper,
    'disabled': _disabled,
    'kids': _kids,
    'lat': _lat,
    'lon': _lng,
    'radius': 1000,
    'page': _page,
    'size': 20,
  };

//   static final DynamicMap _searchData = {
//       'allDay': _allDay,
//     'diaper': _diaper,
//     'disabled': _disabled,
//     'kids': _kids,
//       'keyword': null,
//       // 'keyword': readQuery(context),
// 'lat': _lat,
//     'lon': _lng,
//       'page': 0,
//       'size': 20,
//       'order': sortValues[sortIdx],
//     }

  //* getter
  GlobalKey? get globalKey => _globalKey;
  bool get loading => _loading;
  bool get working => _working;
  bool get additional => _additional;
  bool get diaper => _diaper;
  bool get kids => _kids;
  bool get disabled => _disabled;
  bool get allDay => _allDay;
  int get sortIdx => _sortIdx;
  int? get totalPages => _totalPages;
  int get page => _page;
  // String? get query => _query['value'];
  double? get lat => _lat;
  double? get lng => _lng;
  // int get cnt => _cnt;
  ToiletList get mainToiletList => _mainToiletList;
  DynamicMap get mainToiletData => _mainToiletData;
  ReviewList get reviewList => _reviewList;

  //* public
  void setKey(GlobalKey key) {
    _setKey(key);
    notifyListeners();
  }

  void increasePage() {
    _setPage(_page + 1);
    notifyListeners();
  }

  void initPage() {
    _setPage(0);
    notifyListeners();
  }

  // void setQuery(String? value) {
  //   _setQuery(value);
  // }

  // void setCnt(int newVal) {
  //   _setCnt(newVal);
  //   notifyListeners();
  // }

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

  void setFilter(int index, bool value) {
    _setFilter(index, value);
    notifyListeners();
  }

  void applyFilter(int index) => _applyFilter(index);

  void setSortIdx(int index) {
    _setSortIdx(index);
    notifyListeners();
  }

  void addToiletList(ToiletList toiletList) {
    _addToiletList(toiletList);
    notifyListeners();
  }

  void addReviewList(ReviewList reviewData) {
    _addReviewList(reviewData);
    notifyListeners();
  }

  void initToiletList() {
    _initToiletList();
  }

  void initReviewList() {
    _initReviewList();
  }

  void setLoading(bool value) {
    _setLoading(value);
    notifyListeners();
  }

  void setLatLng(double newLat, double newLng) {
    _setLatLng(newLat, newLng);
    notifyListeners();
  }

  // void refreshMain(bool showReview, int? toiletId) {
  //   _refreshMain(showReview, toiletId);
  //   notifyListeners();
  // }

  void initMainData({required bool showReview, int? toiletId}) {
    print('in!! loading : $loading');
    if (_loading) {
      print('call');
      showReview ? _getReviewList(toiletId!) : _getToiletList();
    }
  }

  void _getReviewList(int toiletId) {
    ReviewProvider().getReviewList(toiletId, _page).then((reviewData) {
      // print('reivew data : $reviewData');
      _initReviewList();
      // print('초기화 $_reviewList');
      _addReviewList(reviewData);
      // print('add $reviewList');
      _setLoading(false);
      notifyListeners();
      // print('전역 갱신 ${_reviewList[0].comment}');
    });
    increasePage();
  }

  void _getToiletList() {
    ToiletProvider().getNearToilet(_mainToiletData).then((toiletData) {
      _initToiletList();
      _addToiletList(toiletData);
      _setLoading(false);
      notifyListeners();
    });
    increasePage();
  }

  //* private
  // void _setCnt(int newVal) => _cnt = newVal;
  // void _setQuery(String? value) => _query['value'] = value;
  void _setKey(GlobalKey key) => _globalKey = key;
  void _setWorking(bool newVal) => _working = newVal;
  void _setAdditional(bool newVal) => _additional = newVal;
  void _setPage(int newVal) => _page = newVal;
  void _setTotal(int? newVal) => _totalPages = newVal;

  void _setFilter(int index, bool value) {
    switch (index) {
      case 0:
        _diaper = value;
        return;
      case 1:
        _kids = value;
        return;
      case 2:
        _disabled = value;
        return;
      default:
        _allDay = value;
        return;
    }
  }

  void _applyFilter(int index) {
    switch (index) {
      case 0:
        _mainToiletData['diaper'] = _diaper;
        return;
      case 1:
        _mainToiletData['kids'] = _kids;
        return;
      case 2:
        _mainToiletData['disabled'] = _disabled;
        return;
      default:
        _mainToiletData['allDay'] = _allDay;
        return;
    }
  }

  void _setSortIdx(int index) => _sortIdx = index;

  void _addToiletList(ToiletList toiletList) =>
      _mainToiletList.addAll(toiletList);

  void _addReviewList(ReviewList reviewData) => _reviewList.addAll(reviewData);

  void _initToiletList() => _mainToiletList.clear();

  void _initReviewList() => _reviewList.clear();

  void _setLoading(bool value) => _loading = value;

  void _setLatLng(double newLat, double newLng) {
    _lat = newLat;
    _lng = newLng;
    _mainToiletData['lat'] = newLat;
    _mainToiletData['lon'] = newLng;
  }

  // void _refreshMain(bool showReview, int? toiletId) {
  //   if (!_loading) {
  //     _setLoading(true);
  //     if (_loading) {
  //       if (showReview) {
  //         _initToiletList();
  //         ToiletProvider().getNearToilet(_mainToiletData).then((data) {
  //           _addToiletList(data);
  //           _setLoading(false);
  //         });
  //       } else {
  //         _initReviewList();
  //         ReviewProvider()
  //             .getReviewList(toiletId!, _totalPages!)
  //             .then((reviewData) {
  //           _addReviewList(reviewData);
  //           _setLoading(false);
  //         });
  //       }
  //     }
  //   }
  // }
}
