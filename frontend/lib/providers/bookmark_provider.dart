import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* folder CRUD
class FolderProvider extends ApiProvider {
  //* 폴더 목록
  Future<FolderList> getFolderList() async {
    try {
      final response = await dioWithToken(url: folderListUrl, method: 'GET')
          .get(folderListUrl);
      final data = response.data['data'];
      FolderList folderList = data.map<FolderModel>((json) {
        return FolderModel.fromJson(json);
      }).toList();
      return folderList;
    } catch (error) {
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
  //* private

  FutureToiletList getToiletList(int folderId, int page) =>
      _getToiletList(folderId, page);

  FutureVoid addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) =>
      _addOrDeleteToilet(
        addFolderIdList: addFolderIdList,
        delFolderIdList: delFolderIdList,
        toiletId: toiletId,
      );

  //* 즐겨찾기 목록 조회
  FutureToiletList _getToiletList(int folderId, int page) async {
    ToiletList toiletList = [];
    try {
      final response =
          await dioWithToken(url: bookmarkListUrl(folderId), method: 'GET')
              .get(bookmarkListUrl(folderId), queryParameters: {'page': page});
      final data = response.data['data'];
      if (data.isEmpty) {
        return [];
      }
      data.forEach((element) {
        toiletList.add(ToiletModel.fromJson(element));
      });
      ScrollProvider().setTotal(response.data['size']);
      return toiletList;
    } catch (error) {
      throw Error();
    }
  }

  //* 즐겨찾기에 추가/삭제
  FutureVoid _addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async =>
      createApi(
        addToiletUrl,
        data: {
          'addFolderIdList': addFolderIdList,
          'delFolderIdList': delFolderIdList,
          'toiletId': toiletId,
        },
      );
}
