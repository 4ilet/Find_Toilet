import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* folder CRUD
class FolderProvider extends ApiProvider {
  //* 폴더 목록
  Future<FolderList> getFolderList() async {
    try {
      //*
      final response = await dioWithToken().get(folderListUrl);
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          print(data);
          FolderList folderList = data.map<FolderModel>((json) {
            return FolderModel.fromJson(json);
          }).toList();
          return folderList;
        case 401:
          await refreshToken(
            url: folderListUrl,
            method: 'GET',
          );
          return getFolderList();
        default:
          throw Error();
      }

      // throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  //* 폴더 생성
  FutureBool createNewFolder(StringMap folderData) async =>
      await createApi(createFolderUrl, data: folderData);

  //* 폴더 수정
  FutureVoid updateFolderName(int folderId,
          {required StringMap folderData}) async =>
      updateApi(updateFolderUrl(folderId), data: folderData);

  //* 폴더 삭제
  FutureBool deleteFolder(int folderId) async =>
      deleteApi(deleteFolderUrl(folderId));
}

class BookMarkProvider extends ApiProvider {
  //* 즐겨찾기 목록 조회
  Future<ToiletList> getToiletList(int folderId) async {
    ToiletList toiletList = [];
    try {
      final response = await dioWithToken().get(bookmarkListUrl(folderId));
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          if (data.isEmpty) {
            print('empty');
            return [];
          }
          print(data);
          data.forEach((element) {
            toiletList.add(ToiletModel.fromJson(element));
          });
          return toiletList;
        case 401:
          await refreshToken(
            url: folderListUrl,
            method: 'GET',
          );
          return getToiletList(folderId);
        // break;
        default:
          throw Error();
      }
      // throw Error();
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  //* 즐겨찾기에 추가
  FutureVoid addToilet({
    required int folderId,
    required int toiletId,
  }) async {
    createApi(
      addToiletUrl(
        folderId: folderId,
        toiletId: toiletId,
      ),
      data: {},
    );
  }

  //* 즐겨찾기 삭제
  FutureBool deleteBookMark({
    required int folderId,
    required int toiletId,
  }) async =>
      deleteApi(deleteToiletUrl(
        folderId: folderId,
        toiletId: toiletId,
      ));
}
