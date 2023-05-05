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

  void setStoreName(String newName) {
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
    print(_pressedOnce);
    if (!_pressedOnce) {
      _pressedOnce = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
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
  static bool? _hasLargeFont, _showMagnify;
  static MapRadius? _radius;
  get hasLargeFont => _hasLargeFont;
  get radius => _radius;
  get showMagnify => _showMagnify;

  Future<bool> initSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _hasLargeFont = prefs.getBool('hasLargeFont');
    final radiusIdx = prefs.getInt('radiusIdx');
    _radius = radiusIdx != null ? toMapRadius(radiusIdx) : null;
    _showMagnify = prefs.getBool('showMagnify');
    return true;
  }

//* public
  void applyHasLargeFont(bool newValue) {
    _setHasLargeFont(newValue);
    _applyHasLargeFont(newValue);
    print('result: $_hasLargeFont');
  }

  void applyRadius(MapRadius radius) {
    _setRadius(radius);
    _applyRadius(radius);
  }

  void applyShowMagnify(bool newValue) {
    _setShowMagnify(newValue);
    _applyShowMagnify(newValue);
  }

//* private

  void _setHasLargeFont(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasLargeFont', newValue);
  }

  void _applyHasLargeFont(bool newValue) {
    _hasLargeFont = newValue;
    notifyListeners();
  }

  void _setRadius(MapRadius radius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('radiusIdx', convertedRadius(radius));
  }

  void _applyRadius(MapRadius newValue) {
    _radius = newValue;
    notifyListeners();
  }

  void _setShowMagnify(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('applyShowMagnify', newValue);
  }

  void _applyShowMagnify(bool newValue) {
    _hasLargeFont = newValue;
    notifyListeners();
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
