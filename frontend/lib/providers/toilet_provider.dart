import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

class ToiletProvider extends ApiProvider {
  Future<ToiletList> getNearToilet(DynamicMap queryData) async {
    try {
      final response = token == null
          ? await dio.get(
              nearToiletUrl,
              queryParameters: queryData,
            )
          : await dioWithToken(url: nearToiletUrl).get(
              nearToiletUrl,
              queryParameters: queryData,
            );
      if (response.statusCode == 200) {
        final data = response.data['content'];
        if (data.isNotEmpty) {
          ToiletList toiletList = data.map<ToiletModel>((json) {
            return ToiletModel.fromJson(json);
          }).toList();
          return toiletList;
        } else {
          return [];
        }
      }
      throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  Future<ToiletList> searchToilet(DynamicMap queryData) =>
      _searchToilet(queryData);
  Future<ToiletList> _searchToilet(DynamicMap queryData) async {
    try {
      final response = token == null
          ? await dio.get(
              searchToiletUrl,
              queryParameters: queryData,
            )
          : await dioWithToken(url: searchToiletUrl).get(
              searchToiletUrl,
              queryParameters: queryData,
            );
      if (response.statusCode == 200) {
        if (GlobalProvider().totalPages == null) {
          GlobalProvider().setTotal(response.data['totalPages']);
        }
        final data = response.data['content'];
        ToiletList toiletList = data.map<ToiletModel>((json) {
          return ToiletModel.fromJson(json);
        }).toList();
        return toiletList;
      }
      throw Error();

      // throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }
}