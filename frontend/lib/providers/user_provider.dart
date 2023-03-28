import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  int? _memberId;
  String? _token, _refresh, _nickname;

  String? getToken() => _token;
  String? getRefresh() => _refresh;
  String? getName() => _nickname;
  int? getId() => _memberId;

  void _setToken(String? newToken) => _token = newToken;
  void _setRefresh(String? newRefresh) => _refresh = newRefresh;
  void _setName(String? newName) => _nickname = newName;
  void _setId(int? newId) => _memberId = newId;

  void _setVar(dynamic response) async {
    final prefs = await SharedPreferences.getInstance();
    // _setToken(response.headers['Authorization']!.first);
    // _setRefresh(response.headers['Authorization-refresh']!.first);
    // _setId(response.data['memberId']);
    // _setName(response.data['nickname']);
  }

  void _kakaoLoginWithAccount(BuildContext context) async {
    try {
      OAuthToken kakaoResponse = await UserApi.instance.loginWithKakaoAccount();
      final response =
          await dio.post(loginUrl, data: {'token': kakaoResponse.accessToken});
      if (response.statusCode == 200) {
        _setVar(response);
      }
      showModal(context,
          page: const AlertModal(
            title: '로그인 오류',
            content: '오류가 발생해 로그인이 되지 않았습니다',
          ))();
    } catch (error) {
      showModal(context,
          page: const AlertModal(
            title: '로그인 오류',
            content: '오류가 발생해 로그인이 되지 않았습니다',
          ))();
    }
  }

  void _kakaoLogin(BuildContext context) async {
    //* 카카오톡 설치 여부 확인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken kakaoResponse = await UserApi.instance.loginWithKakaoTalk();
        final response = await dio
            .post(loginUrl, data: {'token': kakaoResponse.accessToken});
        if (response.statusCode == 200) {
          return _setVar(response);
        }
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        return _kakaoLoginWithAccount(context);
      }
    }
    //* 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    _kakaoLoginWithAccount(context);
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
    _setId(null);
    _setName(null);
    _setToken(null);
    _setRefresh(null);
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // prefs.remove('id');
    // prefs.remove('name');
    // prefs.remove('token');
    // prefs.remove('refresh');
  }
}
