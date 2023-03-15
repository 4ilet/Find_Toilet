import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

class ReviewProvider {
  static Future<ReviewList> getReviewList({required int toiletId}) async {
    ReviewList reviewList = [];
    final response = await dio.get(reviewListUrl(toiletId: toiletId));
    if (response.statusCode == 200) {
      response.data.forEach((review) {
        reviewList.add(ReviewModel.fromJson(review));
      });
      return reviewList;
    }
    throw Error();
  }
}
