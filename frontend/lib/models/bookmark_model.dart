import 'package:find_toilet/utilities/type_enum.dart';

class FolderModel {
  final int folderId, bookmarkCnt;
  final String folderName;
  FolderModel.fromJson(DynamicMap json)
      : folderId = json['folderId'],
        bookmarkCnt = json['folderLen'],
        folderName = json['folderName'];
}
