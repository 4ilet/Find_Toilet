import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _token, _refresh, _nickname;
  String? get token => _token;
  String? get refresh => _refresh;
  String? get nickname => _nickname;
  var storage = const FlutterSecureStorage();

  void debugFillProperites(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('token', token));
    properties.add(StringProperty('refresh', refresh));
    properties.add(StringProperty('nickname', nickname));
  }

  void _setToken(String? newToken) => _token = newToken;
  void _setRefresh(String? newRefresh) => _refresh = newRefresh;
  void _setName(String? newName) => _nickname = newName;

  void initVar() {
    final dynamic userInfo = storage.read(key: 'userInfo');
    if (userInfo != null) {
      _setToken(userInfo['token']);
      _setRefresh(userInfo['refresh']);
      _setName(userInfo['nickname']);
      storage = const FlutterSecureStorage();
      notifyListeners();
    }
  }

  void setStoreToken(String newToken) {
    _setToken(newToken);
    storage.write(key: 'token', value: newToken);
    storage = const FlutterSecureStorage();
    notifyListeners();
  }

  void setStoreRefresh(String newRefresh) {
    _setRefresh(newRefresh);
    storage.write(key: 'refresh', value: newRefresh);
    storage = const FlutterSecureStorage();
    notifyListeners();
  }

  void setStoreName(String newName) {
    _setRefresh(newName);
    storage.write(key: 'nickname', value: newName);
    storage = const FlutterSecureStorage();
    notifyListeners();
  }
}
