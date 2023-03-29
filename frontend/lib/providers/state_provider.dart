import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StateProvider extends ChangeNotifier {
  int? _memberId;
  String? _token, _refresh, _nickname;

  String? token() => _token;
  int? memberId() => _memberId;
  String? refresh() => _refresh;
  String? nickname() => _nickname;

  void _setToken(String? newToken) => _token = newToken;
  void _setRefresh(String? newRefresh) => _refresh = newRefresh;
  void _setName(String? newName) => _nickname = newName;
  void _setId(int? newId) => _memberId = newId;

  void initVar() {
    const storage = FlutterSecureStorage();
    final dynamic userInfo = storage.read(key: 'userInfo');
    if (userInfo != null) {
      _setId(userInfo['memberId']);
      _setToken(userInfo['token']);
      _setRefresh(userInfo['refresh']);
      _setName(userInfo['nickname']);
    }
  }

  void setStoreToken(String newToken) {
    _setToken(newToken);
    const storage = FlutterSecureStorage();
    storage.write(key: 'token', value: newToken);
  }

  void setStoreRefresh(String newRefresh) {
    _setRefresh(newRefresh);
    const storage = FlutterSecureStorage();
    storage.write(key: 'refresh', value: newRefresh);
  }

  void setStoreName(String newName) {
    _setRefresh(newName);
    const storage = FlutterSecureStorage();
    storage.write(key: 'nickname', value: newName);
  }

  void setStoreId(int newId) {
    _setId(newId);
    const storage = FlutterSecureStorage();
    storage.write(key: 'memberId', value: newId.toString());
  }
}
