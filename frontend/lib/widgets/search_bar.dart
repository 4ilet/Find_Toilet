import 'package:find_toilet/screens/book_mark_folder_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/search_screen.dart';
import 'package:find_toilet/screens/settings_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool isMain;
  final String? query;
  final ReturnVoid? onSearchMode;
  // final void Function(String value) onChange;
  // final ReturnVoid onSearchAction;
  const SearchBar({
    super.key,
    required this.isMain,
    this.onSearchMode,
    this.query,
    // required this.onSearchAction,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showDetail = false;
  final StringList sortOrder = ['가까운 순', '리뷰 많은 순', '평점 좋은 순'];
  final StringList sortValues = ['distance', 'score', 'comment'];
  final DynamicMap searchData = {};
  final StringList filterKeyList = ['diaper', 'kids', 'disabled', 'allDay'];
  final BoolList filterValueList = [];
  late int sortIdx;
  late String sortValue;

  @override
  void initState() {
    super.initState();
    sortIdx = getSortIdx(context);
    sortValue = sortOrder[sortIdx];
    for (int i = 0; i < 4; i += 1) {
      filterValueList.add(readFilter(context, i));
    }
    searchData.addAll({
      'keyword': widget.query,
      for (int i = 0; i < 4; i += 1) filterKeyList[i]: filterValueList[i],
    });
    // setState(() {
    // });
    print(searchData);
  }

  bool isChanged() {
    if (searchData['keyword'] != widget.query) {
      return true;
    } else {
      for (int i = 0; i < 4; i += 1) {
        if (filterValueList[i] != searchData[filterKeyList[i]]) {
          return true;
        }
      }
      return false;
    }
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
    } else if (isChanged()) {
      setSortIdx(context, sortIdx);
      // print(filterValueList);
      for (int i = 0; i < 4; i += 1) {
        if (filterValueList[i] != searchData[filterKeyList[i]]) {
          setFilter(context, i, filterValueList[i]);
        }
      }
      routerPush(
        context,
        page: Search(query: keyword),
      )();
    }
    return;
  }

  void changeShowVar(bool value) {
    if (widget.onSearchMode != null) {
      widget.onSearchMode!();
    }
    setState(() {
      showDetail = value;
    });
  }

  void changeSortValue(int i) {
    setState(() {
      if (sortIdx != i) {
        sortIdx = i;
      }
    });
  }

  void changeFilterState(int index) {
    setState(() {
      filterValueList[index] = !filterValueList[index];
    });
  }

  void onPressed() {
    readToken(context) != null
        ? routerPush(context, page: const BookMarkFolderList())()
        : showModal(
            context,
            page: const LoginConfirmModal(
              page: BookMarkFolderList(),
            ),
          );
  }

  void onChange(String value) {
    searchData['keyword'] = value;
  }

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      color: showDetail ? mainColor : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Focus(
                  onFocusChange: changeShowVar,
                  child: CustomTextField(
                    width: showDetail
                        ? screenWidth(context) * 0.9
                        : screenWidth(context) * 0.8,
                    padding: const EdgeInsetsDirectional.all(0),
                    boxShadow: const [defaultShadow],
                    onChanged: onChange,
                    searchMode: true,
                    onSubmitted: (_) => onSearchAction(),
                    initValue: searchData['keyword'],
                    hintText: '검색어를 입력하세요',
                    prefixIcon: CustomIconButton(
                      icon: widget.isMain ? hamburgerIcon : exitIcon,
                      onPressed: routerPush(
                        context,
                        page: widget.isMain ? const Settings() : const Main(),
                      ),
                      color: CustomColors.blackColor,
                    ),
                    suffixIcon: searchData['keyword'] != null &&
                            searchData['keyword'] != ''
                        ? CustomIconButton(
                            icon: closeIcon,
                            onPressed: () {
                              print('초기화');
                              // widget.onChange('');
                              onChange('');
                              print(readQuery(context));
                            },
                            color: CustomColors.blackColor,
                          )
                        : null,
                  ),
                ),
                showDetail
                    ? const SizedBox()
                    : CustomCircleButton(
                        width: 40,
                        height: 40,
                        child: CustomIconButton(
                          onPressed: onPressed,
                          icon: bookMarkIcon,
                          color: CustomColors.blackColor,
                        ),
                      ),
              ],
            ),
          ),
          showDetail
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomText(
                          title: '원하는 조건이 있으신가요?',
                          color: CustomColors.whiteColor,
                          fontSize: FontSize.smallSize,
                          font: kimm,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FilterBox(
                          onPressed: changeFilterState,
                          filterList: filterValueList,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomText(
                          title: '어떻게 정렬해드릴까요?',
                          color: CustomColors.whiteColor,
                          fontSize: FontSize.smallSize,
                          font: kimm,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 3; i += 1)
                            CustomBox(
                              color: whiteColor,
                              border: sortIdx == i
                                  ? Border.all(color: redColor)
                                  : null,
                              onTap: () => changeSortValue(i),
                              radius: 5,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12,
                                  ),
                                  child: CustomText(
                                    title: sortOrder[i],
                                    font: kimm,
                                    fontSize: FontSize.smallSize,
                                    color: CustomColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: onSearchAction,
                          child: CustomBox(
                            width: screenWidth(context) * 0.9,
                            height: 50,
                            color: whiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  onPressed: onSearchAction,
                                  icon: searchIcon,
                                  color: CustomColors.mainColor,
                                ),
                                const SizedBox(width: 5),
                                const CustomText(
                                  title: '검색하기',
                                  font: kimm,
                                  color: CustomColors.mainColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
