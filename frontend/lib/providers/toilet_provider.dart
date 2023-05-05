import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

class ToiletProvider extends ApiProvider {
  Future<ToiletList> getNearToilet() async {
    try {
      final response = await dio.get(nearToiletUrl);
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          ToiletList toiletList = data.map<ToiletModel>((json) {
            return ToiletModel.fromJson(json);
          }).toList();
          return toiletList;
        case 401:
          await refreshToken(
            url: nearToiletUrl,
            method: 'GET',
          );
          return getNearToilet();
        default:
          throw Error();
      }

      // throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  Future<ToiletList> searchToilet() async {
    try {
      final response = await dioWithToken().get(searchToiletUrl);
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          ToiletList toiletList = data.map<ToiletModel>((json) {
            return ToiletModel.fromJson(json);
          }).toList();
          return toiletList;
        case 401:
          await refreshToken(
            url: searchToiletUrl,
            method: 'GET',
          );
          return searchToilet();
        default:
          throw Error();
      }

      // throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }
}
