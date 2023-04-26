import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/map_widget.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  final bool showReview;
  const Main({super.key, this.showReview = false});

  @override
  Widget build(BuildContext context) {
    initWidthHeight(context);

    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: const MapScreen(),
                  ),
                ],
              ),
              Column(children: const [SearchBar(isMain: true), FilterBox()]),
              watchPressed(context)
                  ? const Center(
                      child: CustomBox(
                        height: 60,
                        width: 300,
                        color: whiteColor,
                        child: CustomText(
                          title: '뒤로 가기 버튼을 한 번 더 누르시면 앱이 종료됩니다',
                        ),
                      ),
                    )
                  : const SizedBox(),
              ToiletBottomSheet(isMain: true, showReview: showReview)
            ],
          ),
        ),
      ),
    );
  }
}
