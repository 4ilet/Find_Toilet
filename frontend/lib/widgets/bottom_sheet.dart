import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletBottomSheet extends StatefulWidget {
  final bool showReview;
  final ToiletModel? toiletModel;
  final Future<ToiletList> future;
  const ToiletBottomSheet({
    super.key,
    this.showReview = false,
    this.toiletModel,
    required this.future,
  });

  @override
  State<ToiletBottomSheet> createState() => _ToiletBottomSheet();
}

class _ToiletBottomSheet extends State<ToiletBottomSheet> {
  // List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  // late String selectedValue;
  // bool showList = false;
  ToiletList toiletList = [];
  int page = 0;
  bool finished = false;

  void addToiletList() {
    if (page != 0) {
    } else {
      // toiletList = await future;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.showReview ? 0.6 : 0.4,
      minChildSize: 0.08,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        scrollController.addListener(() {
          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.9) {
            print(scrollController.position.userScrollDirection);
          }
        });
        return CustomBox(
          color: mainColor,
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
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
                      ],
                    ),
                  ),
                ),
              ),
              //*
              widget.showReview
                  ? reviewSilverList()
                  : CustomSilverFutureList(
                      future: widget.future,
                      showReview: false,
                    ),
            ],
          ),
        );
      },
    );
  }

//* silver list
  SliverList reviewSilverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (BuildContext context, int index) {
          return CustomBox(
            radius: 0,
            color: mainColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListItem(
                    data: widget.toiletModel!,
                    showReview: true,
                  ),
                  FutureBuilder(
                    future: ReviewProvider()
                        .getReviewList(widget.toiletModel!.toiletId, 0),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomBox(
                          color: mainColor,
                          child: snapshot.data!.isNotEmpty
                              ? CustomListView(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, i) => ReviewBox(
                                    review: snapshot.data![i],
                                    toiletId: widget.toiletModel!.toiletId,
                                    toiletName: widget.toiletModel!.toiletName,
                                  ),
                                )

                              // reviewListView(snapshot.data!, index)
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
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //* app bar 맨 윗 부분
  Padding topOfAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: const [
          CustomText(
            title: '주변 화장실',
            fontSize: FontSize.largeSize,
            color: CustomColors.whiteColor,
            font: kimm,
          ),
        ],
      ),
    );
  }
}
