import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserProvider extends ApiProvider {
  //* public function
  FutureDynamicMap login() => _login();
  FutureDynamicMap autoLogin() async {
    try {
      if (token != null && token != '') {
        return _sendOldToken(token!);
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  FutureBool deleteUser() => _deleteUser();

  FutureDynamicMap changeName(String newName) => _changeName(newName);

  //* private function
  DynamicMap _returnTokens(dynamic response) {
    final headers = response.headers;
    final data = response.data;
    return {
      'token': headers['Authorization']!.first,
      'refresh': headers['Authorization-refresh']!.first,
      'state': data['state'],
      'nickname': data['data']['nickname']
    };
  }

  FutureDynamicMap _sendOldToken(String token) async {
    try {
      await dioWithToken(url: userInfoUrl, method: 'GET').get(userInfoUrl);
      return {};
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap _sendToken(String token) async {
    try {
      final response = await dioWithToken(url: loginUrl, method: 'POST')
          .post(loginUrl, data: {'token': token});
      return _returnTokens(response);
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap _kakaoLogin(bool withKakaoTalk) async {
    try {
      OAuthToken kakaoResponse;
      if (withKakaoTalk) {
        kakaoResponse = await UserApi.instance.loginWithKakaoTalk();
        return _sendToken(kakaoResponse.accessToken);
      } else {
        kakaoResponse = await UserApi.instance.loginWithKakaoAccount();
        return _sendToken(kakaoResponse.accessToken);
      }
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        return {'result': false};
      } else if (error is KakaoAuthException) {
        return {'result': false};
      }
      print('$error & ${error.runtimeType}');
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

  FutureBool _deleteUser() async {
    try {
      await deleteApi(deleteUserUrl);
      return Future.value(true);
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap _changeName(String newName) async {
    try {
      final data = {'nickname': newName};
      final response = await updateApi(changeNameUrl, data: data);
      return response;
    } catch (error) {
      throw Error();
    }
  }
}
