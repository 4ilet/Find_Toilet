import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* app bar
class CustomSilverAppBar extends StatelessWidget {
  final double toolbarHeight, expandedHeight;
  final double? elevation;
  final Widget flexibleSpace;
  final Color backgroundColor;

  const CustomSilverAppBar({
    super.key,
    required this.toolbarHeight,
    required this.expandedHeight,
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
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      elevation: elevation,
    );
  }
}

//* silver list (화장실 목록 출력)
class CustomSilverList extends StatefulWidget {
  final bool showReview;
  final bool isMain;
  final int? toiletId, folderId;
  final String? toiletName;
  const CustomSilverList({
    super.key,
    required this.showReview,
    required this.isMain,
    this.toiletId,
    this.folderId,
    this.toiletName,
  });

  @override
  State<CustomSilverList> createState() => _CustomSilverListState();
}

class _CustomSilverListState extends State<CustomSilverList> {
  bool additional = false;
  bool working = false;
  List data = [];
  int page = 0;
  int cnt = 20;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initData();
    addScrollListener();
  }

  void initData() async {
    if (readLoading(context)) {
      if (widget.showReview == true) {
        data = await ReviewProvider().getReviewList(widget.toiletId!, page);
      } else if (widget.isMain == true) {
        ToiletProvider()
            .getNearToilet(mainToiletData(context))
            .then((toiletData) {
          setState(() {
            data = toiletData;
          });
          setLoading(context, false);
          addToiletList(
            context,
            toiletData,
          );
        });
      } else {
        BookMarkProvider().getToiletList(widget.folderId!).then((toiletData) {
          setState(() {
            data = toiletData;
            setLoading(context, false);
          });
        });
      }
      page += 1;
    }
  }

  void addScrollListener() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        if (page < getTotal(context)!) {
          if (!working) {
            setState(() {
              working = true;
            });
            Future.delayed(const Duration(milliseconds: 2000), () {
              if (!additional) {
                setState(() {
                  additional = true;
                });
                moreData();
              }
            });
          }
        }
      }
    });
  }

  void moreData() {
    if (additional) {
      if (widget.showReview) {
        ReviewProvider()
            .getReviewList(widget.toiletId!, page)
            .then((reviewData) {
          data.addAll(reviewData);
        });
      } else if (widget.isMain) {
        ToiletProvider()
            .getNearToilet(mainToiletData(context))
            .then((toiletData) {
          data.addAll(toiletData);
          addToiletList(
            context,
            toiletData,
          );
        });
      }
      setState(() {
        additional = false;
        working = false;
      });
      page += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      color: mainColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: !getLoading(context)
            ? data.isNotEmpty
                ? CustomListView(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      final returnedWidget = widget.showReview
                          ? ReviewBox(
                              review: data[i],
                              toiletId: widget.toiletId!,
                              toiletName: widget.toiletName!,
                            )
                          : ListItem(
                              showReview: false,
                              data: data[i],
                            );

                      return Column(
                        children: [
                          i < page * cnt || !additional
                              ? returnedWidget
                              : const SizedBox(),
                          i == data.length - 1 && getTotal(context)! > page
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
                : Center(
                    child: CustomText(
                      title:
                          '${widget.showReview ? '이 화장실에 대한 리뷰가' : widget.isMain ? '주변에 화장실이' : '즐겨찾기한 화장실이'} 없습니다',
                      color: CustomColors.whiteColor,
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class CustomBoxWithScrollView extends StatelessWidget {
  final ScrollController? scrollController;
  final Widget flexibleSpace;
  final double toolbarHeight, expandedHeight;
  final Color backgroundColor;
  final WidgetList? silverChild;
  // final SliverChildDelegate? sliverChildDelegate;
  // final ScrollPhysics physics;

  const CustomBoxWithScrollView({
    super.key,
    this.scrollController,
    required this.flexibleSpace,
    this.toolbarHeight = 200,
    this.expandedHeight = 100,
    this.backgroundColor = mainColor,
    this.silverChild,
    // this.sliverChildDelegate,
    // this.physics = const AlwaysScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      radius: 0,
      color: mainColor,
      child: Column(
        children: [
          SizedBox(
            height: expandedHeight,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                CustomSilverAppBar(
                  elevation: 0,
                  toolbarHeight: toolbarHeight,
                  expandedHeight: expandedHeight,
                  flexibleSpace: flexibleSpace,
                  backgroundColor: backgroundColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              // physics: physics,
              slivers: [
                SliverList(
                  delegate:
                      // sliverChildDelegate != null
                      //     ? sliverChildDelegate! :
                      SliverChildListDelegate(silverChild!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
