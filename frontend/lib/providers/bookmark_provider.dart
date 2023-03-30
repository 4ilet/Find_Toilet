import 'package:dio/dio.dart';
import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* folder CRUD
class FolderProvider with ApiProvider {
  //* url
  static const _bookmarkUrl = '/like';
  static const _folderListUrl = '$_bookmarkUrl/folder';
  static const _createFolderUrl = '$_bookmarkUrl/create/folder';
  static String _updateFolderUrl(int folderId) =>
      '$_bookmarkUrl/update/folder/$folderId';
  static String _deleteFolderUrl(int folderId) =>
      '$_bookmarkUrl/delete/folder/$folderId';

  //* 폴더 목록
  static Future<FolderList> getFolderList() async {
    try {
      //* token
      final token = await UserProvider().token();
      final options =
          BaseOptions(baseUrl: baseUrl!, headers: {'Authorization': token});
      final dioWithToken = Dio(options);
      //*
      final response = await dioWithToken.get(_folderListUrl);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        FolderList folderList = data.map<FolderModel>((json) {
          return FolderModel.fromJson(json);
        }).toList();
        return folderList;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  //* 폴더 생성
  static FutureVoid createNewFolder(
    StringMap folderData,
  ) async {
    ApiProvider.createApi(
      _createFolderUrl,
      data: folderData,
    );
  }

  //* 폴더 수정
  static FutureVoid updateFolderName(
    int folderId, {
    required StringMap folderData,
  }) async {
    ApiProvider.updateApi(
      _updateFolderUrl(folderId),
      data: folderData,
    );
  }

  //* 리뷰 삭제
  static FutureVoid deleteFolder(int folderId) async {
    ApiProvider.deleteApi(_deleteFolderUrl(folderId));
  }
}

class BookMarkProvider {
  //* url
  static const _bookmarkUrl = '/like';
  static String _bookmarkListUrl(int folderId) =>
      '$_bookmarkUrl/folder/toiletlist/$folderId';
  static String _addToiletUrl({required int folderId, required int toiletId}) =>
      '$_bookmarkUrl/add/folder/$folderId/$toiletId';
  static String _deleteToiletUrl(
          {required int folderId, required int toiletId}) =>
      '$_bookmarkUrl/delete/$folderId/$toiletId';

  //* 즐겨찾기 목록 조회
  static FutureList getToiletList(int folderId) async {
    ToiletList toiletList = [];
    try {
      final response = await dio.get(_bookmarkListUrl(folderId));
      if (response.statusCode == 200) {
        response.data.forEach((element) {
          toiletList.add(ToiletModel.fromJson(element));
        });
        return toiletList;
      }
      throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  //* 즐겨찾기에 추가
  static FutureVoid addToilet({
    required int folderId,
    required int toiletId,
  }) async {
    ApiProvider.createApi(
      _addToiletUrl(
        folderId: folderId,
        toiletId: toiletId,
      ),
      data: {},
    );
  }

  //* 즐겨찾기 삭제
  static FutureVoid deleteBookMark({
    required int folderId,
    required int toiletId,
  }) async {
    ApiProvider.deleteApi(
      _deleteToiletUrl(
        folderId: folderId,
        toiletId: toiletId,
      ),
    );
  }
}
