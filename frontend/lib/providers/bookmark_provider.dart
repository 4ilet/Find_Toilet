import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/api_provider.dart';
import 'package:find_toilet/utilities/type_enum.dart';

//* folder CRUD
class FolderProvider with ApiProvider {
  //* 폴더 목록
  static FutureList getFolderList({required int memberId}) async {
    FolderList folderList = [];
    return ApiProvider.getApi(
      list: folderList,
      url: folderListUrl(memberId: memberId),
      model: FolderModel,
    );
    // try {
    //   final response = await dio.get(folderListUrl(memberId: memberId));
    //   if (response.statusCode == 200) {
    //     response.data.forEach((folder) {
    //       folderList.add(FolderModel.fromJson(folder));
    //     });
    //     return folderList;
    //   }
    //   throw Error();
    // } catch (error) {
    //   throw Error();
    // }
  }

  //* 폴더 생성
  static FutureVoid createNewFolder({
    required int memberId,
    required StringMap folderData,
  }) async {
    ApiProvider.createApi(
      url: createFolderUrl(memberId: memberId),
      data: folderData,
    );
  }

  //* 폴더 수정
  static FutureVoid updateFolderName({
    required int folderId,
    required StringMap folderData,
  }) async {
    ApiProvider.updateApi(
      url: updateFolderUrl(folderId: folderId),
      data: folderData,
    );
  }

  //* 리뷰 삭제
  static FutureVoid deleteFolder({required int folderId}) async {
    ApiProvider.deleteApi(url: deleteFolderUrl(folderId: folderId));
  }
}

class BookMarkProvider {
  //* 즐겨찾기 목록 조회
  static FutureList getToiletList({required int folderId}) async {
    ToiletList toiletList = [];
    return ApiProvider.getApi(
      list: toiletList,
      url: bookmarkListUrl(
        folderId: folderId,
      ),
      model: ToiletModel,
    );
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
