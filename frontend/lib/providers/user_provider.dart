import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserProvider extends ApiProvider {
  //* public function
  FutureDynamicMap login() => _login();
  FutureDynamicMap autoLogin() async {
    print('token: $token');
    try {
      if (token != null && token != '') {
        print('sned');
        return _sendOldToken(token!);
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  void deleteUser() => _deleteUser();

  FutureDynamicMap changeName(String newName) => _changeName(newName);

  //* private function
  StringMap _returnTokens(dynamic response) {
    final headers = response.headers;
    return {
      'token': headers['Authorization']!.first,
      'refresh': headers['Authorization-refresh']!.first,
      'state': response.data['state']
    };
  }

  FutureDynamicMap _sendOldToken(String token) async {
    try {
      final response = await dioWithToken().get(userInfoUrl);
      switch (response.statusCode) {
        case 200:
          return {};
        case 401:
          final result = await refreshToken(url: userInfoUrl, method: 'GET');
          return result;
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap _sendToken(String token) async {
    try {
      final response =
          await dioWithToken().post(loginUrl, data: {'token': token});
      print(response);
      switch (response.statusCode) {
        case 200:
          return _returnTokens(response);
        case 401:
          final result = await refreshToken(url: loginUrl, method: 'POST');
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
      deleteApi(deleteUserUrl);
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap _changeName(String newName) async {
    try {
      final response = await dioWithToken().put(
        changeNameUrl,
        data: {'nickname': newName},
      );
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 400:
          return {'message': '이미 존재하는 닉네임입니다.'};
        case 401:
          final success = await refreshToken(
            url: changeNameUrl,
            method: 'POST',
            data: {'nickname': newName},
          );
          return _changeName(newName);
        default:
          throw Error();
      }
    } catch (error) {
      print(error);
      throw Error();
    }
  }
}
