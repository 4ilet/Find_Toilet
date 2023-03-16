import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* review CRUD
class ReviewProvider {
  //* 리뷰 목록
  static Future<ReviewList> getReviewList({required int toiletId}) async {
    ReviewList reviewList = [];
    try {
      final response = await dio.get(reviewListUrl(toiletId: toiletId));
      if (response.statusCode == 200) {
        response.data.forEach((review) {
          reviewList.add(ReviewModel.fromJson(review));
        });
        // print(reviewList);
        return reviewList;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  //* 리뷰 생성
  static Future<bool> postNewReview({
    required int memberId,
    required int toiletId,
    required DynamicMap reviewData,
  }) async {
    try {
      final response = await dio.post(
        postReviewUrl(memberId: memberId, toiletId: toiletId),
        data: reviewData,
      );
      if (response.statusCode == 200) {
        return true;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  //* 리뷰 수정
  static Future<bool> updateReview({
    required int reviewId,
    required DynamicMap reviewData,
  }) async {
    try {
      final response = await dio.put(
        updateReviewUrl(reviewId: reviewId),
        data: reviewData,
      );
      if (response.statusCode == 200) {
        return true;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  //* 리뷰 삭제
  static Future<bool> deleteReview({required int reviewId}) async {
    try {
      final response = await dio.delete(deleteReviewUrl(reviewId: reviewId));
      if (response.statusCode == 200) {
        return true;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }
}
