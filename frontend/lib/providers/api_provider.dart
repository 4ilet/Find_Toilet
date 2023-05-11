import 'package:dio/dio.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlClass extends UserInfoProvider {
  //* bookmark folder
  static const _bookmarkUrl = '/like';
  final folderListUrl = '$_bookmarkUrl/folder';
  final createFolderUrl = '$_bookmarkUrl/create/folder';
  String updateFolderUrl(int folderId) =>
      '$_bookmarkUrl/update/folder/$folderId';
  String deleteFolderUrl(int folderId) =>
      '$_bookmarkUrl/delete/folder/$folderId';

  //* bookmark
  String bookmarkListUrl(int folderId) =>
      '$_bookmarkUrl/folder/toiletlist/$folderId';
  String addToiletUrl({required int folderId, required int toiletId}) =>
      '$_bookmarkUrl/add/folder/$folderId/$toiletId';
  String deleteToiletUrl({required int folderId, required int toiletId}) =>
      '$_bookmarkUrl/delete/toilet/$folderId/$toiletId';

  //* toilet
  static const _toiletUrl = '/toilet';
  final nearToiletUrl = '$_toiletUrl/near';
  final searchToiletUrl = '$_toiletUrl/search';

  //* review
  static const _reviewUrl = '/review';
  String reviewListUrl(int toiletId) => '$_reviewUrl/$toiletId';
  String reviewUrl(int reviewId) => '$_reviewUrl/get/$reviewId';
  String postReviewUrl(int toiletId) => '$_reviewUrl/post/$toiletId';
  String updateReviewUrl(int reviewId) => '$_reviewUrl/update/$reviewId';
  String deleteReviewUrl(int reviewId) => '$_reviewUrl/delete/$reviewId';

  //* user
  static const _userUrl = '/user';
  final loginUrl = '$_userUrl/login';
  final deleteUserUrl = '$_userUrl/delete';
  final changeNameUrl = '$_userUrl/update/nickname/';
  final userInfoUrl = '$_userUrl/userinfo';
}

class ApiProvider extends UrlClass {
  static final _baseUrl = dotenv.env['baseUrl'];
  final dio =
      Dio(BaseOptions(baseUrl: _baseUrl!, receiveDataWhenStatusError: true));

  dioWithToken() {
    final tempDio = Dio(
      BaseOptions(
        baseUrl: _baseUrl!,
        headers: {'Authorization': token},
        receiveDataWhenStatusError: true,
      ),
    );
    // tempDio.interceptors.add(InterceptorsWrapper(
    //   onError: (e, handler) {
    //     if (e.response?.statusCode == 401) {}
    //   },
    // ));
    return tempDio;
  }

  dioWithRefresh(String method) => Dio(
        BaseOptions(
          baseUrl: _baseUrl!,
          method: method,
          headers: {'Authorization-refresh': refresh},
          receiveDataWhenStatusError: true,
        ),
      );
  //*
  FutureDynamicMap _refreshToken({
    required String url,
    required String method,
    dynamic data,
  }) async {
    try {
      final response = await dioWithRefresh(method).request(url, data: data);
      switch (response.statusCode) {
        case 200:
          final headers = response.headers;
          return {
            'token': headers['Authorization']!.first,
            'refresh': headers['Authorization-refresh']!.first,
          };
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap refreshToken({
    required String url,
    required String method,
    dynamic data,
  }) =>
      _refreshToken(url: url, method: method, data: data);

  //* 생성 전반
  FutureBool _createApi(String url, {required DynamicMap data}) async {
    try {
      //* token
      if (token != '') {
        final response = await dioWithToken().post(url, data: data);
        switch (response.statusCode) {
          case 200:
            return true;
          case 401:
            final success = await refreshToken(
              url: url,
              method: 'POST',
              data: data,
            );
            _createApi(url, data: data);
            return false;
          default:
            throw Error();
        }
      } else {
        //* 로그인 할 것인지 묻는 팝업
        return false;
      }
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  FutureBool createApi(
    String url, {
    required DynamicMap data,
  }) async {
    return _createApi(
      url,
      data: data,
    );
  }

  //* 수정 전반
  FutureDynamicMap _updateApi(String url, {required DynamicMap data}) async {
    try {
      final response = await dioWithToken().put(url, data: data);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          final success = await refreshToken(
            url: url,
            method: 'POST',
            data: data,
          );
          return _updateApi(url, data: data);
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  FutureDynamicMap updateApi(String url, {required DynamicMap data}) async {
    return _updateApi(url, data: data);
  }

  //* 삭제 전반
  FutureBool _deleteApi(String url) async {
    try {
      final response = await dioWithToken().delete(url);
      print(response.statusCode);
      print(response.data);
      switch (response.statusCode) {
        case 200:
          return true;
        case 401:
          await refreshToken(
            url: url,
            method: 'DELETE',
          );
          _deleteApi(url);
          return false;
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  FutureBool deleteApi(String url) async => _deleteApi(url);
}
