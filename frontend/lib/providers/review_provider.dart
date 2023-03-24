import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* review CRUD
class ReviewProvider {
  //* 리뷰 목록
  static Future<ReviewList> getReviewList(int toiletId) async {
    ReviewList reviewList = [];
    try {
      final response = await dio.get(reviewListUrl(toiletId));
      if (response.statusCode == 200) {
        response.data.forEach((review) {
          reviewList.add(ReviewModel.fromJson(review));
        });
        return reviewList;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  //* 리뷰 생성
  static FutureVoid postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) async {
    ApiProvider.createApi(
      postReviewUrl(toiletId),
      data: reviewData,
    );
  }

  //* 리뷰 수정
  static FutureVoid updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) async {
    ApiProvider.updateApi(updateReviewUrl(reviewId), data: reviewData);
  }

  //* 리뷰 삭제
  static FutureVoid deleteReview(int reviewId) async {
    ApiProvider.deleteApi(deleteReviewUrl(reviewId));
  }
}
