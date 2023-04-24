import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/select_box.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletBottomSheet extends StatefulWidget {
  final bool isMain;
  final bool showReview;
  final ToiletModel? toiletModel;
  const ToiletBottomSheet({
    super.key,
    required this.isMain,
    this.showReview = false,
    this.toiletModel,
  });

  @override
  State<ToiletBottomSheet> createState() => _ToiletBottomSheet();
}

class _ToiletBottomSheet extends State<ToiletBottomSheet> {
  List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  late String selectedValue;
  bool showList = false;

  void changeShowState() {
    setState(() {
      if (!showList) {
        showList = true;
      } else {
        showList = false;
      }
    });
  }

  void changeSelected(String value) {
    setState(() {
      selectedValue = value;
      changeShowState();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedValue = sortOrder.first;
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
            CustomSilverAppBar(
              toolbarHeight: 80,
              backgroundColor: Colors.white10,
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
                          topOfAppBar(),
                          widget.showReview
                              ? const SizedBox()
                              : const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    // vertical: 5,
                                  ),
                                  child: CustomText(
                                    title: '필터를 적용한 결과입니다',
                                    fontSize: FontSize.smallSize,
                                    color: CustomColors.whiteColor,
                                  ),
                                ),
                        ],
                      ),
                      showList ? sortList() : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
            widget.showReview
                ? ListItem(
                    data: widget.toiletModel!,
                    showReview: true,
                    isMain: widget.isMain,
                  )
                : CustomSilverFutureList(
                    future: widget.isMain
                        ? ToiletProvider().getNearToilet()
                        : ToiletProvider().searchToilet(),
                    showReview: false,
                    itemCount: 0,
                  ),
            // silverList(),
          ],
        );
      },
    );
  }

//* silver list
  SliverList silverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomBox(
            radius: 0,
            color: mainColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListItem(
                    data: const [],
                    showReview: widget.showReview,
                    isMain: widget.isMain,
                  ),
                  widget.showReview
                      ? FutureBuilder(
                          future: ReviewProvider().getReviewList(index),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomBox(
                                color: mainColor,
                                child: snapshot.data!.isNotEmpty
                                    ? reviewListView(snapshot.data!, index)
                                    : const Center(
                                        child: Center(
                                          child: CustomText(
                                            title: '이 화장실에 대한 리뷰가 없습니다',
                                            color: CustomColors.whiteColor,
                                          ),
                                        ),
                                      ),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })
                      : const SizedBox(),
                  // widget.showReview
                  //     ? FutureBuilder(
                  //         future: reviewList,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             return Column(
                  //               children: const [
                  //                 Expanded(
                  //                   child: ReviewBox(
                  //                     nickname: '아아',
                  //                     score: 4.0,
                  //                     content: '아주 좋아요',
                  //                   ),
                  //                 )
                  //               ],
                  //             );
                  //           }
                  //           return const Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         },
                  //       )
                  //     : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ListView reviewListView(ReviewList data, int toiletId) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ReviewBox(
            review: data[index],
            toiletId: toiletId,
            toiletName: widget.toiletModel!.toiletName,
          );
        });
  }

  //* app bar 맨 윗 부분
  Padding topOfAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: widget.isMain ? '주변 화장실' : '검색 결과',
            fontSize: FontSize.largeSize,
            color: CustomColors.whiteColor,
            font: kimm,
          ),
          widget.isMain
              ? const SizedBox()
              : SelectBox(
                  showList: showList,
                  onTap: changeShowState,
                  width: 120,
                  height: 25,
                  value: selectedValue,
                ),
        ],
      ),
    );
  }

  //* 선택 상자 눌렀을 때 나오는 목록
  Padding sortList() {
    return Padding(
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
                  CustomBox(
                    onTap: () => changeSelected(select),
                    width: 120,
                    child: Center(
                      child: CustomText(
                        title: select,
                        fontSize: FontSize.smallSize,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
