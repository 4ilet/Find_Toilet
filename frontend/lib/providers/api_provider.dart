import 'package:dio/dio.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//* baseUrl
final baseUrl = dotenv.env['baseUrl'];
final options = BaseOptions(
  baseUrl: baseUrl!,
  headers: {'Authorization': UserProvider().token()},
);
final dio = Dio(options);

//* user
const userUrl = '/user';
const loginUrl = '$userUrl/login';
const changeNameUrl = '$userUrl/update/nickname/';
const userInfoUrl = '$userUrl/userinfo';

//* review
const reviewUrl = '/review';
String reviewListUrl(int toiletId) => '$reviewUrl/$toiletId';
String postReviewUrl(int toiletId) =>
    '$reviewUrl/post/${UserProvider().memberId()}/$toiletId';
String updateReviewUrl(int reviewId) => '$reviewUrl/update/$reviewId';
String deleteReviewUrl(int reviewId) => '$reviewUrl/delete/$reviewId';

//* bookmark

const bookmarkUrl = '/like';
String folderListUrl() => '$bookmarkUrl/folder/${UserProvider().memberId()}';
String createFolderUrl() =>
    '$bookmarkUrl/create/folder/${UserProvider().memberId()}';
String updateFolderUrl(int folderId) => '$bookmarkUrl/update/folder/$folderId';
String deleteFolderUrl(int folderId) => '$bookmarkUrl/delete/folder/$folderId';

String bookmarkListUrl(int folderId) =>
    '$bookmarkUrl/folder/toiletlist/$folderId';
String addToiletUrl({required int folderId, required int toiletId}) =>
    '$bookmarkUrl/add/folder/$folderId/$toiletId';
String deleteToiletUrl({required int folderId, required int toiletId}) =>
    '$bookmarkUrl/delete/$folderId/$toiletId';

//* mixin
class ApiProvider {
  //* 조회 전반
  // static FutureList _getAPi({
  //   required List list,
  //   required String url,
  //   required dynamic model,
  // }) async {
  //   try {
  //     final response = await dio.get(url);
  //     if (response.statusCode == 200) {
  //       response.data.forEach((element) {
  //         list.add(model.fromJson(element));
  //       });
  //       return list;
  //     }
  //     throw Error();
  //   } catch (error) {
  //     print(error);
  //     throw Error();
  //   }
  // }

  // static FutureList getApi({
  //   required List list,
  //   required String url,
  //   required dynamic model,
  // }) async {
  //   return _getAPi(list: list, url: url, model: model);
  // }

  //* 생성 전반
  static FutureVoid _createApi(String url, {required DynamicMap data}) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  static FutureVoid createApi(String url, {required DynamicMap data}) async {
    _createApi(url, data: data);
  }

  //* 수정 전반
  static FutureVoid _updateApi(String url, {required DynamicMap data}) async {
    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == 200) {
        return;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  static FutureVoid updateApi(String url, {required DynamicMap data}) async {
    _updateApi(url, data: data);
  }

  //* 삭제 전반
  static FutureVoid _deleteApi(String url) async {
    try {
      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        return;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  static FutureVoid deleteApi(String url) async {
    _deleteApi(url);
  }
}
