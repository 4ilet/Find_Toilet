import 'package:dio/dio.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
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

  //* public function
  void login() => _login();
  void logout() => _logout();

  void autoLogin(String? accessToken) async {
    try {
      if (accessToken != null && accessToken != '') {
        _sendToken(accessToken);
      }
    } catch (error) {
      return _logout();
    }
  }

  void deleteUser() => _deleteUser();

  FutureBool refreshToken({
    required String url,
    required BaseOptions options,
    required String method,
    dynamic data,
  }) =>
      _refreshToken(url: url, options: options, method: method, data: data);

  void changeName(String newName) => _changeName(newName);

  //* private function
  void _setVar(dynamic response) {
    final headers = response.headers;
    _setToken(headers['Authorization']!.first);
    _setRefresh(headers['Authorization-refresh']!.first);
  }

  void _sendToken(String token) async {
    try {
      final response = await dio.post(_loginUrl, data: {'token': token});
      switch (response.statusCode) {
        case 200:
          return _setVar(response);
        case 401:
          //* refresh token
          return;
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  void _kakaoLogin(bool withKakaoTalk) async {
    try {
      OAuthToken kakaoResponse;
      if (withKakaoTalk) {
        kakaoResponse = await UserApi.instance.loginWithKakaoTalk();
      } else {
        kakaoResponse = await UserApi.instance.loginWithKakaoAccount();
      }
      _sendToken(kakaoResponse.accessToken);
    } catch (error) {
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
        return _kakaoLogin(true);
      } catch (error) {
        return _kakaoLogin(false);
      }
    }
    //* 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    return _kakaoLogin(false);
  }

  void _logout() async {
    print('로그아웃 함수 들어옴');
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    print(await storage.readAll());
  }

  void _deleteUser() {
    try {
      ApiProvider.deleteApi(_deleteUserUrl);
    } catch (error) {
      throw Error();
    }
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

  FutureBool _refreshToken({
    required String url,
    required BaseOptions options,
    required String method,
    dynamic data,
  }) async {
    try {
      final refreshToken = await refresh();
      options.headers['Authorization-refresh'] = refreshToken;
      options.method = method;
      final dioWithRefresh = Dio(options);
      final response = await dioWithRefresh.request(url, data: data);
      switch (response.statusCode) {
        case 200:
          _setVar(response);
          return true;
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }
}
