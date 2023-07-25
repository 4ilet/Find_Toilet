import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToiletBottomSheet extends StatefulWidget {
  final bool showReview;
  final ReturnVoid refreshPage;

  const ToiletBottomSheet({
    super.key,
    this.showReview = false,
    required this.refreshPage,
  });

  @override
  State<ToiletBottomSheet> createState() => _ToiletBottomSheetState();
}

class _ToiletBottomSheetState extends State<ToiletBottomSheet> {
  final controller = ScrollController();
  ToiletModel? toiletModel;
  int? toiletId;

  @override
  void initState() {
    super.initState();
    toiletModel = getToilet(context);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        toiletId = getToiletId(context);
        controller.addListener(
          () {
            if (controller.position.pixels >=
                controller.position.maxScrollExtent * 0.9) {
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

  void moreData() {
    if (getAdditional(context)) {
      initMainData(
        context,
        showReview: widget.showReview,
        needClear: false,
      ).then((data) {
        if (!widget.showReview) {
          setHeightListSize(context);
        }
        setAdditional(context, false);
        setWorking(context, false);
      });
      increasePage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.showReview ? 0.45 : 0.2,
      minChildSize: 0.2,
      maxChildSize: widget.showReview
          ? 0.9
          : isDefaultTheme(context)
              ? 0.8
              : 0.75,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomBoxWithScrollView(
          appBarScroll: scrollController,
          listScroll: controller,
          toolbarHeight: widget.showReview
              ? getItemHeight(context)! + (isDefaultTheme(context) ? 60 : 100)
              : isDefaultTheme(context)
                  ? 80
                  : 95,
          backgroundColor: Colors.white10,
          flexibleSpace: CustomBox(
            color: mainColor,
            radius: 30,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        widget.showReview
                            ? CustomIconButton(
                                color: CustomColors.whiteColor,
                                icon: exitIcon,
                                onPressed: () {
                                  routerPop(context)();

                                  context
                                      .read<MainSearchProvider>()
                                      .removeMarker();
                                  context
                                      .read<ReviewBookMarkProvider>()
                                      .initToiletInfo();
                                },
                                padding: EdgeInsets.zero,
                                iconSize: 35,
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CustomText(
                            title: widget.showReview ? '화장실 조회' : '주변 화장실',
                            fontSize: FontSize.largeSize,
                            color: CustomColors.whiteColor,
                            font: kimm,
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.showReview
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListItem(
                            showReview: true,
                            isMain: true,
                            refreshPage: () {
                              ToiletProvider()
                                  .getToilet(getToiletId(context)!)
                                  .then((data) {
                                setToilet(context, data);
                                widget.refreshPage();
                              });
                            },
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
              isMain: true,
              isSearch: false,
              toiletId: getToiletId(context),
              toiletName: getToilet(context)?.toiletName,
              showReview: widget.showReview,
              data: widget.showReview
                  ? reviewList(context)
                  : mainToiletList(context),
              refreshPage: widget.refreshPage,
            ),
          ],
        );
      },
    );
  }
}
