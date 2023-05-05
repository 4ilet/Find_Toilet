import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/scroll_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* 폴더 내 즐겨찾기 목록
class BookMarkList extends StatelessWidget {
  final String folderName;
  final int bookmarkCnt, folderId;

  const BookMarkList({
    super.key,
    required this.folderName,
    required this.bookmarkCnt,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: ToiletScrollView(
        folderId: folderId,
        toolbarHeight: 10,
        expandedHeight: 60,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconButton(
                onPressed: routerPop(context),
                icon: exitIcon,
                color: CustomColors.whiteColor,
                iconSize: 35,
              ),
              CustomText(
                title: '$folderName${onRefresh(context)}',
                fontSize: FontSize.titleSize,
                color: CustomColors.whiteColor,
              ),
              const SizedBox(
                width: 20,
              ),
              CustomText(
                title: '$bookmarkCnt',
                fontSize: FontSize.defaultSize,
                color: CustomColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
