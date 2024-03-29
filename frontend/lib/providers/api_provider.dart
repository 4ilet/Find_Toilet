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
  String addToiletUrl = '$_bookmarkUrl/add';
  String deleteToiletUrl({required int folderId, required int toiletId}) =>
      '$_bookmarkUrl/delete/toilet/$folderId/$toiletId';

  //* toilet
  static const _toiletUrl = '/toilet';
  final nearToiletUrl = '$_toiletUrl/near';
  String eachToiletUrl(int toiletId) => '$_toiletUrl/$toiletId';
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
  final dio = Dio(BaseOptions(baseUrl: _baseUrl!));

  Dio dioWithToken({
    required String url,
    required String method,
    dynamic data,
  }) {
    final tempDio = Dio(
      BaseOptions(
        baseUrl: _baseUrl!,
        headers: {'Authorization': token},
      ),
    );
    tempDio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        if (e.response?.statusCode == 401) {
          //* token refresh
          _refreshToken(
            url: url,
            method: method,
            data: data,
          ).then((response) async {
            UserInfoProvider().setStoreToken(response['token']);
            UserInfoProvider().setStoreRefresh(response['refresh']);
            //* 재요청

            e.requestOptions.headers['Authorization'] = response['token'];
            final secondRes = await dio.fetch(e.requestOptions);
            return handler.resolve(secondRes);
          }).catchError((error) {
            UserInfoProvider().setStoreToken(null);
            UserInfoProvider().setStoreRefresh(null);
          });
        } else {
          if (e.response?.statusCode == 403) {
            UserInfoProvider().setStoreToken(null);
            UserInfoProvider().setStoreRefresh(null);
          }
          return handler.next(e);
        }
      },
    ));
    return tempDio;
  }

  Dio _dioWithRefresh(String method) {
    final tempDio = Dio(
      BaseOptions(
        baseUrl: _baseUrl!,
        headers: {
          'Authorization-refresh': refresh,
          'Authorization': token,
          'method': method,
        },
      ),
    );
    return tempDio;
  }

  //*
  FutureDynamicMap _refreshToken({
    required String url,
    required String method,
    dynamic data,
  }) async {
    try {
      final response = await _dioWithRefresh(method).request(url, data: data);
      if (response.statusCode == 200) {
        final headers = response.headers;
        return {
          'token': headers['Authorization']!.first,
          'refresh': headers['Authorization-refresh']!.first,
        };
      } else {
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
      final response = await dioWithToken(
        url: url,
        method: 'POST',
        data: data,
      ).post(url, data: data);
      if (response.statusCode == 200) {
        return true;
      }
      throw Error();
    } catch (error) {
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
      final response = await dioWithToken(
        url: url,
        method: 'PUT',
        data: data,
      ).put(url, data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Error();
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
      final response =
          await dioWithToken(url: url, method: 'DELETE').delete(url);
      if (response.statusCode == 200) {
        return true;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  FutureBool deleteApi(String url) async => _deleteApi(url);
}
