import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final String query;
  const Search({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(color: yellowColor),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CustomText(
                    title: '여기에 지도 들어감 \n 검색 페이지',
                    fontSize: FontSize.titleSize,
                    color: CustomColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SearchBar(isMain: false, query: query),
              const FilterBox()
            ],
          ),
          const ToiletList(isMain: false),
        ],
      ),
    );
  }
}
