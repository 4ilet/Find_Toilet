import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* review CRUD
class ReviewProvider {
  //* 리뷰 목록
  static FutureList getReviewList({required int toiletId}) async {
    ReviewList reviewList = [];
    return ApiProvider.getApi(
      list: reviewList,
      url: reviewListUrl(toiletId: toiletId),
      model: ReviewModel,
    );
    // try {
    //   final response = await dio.get(reviewListUrl(toiletId: toiletId));
    //   if (response.statusCode == 200) {
    //     response.data.forEach((review) {
    //       reviewList.add(ReviewModel.fromJson(review));
    //     });
    //     return reviewList;
    //   }
    //   throw Error();
    // } catch (error) {
    //   throw Error();
    // }
  }

  //* 리뷰 생성
  static FutureVoid postNewReview({
    required int memberId,
    required int toiletId,
    required DynamicMap reviewData,
  }) async {
    ApiProvider.createApi(
      url: postReviewUrl(
        memberId: memberId,
        toiletId: toiletId,
      ),
      data: reviewData,
    );
  }

  //* 리뷰 수정
  static FutureVoid updateReview({
    required int reviewId,
    required DynamicMap reviewData,
  }) async {
    ApiProvider.updateApi(
        url: updateReviewUrl(
          reviewId: reviewId,
        ),
        data: reviewData);
  }

  //* 리뷰 삭제
  static FutureVoid deleteReview({required int reviewId}) async {
    ApiProvider.deleteApi(url: deleteReviewUrl(reviewId: reviewId));
  }
}
