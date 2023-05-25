import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* review CRUD
class ReviewProvider extends ApiProvider {
  //* 리뷰 목록
  Future<ReviewList> getReviewList(int toiletId, int page) async {
    ReviewList reviewList = [];
    try {
      final response = token != null
          ? await dio.get(
              reviewListUrl(toiletId),
              queryParameters: {'page': page},
            )
          : await dioWithToken(url: reviewListUrl(toiletId), method: 'GET').get(
              reviewListUrl(toiletId),
              queryParameters: {'page': page},
            );
      print('res: $response');
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          print('data: $data');
          data.forEach((review) {
            reviewList.add(ReviewModel.fromJson(review));
          });
          return reviewList;
        case 204:
          return [];
        default:
          throw Error();
      }
    } catch (error) {
      print('error: $error');
      throw Error();
    }
  }

  //* 리뷰 조회
  Future<ReviewModel> getReview(int reviewId) async {
    try {
      final response =
          await dioWithToken(url: reviewUrl(reviewId), method: 'GET')
              .get(reviewUrl(reviewId));
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return ReviewModel.fromJson(data);
      }

      throw Error();
    } catch (error) {
      print(error);
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
  FutureVoid updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) async =>
      updateApi(updateReviewUrl(reviewId), data: reviewData);

  //* 리뷰 삭제
  FutureBool deleteReview(int reviewId) async =>
      deleteApi(deleteReviewUrl(reviewId));
}
