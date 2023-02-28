import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/map_widget.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  const Main({super.key});

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
                  // child: CustomText(
                  //   title: '여기에 지도 들어감 \n 메인 페이지',
                  //   fontSize: FontSize.titleSize,
                  //   color: CustomColors.whiteColor,
                  // ),
                  child: MapScreen(),
                ),
              ),
            ],
          ),
          Column(children: const [SearchBar(isMain: true), FilterBox()]),
          // const ToiletList(isMain: true),
          const ToiletBottomSheet(
            isMain: true,
          )
        ],
      ),
    );
  }
}
