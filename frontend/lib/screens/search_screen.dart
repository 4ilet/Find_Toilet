import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
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
  final String query, order;
  final ToiletModel? toiletModel;
  const Search({
    super.key,
    required this.query,
    this.toiletModel,
    this.order = 'distance',
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
  late final Future<ToiletList> toiletList;
  late String selectedValue;
  bool showList = false;

  @override
  void initState() {
    super.initState();
    selectedValue = sortOrder.first;
    toiletList = ToiletProvider().searchToilet({
      'allDay': 0,
      'diaper': 0,
      'disabled': 0,
      'kids': 0,
      'keyword': widget.query,
      'lat': 37.537229,
      'lon': 127.005515,
      'page': 0,
      'size': 10,
      'order': widget.order,
    });
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

  void changeSelected(String value) {
    setState(() {
      selectedValue = value;
      changeShowState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: CustomBox(
        radius: 0,
        color: mainColor,
        child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSilverAppBar(
                toolbarHeight: 200,
                expandedHeight: 100,
                flexibleSpace: Stack(
                  children: [
                    Column(
                      children: [
                        SearchBar(
                          isMain: false,
                          query: widget.query,
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
                  delegate: SliverChildListDelegate([
                FutureBuilder(
                    future: toiletList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomListView(
                            itemCount: data!.length,
                            itemBuilder: (context, i) => ListItem(
                              data: data[i],
                              showReview: false,
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ])),
            ]),
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
      padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomBox(
            width: 120,
            color: whiteColor,
            boxShadow: const [defaultShadow],
            child: Column(
              children: [
                for (String select in sortOrder)
                  CustomBox(
                    onTap: () => changeSelected(select),
                    width: 120,
                    child: Center(
                      child: CustomText(
                        title: select,
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
