import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* folder CRUD
class FolderProvider with ApiProvider {
  //* 폴더 목록
  static Future<FolderList> getFolderList(int memberId) async {
    FolderList folderList = [];
    try {
      final response = await dio.get(folderListUrl(memberId));
      if (response.statusCode == 200) {
        final data = response.data['data'];
        for (var folder in data) {
          folderList.add(FolderModel.fromJson(folder));
        }
        return folderList;
      }
      throw Error();
    } catch (error) {
      throw Error();
    }
  }

  //* 폴더 생성
  static FutureVoid createNewFolder(
    int memberId, {
    required StringMap folderData,
  }) async {
    ApiProvider.createApi(
      url: createFolderUrl(memberId),
      data: folderData,
    );
  }

  //* 폴더 수정
  static FutureVoid updateFolderName(
    int folderId, {
    required StringMap folderData,
  }) async {
    ApiProvider.updateApi(
      url: updateFolderUrl(folderId),
      data: folderData,
    );
  }

  //* 리뷰 삭제
  static FutureVoid deleteFolder(int folderId) async {
    ApiProvider.deleteApi(url: deleteFolderUrl(folderId));
  }
}

class BookMarkProvider {
  //* 즐겨찾기 목록 조회
  static FutureList getToiletList(int folderId) async {
    ToiletList toiletList = [];
    try {
      final response = await dio.get(bookmarkListUrl(folderId));
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
      url: addToiletUrl(
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
    ApiProvider.createApi(
      url: addToiletUrl(
        folderId: folderId,
        toiletId: toiletId,
      ),
      data: {},
    );
  }
}
