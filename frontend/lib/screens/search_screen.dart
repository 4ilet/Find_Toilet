import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String query;
  final ToiletModel? toiletModel;
  const Search({
    super.key,
    required this.query,
    this.toiletModel,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // final StringList sortValues = ['distance', 'score', 'comment'];
  // final ToiletList toiletList = [];
  final scrollController = ScrollController();
  final cnt = 10;
  bool expandSearch = false;
  bool refreshState = true;
  final globalKey = GlobalKey<ScaffoldState>();

  // DynamicMap searchData = {};
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() async {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9) {
          if (getPage(context) < getTotal(context)!) {
            if (!getWorking(context)) {
              setWorking(context, true);
              Future.delayed(const Duration(milliseconds: 2000), () {
                if (!getAdditional(context)) {
                  setAdditional(context, true);
                  search();
                }
              });
            }
          }
        }
      });
    });
  }

  void firstSearch() {
    if (readLoading(context)) {
      initSearchList(context);
      getSearchList(context).then((_) {
        setLoading(context, false);
        refreshState = false;
      });
      // setState(() {
      // });
      increasePage(context);
    }
  }

  void search() async {
    if (getAdditional(context)) {
      getSearchList(context).then((_) {
        setAdditional(context, false);
        setWorking(context, false);
      });
      increasePage(context);
    }
  }

  void changeExpandSearch() {
    setState(() {
      if (!expandSearch) {
        expandSearch = true;
      } else {
        expandSearch = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (refreshState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          initLoadingData(context);
          firstSearch();
          setKey(context, globalKey);
        },
      );
    }
    return WillPopScope(
      onWillPop: () {
        removedRouterPush(context, page: const Main());
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: globalKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: mainColor,
          body: Padding(
            padding: EdgeInsets.only(top: statusBarHeight(context)),
            child: CustomBoxWithScrollView(
              expandedHeight: expandSearch
                  ? 430
                  : isDefaultTheme(context)
                      ? 100
                      : 130,
              listScroll: scrollController,
              flexibleSpace: Column(
                children: [
                  CustomSearchBar(
                    isMain: false,
                    query: widget.query,
                    onSearchMode: changeExpandSearch,
                    refreshPage: () {
                      // initLoadingData(context);
                      // firstSearch();
                      setState(() {
                        refreshState = true;
                      });
                    },
                  ),
                  topOfAppBar(),
                ],
              ),
              silverChild: [
                CustomSilverList(
                  showReview: false,
                  isMain: false,
                  isSearch: true,
                  data: searchToiletList(context),
                  refreshPage: () {
                    // initLoadingData(context);
                    // firstSearch();
                    setState(() {
                      refreshState = true;
                    });
                  },
                  // refreshPage: search,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Padding searchToiletList() {
  //   return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 10),
  //       child: CustomListView(
  //         itemCount: toiletList.length,
  //         itemBuilder: (context, i) {
  //           return Column(
  //             children: [
  //               i < searchData['page'] * cnt
  //                   ? ListItem(
  //                       data: toiletList[i],
  //                       showReview: false,
  //                     )
  //                   : !additional
  //                       ? ListItem(
  //                           data: toiletList[i],
  //                           showReview: false,
  //                         )
  //                       : const SizedBox(),
  //               i == toiletList.length - 1 &&
  //                       getTotal(context) != searchData['page']
  //                   ? const Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         vertical: 40,
  //                       ),
  //                       child: Center(
  //                         child: CircularProgressIndicator(),
  //                       ),
  //                     )
  //                   : const SizedBox()
  //             ],
  //           );
  //         },
  //       ));
  // }

  //* app bar 맨 윗 부분
  Padding topOfAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Flexible(
            child: CustomText(
              title: '검색 결과',
              fontSize: FontSize.largeSize,
              color: CustomColors.whiteColor,
              font: kimm,
            ),
          ),
          // Flexible(
          //   child: GestureDetector(
          //     onTap: changeExpandSearch,
          //     child: const TextWithIcon(
          //       icon: settingsIcon,
          //       text: '검색 설정',
          //       iconColor: CustomColors.whiteColor,
          //       textColor: CustomColors.whiteColor,
          //       font: kimm,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  //* 선택 상자 눌렀을 때 나오는 목록
  // Widget sortList() {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(0, position!.dy, 20, 0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         CustomBox(
  //           width: 120,
  //           color: whiteColor,
  //           boxShadow: const [defaultShadow],
  //           child: Column(
  //             children: [
  //               for (int i = 0; i < 3; i += 1)
  //                 CustomBox(
  //                   onTap: () => changeSelected(i),
  //                   width: 120,
  //                   child: Center(
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 4),
  //                       child: CustomText(
  //                         title: sortOrder[i],
  //                         fontSize: FontSize.smallSize,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
