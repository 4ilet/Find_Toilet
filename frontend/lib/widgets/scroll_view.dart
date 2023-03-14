import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:flutter/material.dart';

//* 즐겨찾기 내 화장실 목록
class ToiletScrollView extends StatelessWidget {
  final double toolbarHeight, expandedHeight;
  final Widget flexibleSpace;
  const ToiletScrollView({
    super.key,
    required this.toolbarHeight,
    required this.expandedHeight,
    required this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          pinned: true,
          expandedHeight: 80,
          flexibleSpace: flexibleSpace,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (BuildContext context, int index) {
              return const CustomBox(
                color: mainColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListItem(showReview: false),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
