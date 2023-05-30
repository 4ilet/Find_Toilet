import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletBottomSheet extends StatefulWidget {
  final bool showReview;
  final ToiletModel? toiletModel;
  const ToiletBottomSheet({
    super.key,
    this.showReview = false,
    this.toiletModel,
  });

  @override
  State<ToiletBottomSheet> createState() => _ToiletBottomSheetState();
}

class _ToiletBottomSheetState extends State<ToiletBottomSheet> {
  final controller = ScrollController();
  // bool additional = false;
  // bool working = false;
  List data = [];
  // int page = 0;
  // int cnt = 20;
  int? toiletId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        initLoadingData(context);
        initData();
        toiletId = widget.toiletModel?.toiletId;
        controller.addListener(
          () {
            if (controller.position.pixels >=
                controller.position.maxScrollExtent * 0.9) {
              print('${getPage(context)}, ${getTotal(context)}');
              if (getPage(context) < getTotal(context)!) {
                if (!getWorking(context)) {
                  setWorking(context, true);
                  Future.delayed(const Duration(milliseconds: 2000), () {
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

  void initData() async {
    if (readLoading(context)) {
      if (widget.showReview) {
        ReviewProvider()
            .getReviewList(widget.toiletModel!.toiletId, getPage(context))
            .then((toiletData) {
          setState(() {
            data.addAll(toiletData);
          });
          setLoading(context, false);
        });
      } else {
        ToiletProvider()
            .getNearToilet(mainToiletData(context))
            .then((toiletData) {
          setState(() {
            data.addAll(toiletData);
          });
          setLoading(context, false);
          addToiletList(
            context,
            toiletData,
          );
        });
      }
      increasePage(context);
    }
  }

  void moreData() {
    if (getAdditional(context)) {
      if (widget.showReview) {
        ReviewProvider()
            .getReviewList(toiletId!, getPage(context))
            .then((reviewData) {
          setState(() {
            data.addAll(reviewData);
          });
        });
      } else {
        ToiletProvider()
            .getNearToilet(mainToiletData(context))
            .then((toiletData) {
          setState(() {
            data.addAll(toiletData);
          });
          addToiletList(
            context,
            toiletData,
          );
        });
      }
      setAdditional(context, false);
      setWorking(context, false);
      increasePage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.showReview ? 0.6 : 0.4,
      minChildSize: 0.08,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomBoxWithScrollView(
          appBarScroll: scrollController,
          listScroll: controller,
          toolbarHeight: widget.showReview ? 40 : 80,
          expandedHeight: widget.showReview
              ? screenHeight(context) * 0.44
              : screenHeight(context) * 0.15,
          backgroundColor: Colors.white10,
          flexibleSpace: CustomBox(
            color: mainColor,
            radius: 30,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          title: widget.showReview ? '화장실 조회' : '주변 화장실',
                          fontSize: FontSize.largeSize,
                          color: CustomColors.whiteColor,
                          font: kimm,
                        ),
                      ],
                    ),
                  ),
                  widget.showReview
                      ? ListItem(
                          data: widget.toiletModel!,
                          showReview: true,
                        )
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
            ),
          ),
          silverChild: [
            CustomSilverList(
              showReview: widget.showReview,
              isMain: true,
              isSearch: false,
              toiletId: widget.toiletModel?.toiletId,
              toiletName: widget.toiletModel?.toiletName,
              data: data,
              // addScrollListener: addScrollListener,
            ),
          ],
        );
      },
    );
  }
}
