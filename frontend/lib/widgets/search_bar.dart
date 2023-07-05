import 'package:find_toilet/providers/state_provider.dart';
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
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  final bool isMain, showReview;
  final String? query;
  final ReturnVoid? onSearchMode;
  final ReturnVoid refreshPage;
  // final void Function(String value) onChange;
  // final ReturnVoid onSearchAction;
  const CustomSearchBar({
    super.key,
    required this.isMain,
    this.showReview = false,
    required this.refreshPage,
    this.onSearchMode,
    this.query,
    // required this.onSearchAction,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool showDetail = false;
  final StringList sortOrder = ['가까운 순', '평점 좋은 순', '리뷰 많은 순'];
  final DynamicMap searchData = {};
  final StringList filterKeyList = ['diaper', 'kids', 'disabled', 'allDay'];
  final BoolList filterValueList = [];
  late int sortIdx;
  late String sortValue;
  bool enabledBookMark = true;
  bool enabledSearch = true;

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
      if (getSortIdx(context) != sortIdx) {
        return true;
      }
      return false;
    }
  }

  void onSearchAction() {
    if (enabledSearch) {
      setState(() {
        enabledSearch = false;
      });
      final keyword = searchData['keyword'];
      if (keyword == null || keyword == '') {
        showModal(
          context,
          page: const AlertModal(
            title: '검색어 입력',
            content: '검색어를 입력해주세요',
          ),
        );
      } else if (isChanged()) {
        setSortIdx(context, sortIdx);
        // print(filterValueList);
        for (int i = 0; i < 4; i += 1) {
          if (filterValueList[i] != searchData[filterKeyList[i]]) {
            setFilter(context, i, filterValueList[i]);
          }
        }
        context.read<MainSearchProvider>().setSearchData(searchData);
        routerPush(
          context,
          page: Search(query: keyword),
        )();
      }
      setState(() {
        enabledSearch = true;
      });
    }
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

  void onPressed() async {
    if (enabledBookMark) {
      setState(() {
        enabledBookMark = false;
      });
      if (readToken(context) != null) {
        routerPush(context, page: const BookMarkFolderList())();
      } else {
        await showModal(
          context,
          page: hideModal(context)
              ? LoginConfirmModal(
                  showReview: widget.showReview,
                  toiletId: getToiletId(context),
                  isMain: widget.isMain,
                  afterLogin: () {
                    setState(() {});
                  },
                )
              : JoinModal(
                  showReview: false,
                  refreshPage: widget.refreshPage,
                ),
        );
      }
      setState(() {
        enabledBookMark = true;
      });
    }
  }

  void onChange(String? value) {
    print('value => $value');
    searchData['keyword'] = value;
    if (value == null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      color: showDetail ? mainColor : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Focus(
                  onFocusChange: changeShowVar,
                  child: CustomTextField(
                    textHeight: 1.2,
                    width: screenWidth(context) * 0.8,
                    padding: const EdgeInsetsDirectional.all(0),
                    boxShadow: const [defaultShadow],
                    onChanged: onChange,
                    searchMode: true,
                    onSubmitted: (_) => onSearchAction(),
                    initValue: searchData['keyword'],
                    hintText: widget.isMain ? '검색어를 입력하세요' : '',
                    prefixIcon: CustomIconButton(
                      icon: widget.isMain ? hamburgerIcon : exitIcon,
                      onPressed: routerPush(
                        context,
                        page: widget.isMain
                            ? Settings(
                                toiletId: getToiletId(context),
                                showReview: widget.showReview,
                                refreshPage: widget.refreshPage,
                              )
                            : const Main(),
                        afterPush: widget.refreshPage,
                      ),
                      color: CustomColors.blackColor,
                    ),
                    suffixIcon: searchData['keyword'] != null &&
                            searchData['keyword'] != ''
                        ? CustomIconButton(
                            icon: closeIcon,
                            onPressed: () {
                              onChange(null);
                              // print(readQuery(context));
                            },
                            color: CustomColors.blackColor,
                          )
                        : null,
                  ),
                ),
                // showDetail
                //     ? const SizedBox()
                //     :
                CustomCircleButton(
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CustomText(
                              title: '원하는 조건이 있으신가요?',
                              color: CustomColors.whiteColor,
                              // fontSize: FontSize.smallSize,
                              font: kimm,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FilterBox(
                          onPressed: changeFilterState,
                          filterList: filterValueList,
                        ),
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CustomText(
                              title: '어떻게 정렬해드릴까요?',
                              color: CustomColors.whiteColor,
                              // fontSize: FontSize.smallSize,
                              font: kimm,
                            ),
                          ),
                        ],
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
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
