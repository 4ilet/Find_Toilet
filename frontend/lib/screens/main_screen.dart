import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/map_widget.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  final bool showReview;
  // final int? index;
  final ToiletModel? toiletModel;
  final double? itemHeight;
  const Main({
    super.key,
    this.showReview = false,
    this.itemHeight,
    // this.index,
    this.toiletModel,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // DynamicMap query = {'value': null};
  final globalKey = GlobalKey<ScaffoldState>();
  double paddingTop = 0;
  // ToiletModel? toiletModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          paddingTop = statusBarHeight(context);
        });
        // if (widget.index != null) {
        //   setState(() {
        //     toiletModel = mainToiletData(context)[widget.index];
        //   });
        // }
        initLoadingData(context);
        initMainData(
          context,
          showReview: widget.showReview,
          toiletId: widget.toiletModel?.toiletId,
          // toiletId: toiletModel?.toiletId,
        );
        // setQuery(context, null);
        setKey(context, globalKey);
      },
    );
  }

  // void onSearchAction() {
  //   if (query['value'] != '') {
  //     return routerPush(
  //       context,
  //       page: Search(
  //         query: query['value'] ?? '',
  //       ),
  //     )();
  //   }
  //   showModal(
  //     context,
  //     page: const AlertModal(
  //       title: '검색어 입력',
  //       content: '검색어를 입력해주세요',
  //     ),
  //   );
  // }

  void refreshMain(int index) {
    print('refresh main! ${readLoading(context)}');
    print('get token : ${readToken(context)}');
    if (!readLoading(context)) {
      refreshData(
        context,
        isMain: true,
        showReview: false,
      );
    }
  }

  // void initData() {
  //   if (readLoading(context)) {
  //     if (widget.showReview) {
  //       ReviewProvider()
  //           .getReviewList(widget.toiletModel!.toiletId, getPage(context))
  //           .then((reviewData) {
  //         addReviewList(context, reviewData);
  //         setLoading(context, false);
  //       });
  //     } else {
  //       ToiletProvider()
  //           .getNearToilet(mainToiletData(context))
  //           .then((toiletData) {
  //         addToiletList(context, toiletData);
  //         setLoading(context, false);
  //       });
  //     }
  //     increasePage(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('main build');
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
          key: globalKey,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(top: paddingTop),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth(context),
                      height: screenHeight(context) - paddingTop,
                      child: const MapScreen(),
                    ),
                  ],
                ),
                widget.showReview
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Column(
                          children: [
                            FilterBox(
                              onPressed: refreshMain,
                              applyLong: !isDefaultTheme(context),
                              isMain: true,
                            ),
                          ],
                        ),
                      ),
                ToiletBottomSheet(
                  showReview: widget.showReview,
                  itemHeight: widget.itemHeight,
                  // index: widget.index,
                  toiletModel: widget.toiletModel,
                ),
                Column(
                  children: [
                    CustomSearchBar(
                      isMain: true,
                      showReview: widget.showReview,
                      // toiletId: toiletModel?.toiletId,
                      toiletId: widget.toiletModel?.toiletId,
                    ),
                  ],
                ),
                watchPressed(context)
                    ? Center(
                        child: CustomBox(
                          height: 80,
                          width: isDefaultTheme(context) ? 300 : 350,
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                          child: const Center(
                            child: CustomText(
                              title: '뒤로 가기 버튼을 한 번 더\n누르시면 앱이 종료됩니다',
                              isCentered: true,
                              color: CustomColors.whiteColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
