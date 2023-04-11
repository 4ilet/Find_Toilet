import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* review CRUD
class ReviewProvider extends ApiProvider {
  //* url
  static const _reviewUrl = '/review';
  static String _reviewListUrl(int toiletId) => '$_reviewUrl/$toiletId';
  static String _postReviewUrl(int toiletId) => '$_reviewUrl/post/$toiletId';
  static String _updateReviewUrl(int reviewId) =>
      '$_reviewUrl/update/$reviewId';
  static String _deleteReviewUrl(int reviewId) =>
      '$_reviewUrl/delete/$reviewId';

  //* 리뷰 목록
  Future<ReviewList> getReviewList(int toiletId) async {
    ReviewList reviewList = [];
    try {
      final response = await dioWithToken().get(_reviewListUrl(toiletId));
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
  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) async {
    return createApi(
      _postReviewUrl(toiletId),
      data: reviewData,
    );
  }

  //* 리뷰 수정
  FutureVoid updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) async {
    updateApi(_updateReviewUrl(reviewId), data: reviewData);
  }

  //* 리뷰 삭제
  FutureBool deleteReview(int reviewId) async =>
      deleteApi(_deleteReviewUrl(reviewId));
}
