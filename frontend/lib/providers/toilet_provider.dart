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
          : await dioWithToken(url: nearToiletUrl, method: 'GET').get(
              nearToiletUrl,
              queryParameters: queryData,
            );
      final data = response.data['content'];
      if (data.isNotEmpty) {
        ToiletList toiletList = data.map<ToiletModel>((json) {
          return ToiletModel.fromJson(json);
        }).toList();
        GlobalProvider().setTotal(response.data['totalPages']);
        return toiletList;
      } else {
        return [];
      }
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
          : await dioWithToken(url: searchToiletUrl, method: 'GET').get(
              searchToiletUrl,
              queryParameters: queryData,
            );
      final data = response.data['content'];
      ToiletList toiletList = data.map<ToiletModel>((json) {
        return ToiletModel.fromJson(json);
      }).toList();
      GlobalProvider().setTotal(response.data['totalPages']);
      return toiletList;
    } catch (error) {
      print(error);
      throw Error();
    }
  }
}
