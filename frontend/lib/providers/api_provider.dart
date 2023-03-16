import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['baseUrl'];
final options = BaseOptions(
  baseUrl: baseUrl!,
  // headers: {
  //   'Authorization':
  //       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwdWJoYW4zNUBnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuuCmOybkOqyvSIsImlkIjoxMywiZXhwIjoxNjc5ODEzNDE1fQ.QxSbAXsGLnz4R1Tj-DTYFie9BmU_-dln2tYYs5DBa-O4soDRTQ5EGbA-yiBzRXteYNFy77PM1GUOZhy-CFaGlg',
  // },
);
final dio = Dio(options);

//* user
final userUrl = '$baseUrl/user';
final loginUrl = '$userUrl/login';
final changeNameUrl = '$userUrl/update/nickname/';
final userInfoUrl = '$userUrl/userinfo';

//* review
// final reviewUrl = '$baseUrl/review';
const reviewUrl = '/review';
String reviewListUrl({required int toiletId}) => '$reviewUrl/$toiletId';
String postReviewUrl({required int memberId, required int toiletId}) =>
    '$reviewUrl/post/$memberId/$toiletId';
String updateReviewUrl({required int reviewId}) =>
    '$reviewUrl/update/$reviewId';
String deleteReviewUrl({required int reviewId}) =>
    '$reviewUrl/delete/$reviewId';

//* bookmark

final bookmarkUrl = '$baseUrl/like';
String folderListUrl({required int memberId}) => '$bookmarkUrl/$memberId';
String createFolderUrl({required int memberId}) =>
    '$bookmarkUrl/create/folder/$memberId';
String updateFolderUrl({required int folderId}) =>
    '$bookmarkUrl/update/folder/$folderId';
String deleteFolderUrl({required int folderId}) =>
    '$bookmarkUrl/delete/$folderId';

String toiletListUrl({required int folderId}) =>
    '$bookmarkUrl/folder/toiletlist/$folderId';
String addToiletUrl({required int folderId, required int toiletId}) =>
    '$bookmarkUrl/add/folder/$folderId/$toiletId';
String deleteToiletUrl({required int folderId, required int toiletId}) =>
    '$bookmarkUrl/delete/$folderId/$toiletId';
