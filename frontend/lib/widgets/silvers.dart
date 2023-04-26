import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* app bar
class CustomSilverAppBar extends StatelessWidget {
  final double toolbarHeight, expandedHeight;
  final Widget flexibleSpace;
  final Color backgroundColor;

  const CustomSilverAppBar({
    super.key,
    required this.toolbarHeight,
    required this.expandedHeight,
    required this.flexibleSpace,
    required this.backgroundColor,
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
    );
  }
}

//* silver list
class CustomSilverFutureList extends StatelessWidget {
  final Future<List> future;
  final bool showReview;
  final bool isReview;
  final int? toiletId;
  final String? toiletName;
  const CustomSilverFutureList({
    super.key,
    required this.future,
    required this.showReview,
    this.isReview = false,
    this.toiletId,
    this.toiletName,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomBox(
                  color: mainColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: snapshot.data!.isNotEmpty
                        ? isReview
                            ? reviewListView(snapshot.data! as ReviewList)
                            : CustomListView(
                                itemBuilder: (context, index) => ListItem(
                                  isMain: false,
                                  showReview: false,
                                  data: snapshot.data![index],
                                ),
                              )
                        : Center(
                            child: CustomText(
                              title:
                                  '${isReview ? '화장실 리뷰가' : '즐겨찾기한 화장실이'} 없습니다',
                              color: CustomColors.whiteColor,
                            ),
                          ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ]),
    );
  }

  // ListView toiletListView(ToiletList data) {
  //   return ListView.builder(
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       return ListItem(
  //         showReview: false,
  //         data: data[index],
  //         isMain: false,
  //       );
  //     },
  //   );
  // }

  ListView reviewListView(ReviewList data) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ReviewBox(
          review: data[index],
          toiletId: toiletId!,
          toiletName: toiletName!,
        );
      },
    );
  }
}
