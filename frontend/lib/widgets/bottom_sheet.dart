import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/select_box.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletBottomSheet extends StatefulWidget {
  final bool isMain;
  const ToiletBottomSheet({super.key, required this.isMain});

  @override
  State<ToiletBottomSheet> createState() => _ToiletBottomSheet();
}

class _ToiletBottomSheet extends State<ToiletBottomSheet> {
  List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.isMain ? 0.4 : 0.08,
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
              expandedHeight: 80,
              flexibleSpace: CustomBox(
                color: mainColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
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
                                    selectList: sortOrder,
                                    width: 120,
                                    height: 25,
                                  ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: CustomText(
                          title: '필터를 적용한 결과입니다',
                          fontSize: FontSize.smallSize,
                          color: CustomColors.whiteColor,
                          font: notoSans,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (BuildContext context, int index) {
                  return const CustomBox(
                    radius: 0,
                    color: mainColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListItem(),
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
