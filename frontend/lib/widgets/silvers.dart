import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* app bar
class CustomSilverAppBar extends StatelessWidget {
  final double toolbarHeight;
  final double? elevation;
  final Widget flexibleSpace;
  final Color backgroundColor;

  const CustomSilverAppBar({
    super.key,
    required this.toolbarHeight,
    required this.flexibleSpace,
    required this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor,
      pinned: true,
      flexibleSpace: flexibleSpace,
      elevation: elevation,
    );
  }
}

//* silver list (화장실 목록 출력)
class CustomSilverList extends StatelessWidget {
  final bool showReview, isMain, isSearch;
  final int? toiletId, folderId;
  final String? toiletName;
  final List data;
  final ReturnVoid refreshPage;
  const CustomSilverList({
    super.key,
    required this.showReview,
    required this.isMain,
    required this.isSearch,
    this.toiletId,
    this.folderId,
    this.toiletName,
    required this.data,
    required this.refreshPage,
  });

  @override
  Widget build(BuildContext context) {
    int cnt = showReview || (!isMain && !isSearch) ? 10 : 20;
    String ifEmpty() {
      String showedContent = '';
      if (isSearch) {
        showedContent = '조건에 맞는 화장실이';
      } else if (showReview) {
        showedContent = '이 화장실에 대한 리뷰가';
      } else if (isMain) {
        showedContent = '주변에 화장실이';
      } else {
        showedContent = '즐겨찾기한 화장실이';
      }
      return '$showedContent 없습니다.';
    }

    return CustomBox(
      color: mainColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: !getLoading(context)
            ? data.isNotEmpty
                ? CustomListView(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      final returnedWidget = showReview
                          ? ReviewBox(
                              review: data[i],
                              toiletId: toiletId!,
                              toiletName: toiletName!,
                              refreshPage: refreshPage,
                            )
                          : ListItem(
                              showReview: false,
                              toiletModel: data[i],
                              isMain: isMain,
                              refreshPage: refreshPage,
                              index: i,
                            );

                      return Column(
                        children: [
                          i < getPage(context) * cnt
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: returnedWidget,
                                )
                              : const SizedBox(),
                          i == data.length - 1 &&
                                  getTotal(context)! > getPage(context)
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 40,
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: CustomText(
                        title: ifEmpty(),
                        color: CustomColors.whiteColor,
                      ),
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class CustomBoxWithScrollView extends StatefulWidget {
  final ScrollController? appBarScroll, listScroll;
  final Widget flexibleSpace;
  final double toolbarHeight;
  final Color backgroundColor;
  final WidgetList? silverChild;

  const CustomBoxWithScrollView({
    super.key,
    this.appBarScroll,
    this.listScroll,
    required this.flexibleSpace,
    this.toolbarHeight = 200,
    this.backgroundColor = mainColor,
    this.silverChild,
  });

  @override
  State<CustomBoxWithScrollView> createState() =>
      _CustomBoxWithScrollViewState();
}

class _CustomBoxWithScrollViewState extends State<CustomBoxWithScrollView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      radius: 0,
      color: mainColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: widget.toolbarHeight,
            child: CustomScrollView(
              controller: widget.appBarScroll,
              slivers: [
                CustomSilverAppBar(
                  elevation: 0,
                  toolbarHeight: widget.toolbarHeight,
                  flexibleSpace: widget.flexibleSpace,
                  backgroundColor: widget.backgroundColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.listScroll,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(widget.silverChild!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
