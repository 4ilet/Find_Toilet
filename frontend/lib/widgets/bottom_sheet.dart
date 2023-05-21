import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletBottomSheet extends StatelessWidget {
  final bool showReview;
  final ToiletModel? toiletModel;
  const ToiletBottomSheet({
    super.key,
    this.showReview = false,
    this.toiletModel,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: showReview ? 0.6 : 0.4,
      minChildSize: 0.08,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomBoxWithScrollView(
          scrollController: scrollController,
          toolbarHeight: 100,
          expandedHeight: showReview ? 40 : 100,
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
                      children: const [
                        CustomText(
                          title: '주변 화장실',
                          fontSize: FontSize.largeSize,
                          color: CustomColors.whiteColor,
                          font: kimm,
                        ),
                      ],
                    ),
                  ),
                  showReview
                      ? ListItem(
                          data: toiletModel!,
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
              showReview: showReview,
              isMain: true,
            ),
          ],
        );
      },
    );
  }
}
