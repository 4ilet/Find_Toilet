import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

class UserProvider extends ApiProvider {
  //* url
  static const _userUrl = '/user';
  static const _loginUrl = '$_userUrl/login';
  static const _deleteUserUrl = '$_userUrl/delete';
  static const _changeNameUrl = '$_userUrl/update/nickname/';
  static const _userInfoUrl = '$_userUrl/userinfo';

  //* public function
  FutureDynamicMap login() => _login();
  FutureDynamicMap autoLogin() async {
    try {
      if (token != null && token != '') {
        return _sendToken(token!);
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  void deleteUser() => _deleteUser();

  void changeName(String newName) => _changeName(newName);

  //* private function
  StringMap _returnTokens(dynamic response) {
    final headers = response.headers;
    return {
      'token': headers['Authorization']!.first,
      'refresh': headers['Authorization-refresh']!.first,
      'state': response.data['state']
    };
  }

  FutureDynamicMap _sendToken(String token) async {
    try {
      final response =
          await dioWithToken().post(_loginUrl, data: {'token': token});
      switch (response.statusCode) {
        case 200:
          print(response);
          return _returnTokens(response);
        case 401:
          final result = await refreshToken(url: _loginUrl, method: 'POST');
          return {'result': result};
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap _kakaoLogin(bool withKakaoTalk) async {
    try {
      OAuthToken kakaoResponse;
      if (withKakaoTalk) {
        kakaoResponse = await UserApi.instance.loginWithKakaoTalk();
      } else {
        kakaoResponse = await UserApi.instance.loginWithKakaoAccount();
      }
      return _sendToken(kakaoResponse.accessToken);
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        return {'result': false};
      }
      throw Error();
    }
  }

  FutureDynamicMap _login() async {
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

  void _deleteUser() {
    try {
      deleteApi(_deleteUserUrl);
    } catch (error) {
      throw Error();
    }
  }

  void _changeName(String newName) async {
    try {
      final success = await updateApi(
        _changeNameUrl,
        data: {'nickname': newName},
      );
      if (success) {
        setStoreName(newName);
      } else {}
    } catch (error) {}
  }
}

//* 토큰 받아오기
String? getToken(BuildContext context) =>
    context.read<UserInfoProvider>().token;

//* 토큰 변경
void changeToken(BuildContext context, {String? token, String? refresh}) {
  final userInfo = context.read<UserInfoProvider>();
  userInfo.setStoreToken(token);
  userInfo.setStoreRefresh(refresh);
}
