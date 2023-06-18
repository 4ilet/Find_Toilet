import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
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
  final StringList sortValues = ['distance', 'score', 'comment'];
  final ToiletList toiletList = [];
  final scrollController = ScrollController();
  final cnt = 10;
  bool expandSearch = false;

  DynamicMap searchData = {};
  late String selectedValue;
  late bool allDay, diaper, disabled, kids;

  @override
  void initState() {
    super.initState();
    initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLoadingData(context);
      firstSearch();
      scrollController.addListener(() async {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9) {
          if (getPage(context) < getTotal(context)!) {
            if (!getWorking(context)) {
              setState(() {
                setWorking(context, true);
              });
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

  void initData() {
    final sortIdx = getSortIdx(context);
    allDay = readFilter(context, 0);
    diaper = readFilter(context, 1);
    disabled = readFilter(context, 2);
    kids = readFilter(context, 3);
    searchData = {
      'allDay': allDay,
      'diaper': diaper,
      'disabled': disabled,
      'kids': kids,
      'keyword': widget.query,
      // 'keyword': readQuery(context),
      'lat': readLat(context),
      'lon': readLng(context),
      'page': -1,
      'size': cnt,
      'order': sortValues[sortIdx],
    };
  }

  void firstSearch() async {
    if (readLoading(context)) {
      searchData['page'] += 1;
      ToiletProvider().searchToilet(searchData).then((data) {
        print('first search : $searchData');
        print(data);
        setState(() {
          toiletList.addAll(data);
        });
        setLoading(context, false);
      });
      increasePage(context);
    }
  }

  void search() async {
    if (getAdditional(context)) {
      searchData['page'] += 1;
      ToiletProvider().searchToilet(searchData).then((data) {
        toiletList.addAll(data);
        setLoading(context, false);
        setAdditional(context, false);
        setWorking(context, false);
        increasePage(context);
      });
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
    return WillPopScope(
      onWillPop: () {
        routerPush(context, page: const Main());
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: CustomBoxWithScrollView(
          expandedHeight: expandSearch ? 500 : 130,
          listScroll: scrollController,
          flexibleSpace: Column(
            children: [
              SearchBar(
                isMain: false,
                onSearchMode: changeExpandSearch,
                // onChange: (value) {
                //   setQuery(context, value);
                //   searchData['keyword'] = value;
                //   print('data: ${searchData['keyword']}');
                //   print('value : $value');
                // },
                // onSearchAction: onSearchAction,
              ),
              topOfAppBar(),
            ],
          ),
          silverChild: [
            CustomSilverList(
              showReview: false,
              isMain: false,
              isSearch: true,
              data: toiletList,
            )
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: CustomText(
              title: '검색 결과',
              fontSize: FontSize.largeSize,
              color: CustomColors.whiteColor,
              font: kimm,
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: changeExpandSearch,
              child: const TextWithIcon(
                icon: settingsIcon,
                text: '검색 설정',
                iconColor: CustomColors.whiteColor,
                textColor: CustomColors.whiteColor,
                font: kimm,
              ),
            ),
          )
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
