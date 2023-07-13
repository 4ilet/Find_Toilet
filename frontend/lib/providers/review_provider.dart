import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* review CRUD
class ReviewProvider extends ApiProvider {
  //* 리뷰 목록
  Future<ReviewList> getReviewList(int toiletId, int page) async {
    ReviewList reviewList = [];
    try {
      final response = token == null
          ? await dio.get(
              reviewListUrl(toiletId),
              queryParameters: {'page': page},
            )
          : await dioWithToken(url: reviewListUrl(toiletId), method: 'GET').get(
              reviewListUrl(toiletId),
              queryParameters: {'page': page},
            );
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          data.forEach((review) {
            reviewList.add(ReviewModel.fromJson(review));
          });
          ScrollProvider().setTotal(response.data['size']);
          return reviewList;
        case 204:
          ScrollProvider().setTotal(0);
          return [];
        default:
          throw Error();
      }
    } catch (error) {
      throw Error();
    }
  }

  //* 리뷰 조회
  Future<ReviewModel> getReview(int reviewId) async {
    try {
      final response =
          await dioWithToken(url: reviewUrl(reviewId), method: 'GET')
              .get(reviewUrl(reviewId));
      final data = response.data['data'];
      return ReviewModel.fromJson(data);
    } catch (error) {
      throw Error();
    }
  }

  //* 리뷰 생성
  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) async =>
      createApi(
        postReviewUrl(toiletId),
        data: reviewData,
      );

  //* 리뷰 수정
  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) async =>
      updateApi(updateReviewUrl(reviewId), data: reviewData);

  //* 리뷰 삭제
  FutureBool deleteReview(int reviewId) async =>
      deleteApi(deleteReviewUrl(reviewId));
}
