import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* 폴더 내 즐겨찾기 목록
class BookMarkList extends StatefulWidget {
  final String folderName;
  final int bookmarkCnt, folderId;

  const BookMarkList({
    super.key,
    required this.folderName,
    required this.bookmarkCnt,
    required this.folderId,
  });

  @override
  State<BookMarkList> createState() => _BookMarkListState();
}

class _BookMarkListState extends State<BookMarkList> {
  final controller = ScrollController();
  double appBarHeight = 0;
  bool refreshState = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.addListener(
          () {
            if (controller.position.pixels >=
                controller.position.maxScrollExtent * 0.9) {
              print('${getPage(context)}, ${getTotal(context)}');
              if (getPage(context) < getTotal(context)!) {
                if (!getWorking(context)) {
                  setWorking(context, true);
                  Future.delayed(const Duration(seconds: 3), () {
                    if (!getAdditional(context)) {
                      setAdditional(context, true);
                      moreData();
                    }
                  });
                }
              }
            }
          },
        );
      },
    );
  }

  void initData() {
    if (readLoading(context)) {
      getBookmarkList(
        context,
        folderId: widget.folderId,
      ).then((_) {
        setLoading(context, false);
      });
      increasePage(context);
    }
  }

  void moreData() {
    if (getAdditional(context)) {
      print('요청!!!!!!!!!!!!!!!!!!!!!!');
      getBookmarkList(
        context,
        folderId: widget.folderId,
      ).then((_) {
        setWorking(context, false);
        setAdditional(context, false);
      });
      increasePage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (refreshState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          initLoadingData(context);
          initBookmarkList(context);
          initData();
          setState(() {
            refreshState = false;
          });
        },
      );
    }
    return Scaffold(
      backgroundColor: mainColor,
      body: CustomBoxWithScrollView(
        listScroll: controller,
        toolbarHeight: 100,
        expandedHeight: isDefaultTheme(context)
            ? widget.folderName.length > 7
                ? 110
                : 60
            : widget.folderName.length > 6
                ? 120
                : 70,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        flexibleSpace: Padding(
          padding:
              EdgeInsets.fromLTRB(20, statusBarHeight(context) + 15, 20, 0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: CustomIconButton(
                  icon: exitIcon,
                  color: CustomColors.whiteColor,
                  onPressed: routerPop(context),
                  iconSize: 45,
                  padding: EdgeInsets.zero,
                ),
              ),
              Flexible(
                flex: 5,
                child: CustomText(
                  title: widget.folderName,
                  fontSize: FontSize.titleSize,
                  color: CustomColors.whiteColor,
                  font: kimm,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Flexible(
                  child: CustomText(
                    title: '${widget.bookmarkCnt}',
                    fontSize: FontSize.defaultSize,
                    color: CustomColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        silverChild: [
          CustomSilverList(
            folderId: widget.folderId,
            showReview: false,
            isMain: false,
            isSearch: false,
            data: bookmarkList(context),
            refreshPage: () {
              setState(() {
                refreshState = true;
              });
            },
          )
        ],
      ),
    );
  }
}
