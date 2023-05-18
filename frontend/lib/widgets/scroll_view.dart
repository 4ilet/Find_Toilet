import 'package:find_toilet/widgets/silvers.dart';
import 'package:flutter/material.dart';

//* 즐겨찾기 내 화장실 목록
class ToiletScrollView extends StatelessWidget {
  final double toolbarHeight, expandedHeight;
  final Widget flexibleSpace;
  final int folderId;
  const ToiletScrollView({
    super.key,
    required this.toolbarHeight,
    required this.expandedHeight,
    required this.flexibleSpace,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSilverAppBar(
          toolbarHeight: toolbarHeight,
          expandedHeight: expandedHeight,
          flexibleSpace: flexibleSpace,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        ),
        CustomSilverList(
          folderId: folderId,
          showReview: false,
          isMain: false,
        )
      ],
    );
  }
}