import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserProvider {
  // int? _memberId;
  // String? _token, _refresh, _nickname;
  final storage = const FlutterSecureStorage();

  Future<String?> token() => storage.read(key: 'token');
  Future<String?> memberId() => storage.read(key: 'memberId');
  Future<String?> refresh() => storage.read(key: 'refresh');
  Future<String?> nickname() => storage.read(key: 'nickname');

  void _setToken(String newToken) =>
      storage.write(key: 'token', value: newToken);
  void _setRefresh(String newRefresh) =>
      storage.write(key: 'refresh', value: newRefresh);
  void _setName(String newName) =>
      storage.write(key: 'nickname', value: newName);
  void _setId(int newId) =>
      storage.write(key: 'memberId', value: newId.toString());

  void _setVar(dynamic response) {
    final headers = response.headers;
    final data = response.data;
    _setToken(headers['Authorization']!.first);
    _setRefresh(headers['Authorization-refresh']!.first);
    _setName(data['memberId']);
    _setId(data['nickname']);
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
          // return _setVar(response);
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

  void login(BuildContext context) async {
    final accessToken = await token();
    if (accessToken == null || accessToken == '') {
      try {
        return _kakaoLogin(context);
      } catch (error) {
        throw Error();
      }
    }
  }

  void logout() async {
    const storage = FlutterSecureStorage();
    storage.deleteAll();
  }
}
