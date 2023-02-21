import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/select_box.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 여기에 지도
              Column(
                children: const [
                  SearchBar(),
                  CustomText(
                    title: '여기에 필터',
                    fontSize: FontSize.largeSize,
                    color: CustomColors.blackColor,
                  ),
                ],
              ),
              const ToiletList(),
            ],
          ),
        ],
      ),
    );
  }
}

class ToiletList extends StatelessWidget {
  const ToiletList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 70,
                  height: 4.5,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomText(
                        title: '검색 결과',
                        fontSize: FontSize.largeSize,
                        color: CustomColors.whiteColor,
                      ),
                      SelectBox(selectList: sortOrder, width: 100, height: 24)
                    ],
                  ),
                ),
                const ListItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
