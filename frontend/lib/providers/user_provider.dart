import 'package:find_toilet/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  var _memberId = 13;
  var _token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImlkIjoxMywiZXhwIjoxNjc5OTkxNzE0LCJlbWFpbCI6InB1YmhhbjM1QGdtYWlsLmNvbSJ9.hbUZNKt9bELRQF76JooTXUHmnoobK2McIHNqTZG7KW4FMnpXmc3Z6sEw7FsDCuHCHKm74ATiy1lQ02gxOdWwcg';
  var _refresh =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE2ODExMTQ5MTR9.M6Op-o85eKii9yoE1iipQE2RIZAjN7pR7TObU7lA6y_W4OYPKHU0dxhOtBrqggoeqztCDr1CK39i8KebPxWrcA';
  var _nickname = '포일렛';

  String? getToken() => _token;
  String? getRefresh() => _refresh;
  String? getName() => _nickname;
  int? getId() => _memberId;

  void _setToken(String newToken) => _token = newToken;
  void _setRefresh(String newRefresh) => _refresh = newRefresh;
  void _setName(String newName) => _nickname = newName;
  void _setId(int newId) => _memberId = newId;

  void _kakaoLogin(BuildContext context) async {
    OAuthToken accessToken = await UserApi.instance.loginWithKakaoAccount();
    final response = await dio.post(loginUrl, data: {'token': accessToken});
    if (response.statusCode == 200) {
      _setToken(response.headers['Authorization']!.first);
      _setRefresh(response.headers['Authorization-refresh']!.first);
    }
    //* 카카오톡 설치 여부 확인
    // if (await isKakaoTalkInstalled()) {
    //   try {
    //     await UserApi.instance.loginWithKakaoTalk();
    //   } catch (error) {
    //     // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
    //     // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
    //     if (error is PlatformException && error.code == 'CANCELED') {
    //       return;
    //     }
    //     //* 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    //     try {
    //       var accessToken = await UserApi.instance.loginWithKakaoAccount();
    //       print(accessToken);
    //     } catch (error) {
    //       showModal(context: context, page: errorModal)();
    //     }
    //   }
    // } else {
    //   try {
    //     var accessToken = await UserApi.instance.loginWithKakaoAccount();
    //     print(accessToken);
    //   } catch (error) {
    //     showModal(context: context, page: errorModal)();
    //   }
    // }
  }

  void login(BuildContext context) {
    _kakaoLogin(context);
    // final token = getToken();
    // if (token == null || token == '') {
    //   try {
    //     return _kakaoLogin(context);
    //   } catch (error) {
    //     throw Error();
    //   }
    // }
  }

  void logout() async {
    _setId(0);
    _setName('');
    _setToken('');
    _setRefresh('');
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // prefs.remove('id');
    // prefs.remove('name');
    // prefs.remove('token');
    // prefs.remove('refresh');
  }
}
