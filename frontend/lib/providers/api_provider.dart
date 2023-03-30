import 'package:dio/dio.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//* baseUrl
final baseUrl = dotenv.env['baseUrl'];
final dio = Dio(BaseOptions(baseUrl: baseUrl!));

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
  static FutureBool _createApi(String url, {required DynamicMap data}) async {
    try {
      //* token
      final token = await UserProvider().token();
      if (token != null && token != '') {
        final options =
            BaseOptions(baseUrl: baseUrl!, headers: {'Authorization': token});
        final dioWithToken = Dio(options);

        final response = await dioWithToken.post(url, data: data);
        switch (response.statusCode) {
          case 200:
            return true;
          case 401:
            return false;
          default:
            throw Error();
        }
      } else {
        //* 로그인 할 것인지 묻는 팝업
        return false;
      }
    } catch (error) {
      throw Error();
    }
  }

  static FutureBool createApi(String url, {required DynamicMap data}) async {
    return _createApi(url, data: data);
  }

  //* 수정 전반
  static FutureBool _updateApi(String url, {required DynamicMap data}) async {
    try {
      final response = await dio.put(url, data: data);
      switch (response.statusCode) {
        case 200:
          return true;
        case 401:
          return false;
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  static FutureBool updateApi(String url, {required DynamicMap data}) async {
    return _updateApi(url, data: data);
  }

  //* 삭제 전반
  static FutureBool _deleteApi(String url) async {
    try {
      final response = await dio.delete(url);
      switch (response.statusCode) {
        case 200:
          return true;
        case 401:
          return false;
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  static FutureBool deleteApi(String url) async {
    return _deleteApi(url);
  }
}
