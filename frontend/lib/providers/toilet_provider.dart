import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

class ToiletProvider extends ApiProvider {
  //* public
  FutureToiletList searchToilet(DynamicMap queryData) =>
      _searchToilet(queryData);

  FutureToiletList getNearToilet(DynamicMap queryData) =>
      _getNearToilet(queryData);

  Future<ToiletModel> getToilet(int toiletId) => _getToilet(toiletId);

  //* private
  FutureToiletList _getNearToilet(DynamicMap queryData) async {
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
        ScrollProvider().setTotal(response.data['totalPages']);
        return toiletList;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  Future<ToiletModel> _getToilet(int toiletId) async {
    try {
      final response = token == null
          ? await dio.get(eachToiletUrl(toiletId))
          : await dioWithToken(url: eachToiletUrl(toiletId), method: 'GET').get(
              eachToiletUrl(toiletId),
            );
      final data = response.data['content'];
      if (data.isNotEmpty) {
        ToiletModel toiletModel = ToiletModel.fromJson(data);
        return toiletModel;
      } else {
        throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  FutureToiletList _searchToilet(DynamicMap queryData) async {
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
      ScrollProvider().setTotal(response.data['totalPages']);
      return toiletList;
    } catch (error) {
      throw Error();
    }
  }
}
