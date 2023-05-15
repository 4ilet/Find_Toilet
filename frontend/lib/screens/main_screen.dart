import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/screens/search_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/map_widget.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  final bool showReview;
  final ToiletModel? toiletModel;
  const Main({
    super.key,
    this.showReview = false,
    this.toiletModel,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late final Future<ToiletList>? toiletList;
  DynamicMap query = {'value': null};
  @override
  void initState() {
    super.initState();
    if (widget.showReview) {
      toiletList = null;
    } else {
      toiletList = ToiletProvider().getNearToilet({
        'allDay': readFilter(context, 0),
        'diaper': readFilter(context, 1),
        'disabled': readFilter(context, 2),
        'kids': readFilter(context, 3),
        'lat': 37.537229,
        'lon': 127.005515,
        'radius': 1000,
        'page': 0,
        'size': 30,
      });
    }
  }

  void onSearchAction() {
    if (query['value'] != '') {
      return routerPush(
        context,
        page: Search(query: query['value']!),
      )();
    }
    showModal(
      context,
      page: const AlertModal(
        title: '검색어 입력',
        content: '검색어를 입력해주세요',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.showReview
          ? () {
              routerPop(context)();
              return Future.value(false);
            }
          : () => exitApp(context),
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
                    width: screenWidth(context),
                    height: screenHeight(context),
                    child: const MapScreen(),
                  ),
                ],
              ),
              Column(
                children: [
                  SearchBar(
                    isMain: true,
                    query: query['value'] ?? '',
                    onChange: (value) => query['value'] = value,
                    onSearchAction: onSearchAction,
                  ),
                  const FilterBox()
                ],
              ),
              ToiletBottomSheet(
                future: toiletList,
                showReview: widget.showReview,
                toiletModel: widget.toiletModel,
              ),
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
              CustomText(title: onRefresh(context).trim())
            ],
          ),
        ),
      ),
    );
  }
}
