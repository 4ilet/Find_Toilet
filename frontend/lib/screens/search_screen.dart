import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/modal.dart';
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
  final StringList sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  final StringList sortValues = ['distance', 'score', 'comment'];
  final ToiletList toiletList = [];
  final scrollController = ScrollController();
  final cnt = 10;
  final selectedBoxKey = GlobalKey();
  Offset? position;

  bool showList = false;
  bool loading = true;
  bool additional = false;
  bool working = false;
  late final DynamicMap searchData;
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    final sortIdx = getSortIdx(context);
    searchData = {
      'allDay': readFilter(context, 0),
      'diaper': readFilter(context, 1),
      'disabled': readFilter(context, 2),
      'kids': readFilter(context, 3),
      'keyword': widget.query,
      'lat': 37.537229,
      'lon': 127.005515,
      'page': -1,
      'size': cnt,
      'order': sortValues[sortIdx],
    };
    selectedValue = sortOrder[sortIdx];
    firstSearch();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        if (searchData['page'] < getTotal(context)) {
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
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOffset();
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
    if (additional) {
      searchData['page'] += 1;
      final data = await ToiletProvider().searchToilet(searchData);
      toiletList.addAll(data);
      setState(() {
        additional = false;
        working = false;
      });
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
        setSortIdx(context, i);
        searchData['order'] = sortValues[i];
        selectedValue = sortOrder[i];
        searchData['page'] = -1;
        changeShowState();
        loading = true;
        firstSearch();
      } else {
        changeShowState();
      }
    });
  }

  void onSearchAction() {
    final keyword = searchData['keyword'];
    if (keyword == null || keyword == '') {
      showModal(
        context,
        page: const AlertModal(
          title: '검색어 입력',
          content: '검색어를 입력해주세요',
        ),
      );
      return;
    } else if (keyword != widget.query) {
      return routerPush(
        context,
        page: Search(query: keyword!),
      )();
    }
    return;
  }

  void getOffset() {
    if (selectedBoxKey.currentContext != null) {
      final renderBox =
          selectedBoxKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        position = renderBox.localToGlobal(Offset.zero);
      });
    }
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
                            onChange: (value) {
                              searchData['keyword'] = value;
                              print('data: ${searchData['keyword']}');
                            },
                            onSearchAction: onSearchAction,
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
                            ? toiletList.isNotEmpty
                                ? CustomListView(
                                    itemCount: toiletList.length,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          i < searchData['page'] * cnt
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
                                : const Center(
                                    child: CustomText(
                                      title: '조건에 맞는 화장실이 없습니다.',
                                      color: CustomColors.whiteColor,
                                    ),
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
            key: selectedBoxKey,
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
  Widget sortList() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, position!.dy, 20, 0),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomText(
                          title: sortOrder[i],
                          fontSize: FontSize.smallSize,
                        ),
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
