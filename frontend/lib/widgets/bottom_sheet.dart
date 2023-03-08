import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/select_box.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletBottomSheet extends StatefulWidget {
  final bool isMain;
  final bool showReview;
  const ToiletBottomSheet(
      {super.key, required this.isMain, this.showReview = false});

  @override
  State<ToiletBottomSheet> createState() => _ToiletBottomSheet();
}

class _ToiletBottomSheet extends State<ToiletBottomSheet> {
  List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  bool showList = false;
  void changeShowState() {
    setState(() {
      if (!showList) {
        showList = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.showReview
          ? 0.6
          : widget.isMain
              ? 0.4
              : 0.08,
      minChildSize: 0.08,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 40,
              backgroundColor: Colors.white10,
              pinned: true,
              expandedHeight: widget.showReview ? 40 : 80,
              flexibleSpace: CustomBox(
                color: mainColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: widget.isMain ? '주변 화장실' : '검색 결과',
                                  fontSize: FontSize.largeSize,
                                  color: CustomColors.whiteColor,
                                ),
                                widget.isMain
                                    ? const SizedBox()
                                    : SelectBox(
                                        showList: showList,
                                        onTap: changeShowState,
                                        selectList: sortOrder,
                                        width: 120,
                                        height: 25,
                                      ),
                              ],
                            ),
                          ),
                          widget.showReview
                              ? const SizedBox()
                              : const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: CustomText(
                                    title: '필터를 적용한 결과입니다',
                                    fontSize: FontSize.smallSize,
                                    color: CustomColors.whiteColor,
                                    font: notoSans,
                                  ),
                                ),
                        ],
                      ),
                      showList
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomBox(
                                    width: 120,
                                    color: whiteColor,
                                    boxShadow: const [defaultShadow],
                                    child: Column(
                                      children: [
                                        for (String select in sortOrder)
                                          CustomText(
                                            title: select,
                                            font: notoSans,
                                            fontSize: FontSize.smallSize,
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.showReview ? 1 : 10,
                (BuildContext context, int index) {
                  return CustomBox(
                    radius: 0,
                    color: mainColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListItem(showReview: widget.showReview),
                          for (int i = 0; i < 10; i += 1)
                            widget.showReview
                                ? const ReviewBox(
                                    nickname: '아아',
                                    score: 4.0,
                                    content: '아주 좋아요')
                                : const SizedBox()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
