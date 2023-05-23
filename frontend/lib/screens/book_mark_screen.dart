import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/silvers.dart';
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
    final controller = ScrollController();
    void addScrollListener(ReturnVoid voidFunc) =>
        controller.addListener(voidFunc);

    return Scaffold(
      backgroundColor: mainColor,
      body: CustomBoxWithScrollView(
        scrollController: controller,
        toolbarHeight: 130,
        expandedHeight: 130,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: CustomIconButton(
                  onPressed: routerPop(context),
                  icon: exitIcon,
                  color: CustomColors.whiteColor,
                  iconSize: 35,
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.loose,
                child: CustomText(
                  title: '$folderName${onRefresh(context)}',
                  fontSize: FontSize.titleSize,
                  color: CustomColors.whiteColor,
                ),
              ),
              Flexible(
                child: CustomText(
                  title: '$bookmarkCnt',
                  fontSize: FontSize.defaultSize,
                  color: CustomColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        silverChild: [
          CustomSilverList(
            folderId: folderId,
            showReview: false,
            isMain: false,
            controller: controller,
            addScrollListener: addScrollListener,
          )
        ],
      ),
    );
  }
}
