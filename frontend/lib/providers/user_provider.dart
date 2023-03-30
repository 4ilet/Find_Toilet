import 'package:find_toilet/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserProvider {
  //* url
  static const _userUrl = '/user';
  static const _loginUrl = '$_userUrl/login';
  static const _deleteUserUrl = '$_userUrl/delete';
  static const _changeNameUrl = '$_userUrl/update/nickname/';
  static const _userInfoUrl = '$_userUrl/userinfo';

  //* storage
  final storage = const FlutterSecureStorage();

  Future<String?> token() => storage.read(key: 'token');
  Future<String?> refresh() => storage.read(key: 'refresh');
  Future<String?> nickname() => storage.read(key: 'nickname');

  void _setToken(String newToken) =>
      storage.write(key: 'token', value: newToken);
  void _setRefresh(String newRefresh) =>
      storage.write(key: 'refresh', value: newRefresh);
  void _setName(String newName) =>
      storage.write(key: 'nickname', value: newName);

  void _setVar(dynamic response) {
    final headers = response.headers;
    _setToken(headers['Authorization']!.first);
    _setRefresh(headers['Authorization-refresh']!.first);
  }

  void _kakaoLogin(bool withKakaoTalk) async {
    try {
      OAuthToken kakaoResponse;
      if (withKakaoTalk) {
        kakaoResponse = await UserApi.instance.loginWithKakaoTalk();
      } else {
        kakaoResponse = await UserApi.instance.loginWithKakaoAccount();
      }
      final response =
          await dio.post(_loginUrl, data: {'token': kakaoResponse.accessToken});
      if (response.statusCode == 200) {
        return _setVar(response);
      }
      throw Error();
    } catch (error) {
      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      throw Error();
    }
  }

  void _login() async {
    //* 카카오톡 설치 여부 확인
    if (await isKakaoTalkInstalled()) {
      try {
        _kakaoLogin(true);
      } catch (error) {
        return _kakaoLogin(false);
      }
    }
    //* 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    return _kakaoLogin(false);
  }

  void _logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  void loginOrLogout(BuildContext context) async {
    final accessToken = await token();
    if (accessToken == null || accessToken == '') {
      try {
        return _login();
      } catch (error) {
        throw Error();
      }
    } else {
      try {
        _logout();
      } catch (error) {
        throw Error();
      }
    }
  }

  void _deleteUser() {
    ApiProvider.deleteApi(_deleteUserUrl);
  }

  void deleteUser() {
    _deleteUser();
  }

  void _changeName(String newName) async {
    try {
      final success = await ApiProvider.updateApi(
        _changeNameUrl,
        data: {'nickname': newName},
      );
      if (success) {
        _setName(newName);
      } else {}
    } catch (error) {}
  }

  void changeName(String newName) => _changeName(newName);
}
