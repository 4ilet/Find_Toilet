import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/select_box.dart';
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
  StringList sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  StringList sortValues = ['distance', 'score', 'comment'];
  ToiletList toiletList = [];
  late String selectedValue;
  final scrollController = ScrollController();
  bool showList = false;
  bool loading = true;
  bool additional = false;
  bool working = false;
  final DynamicMap searchData = {
    'allDay': 0,
    'diaper': 0,
    'disabled': 0,
    'kids': 0,
    'keyword': null,
    'lat': 37.537229,
    'lon': 127.005515,
    'page': -1,
    'size': 10,
    'order': 'distance',
  };

  @override
  void initState() {
    super.initState();
    selectedValue = sortOrder.first;
    searchData['keyword'] = widget.query;
    firstSearch();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        if (!working) {
          setState(() {
            working = true;
          });
          Future.delayed(const Duration(milliseconds: 2000), () {
            if (!additional) {
              setState(() {
                additional = true;
              });
              search();
            }
          });
        }
      }
    });
  }

  void firstSearch() async {
    if (loading) {
      searchData['page'] += 1;
      final data = await ToiletProvider().searchToilet(searchData);
      toiletList.addAll(data);
      setState(() {
        loading = false;
      });
    }
  }

  void search() async {
    // print(additional);
    if (additional && searchData['page'] < getTotal(context)) {
      // print('search 함수 실행 => $searchData');
      searchData['page'] += 1;
      final data = await ToiletProvider().searchToilet(searchData);
      toiletList.addAll(data);
      // print(toiletList.length);
      setState(() {
        additional = false;
        working = false;
      });
      // print(toiletList.length);
      // print('getTotal: ${getTotal(context)}');
    }
  }

  void changeShowState() {
    setState(() {
      if (!showList) {
        showList = true;
      } else {
        showList = false;
      }
    });
  }

  void changeSelected(int i) {
    setState(() {
      if (selectedValue != sortOrder[i]) {
        selectedValue = sortOrder[i];
        searchData['order'] = sortValues[i];
        searchData['page'] = 0;
        changeShowState();
        loading = true;
        firstSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          CustomBox(
            radius: 0,
            color: mainColor,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              slivers: [
                CustomSilverAppBar(
                  elevation: 0,
                  toolbarHeight: 200,
                  expandedHeight: 100,
                  flexibleSpace: Stack(
                    children: [
                      Column(
                        children: [
                          SearchBar(
                            isMain: false,
                            query: searchData['keyword'] as String,
                          ),
                          topOfAppBar(),
                          const FilterBox()
                        ],
                      ),
                      showList ? sortList() : const SizedBox()
                    ],
                  ),
                  backgroundColor: mainColor,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: !loading
                            ? CustomListView(
                                itemCount: toiletList.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      i < searchData['page'] * 10
                                          ? ListItem(
                                              data: toiletList[i],
                                              showReview: false,
                                            )
                                          : !additional
                                              ? ListItem(
                                                  data: toiletList[i],
                                                  showReview: false,
                                                )
                                              : const SizedBox(),
                                      i == toiletList.length - 1 &&
                                              getTotal(context) !=
                                                  searchData['page']
                                          ? const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 40,
                                              ),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                      // : const Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //* app bar 맨 윗 부분
  Padding topOfAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
            title: '검색 결과',
            fontSize: FontSize.largeSize,
            color: CustomColors.whiteColor,
            font: kimm,
          ),
          SelectBox(
            showList: showList,
            onTap: changeShowState,
            width: 120,
            height: 25,
            value: selectedValue,
          ),
        ],
      ),
    );
  }

  //* 선택 상자 눌렀을 때 나오는 목록
  Padding sortList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 120, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomBox(
            width: 120,
            color: whiteColor,
            boxShadow: const [defaultShadow],
            child: Column(
              children: [
                for (int i = 0; i < 3; i += 1)
                  CustomBox(
                    onTap: () => changeSelected(i),
                    width: 120,
                    child: Center(
                      child: CustomText(
                        title: sortOrder[i],
                        fontSize: FontSize.smallSize,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
