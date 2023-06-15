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
  final void Function(String value) onChange;
  // final ReturnVoid onSearchAction;
  const SearchBar({
    super.key,
    required this.isMain,
    required this.onChange,
    // required this.onSearchAction,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showDetail = false;
  final StringList sortOrder = ['가까운 순', '리뷰 많은 순', '평점 좋은 순'];
  // final StringList sortValues = ['distance', 'score', 'comment'];
  late int sortIdx;
  late String sortValue;
  IntList selectedFilters = [];
  // DynamicMap searchData = {
  //     'allDay': allDay,
  //     'diaper': diaper,
  //     'disabled': disabled,
  //     'kids': kids,
  //     'keyword': widget.query,
  //     // 'keyword': readQuery(context),
  //     'lat': 37.537229,
  //     'lon': 127.005515,
  //     'page': -1,
  //     'size': cnt,
  //     'order': sortValues[sortIdx],
  //   };

  @override
  void initState() {
    sortIdx = getSortIdx(context);
    sortValue = sortOrder[sortIdx];
    super.initState();
  }

  bool isChanged() {
    if (searchData['keyword'] != widget.query) {
      return true;
    } else if (searchData['allDay'] != allDay) {
      return true;
    } else if (searchData['diaper'] != diaper) {
      return true;
    } else if (searchData['disabled'] != diaper) {
      return true;
    } else if (searchData['kids'] != diaper) {
      return true;
    }
    return false;
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
      // setFilter(context, index);
      routerPush(
        context,
        page: Search(query: keyword!),
      );
    }
    return;
  }

  void changeShowVar(bool value) {
    setState(() {
      showDetail = value;
    });
  }

  void changeSortValue(int i) {
    setState(() {
      if (selectedValue != sortOrder[i]) {
        sort selectedValue = sortOrder[i];
      }
    });
  }

  void changeFilterState(int index) {
    switch (index) {
      case 0:
        searchData['diaper'] = !searchData['diaper'];
        return;
      case 1:
        searchData['kids'] = !searchData['kids'];
        return;
      case 2:
        searchData['disabled'] = !searchData['disabled'];
        return;
      default:
        searchData['allDay'] = !searchData['allDay'];
        return;
    }
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

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      color: showDetail ? mainColor : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 100),
              Focus(
                onFocusChange: changeShowVar,
                child: CustomTextField(
                  width: showDetail
                      ? screenWidth(context) * 0.9
                      : screenWidth(context) * 0.8,
                  padding: const EdgeInsetsDirectional.all(0),
                  boxShadow: const [defaultShadow],
                  onChanged: widget.onChange,
                  searchMode: true,
                  onSubmitted: (_) => onSearchAction(),
                  initValue: getQuery(context),
                  hintText: '검색어를 입력하세요',
                  prefixIcon: CustomIconButton(
                    icon: widget.isMain ? hamburgerIcon : exitIcon,
                    onPressed: routerPush(
                      context,
                      page: widget.isMain ? const Settings() : const Main(),
                    ),
                    color: CustomColors.blackColor,
                  ),
                  suffixIcon:
                      getQuery(context) != null && getQuery(context) != ''
                          ? CustomIconButton(
                              icon: closeIcon,
                              onPressed: () {
                                widget.onChange('');
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
          showDetail
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      const CustomText(
                        title: '원하는 조건이 있으신가요?',
                        color: CustomColors.whiteColor,
                        fontSize: FontSize.smallSize,
                        font: kimm,
                      ),
                      const FilterBox(),
                      const CustomText(
                        title: '어떻게 정렬해드릴까요?',
                        color: CustomColors.whiteColor,
                        fontSize: FontSize.smallSize,
                        font: kimm,
                      ),
                      for (String value in sortOrder)
                        CustomBox(child: CustomText(title: value)),
                      GestureDetector(
                        onTap: onSearchAction,
                        child: CustomBox(
                          width: screenWidth(context) * 0.9,
                          height: 50,
                          color: whiteColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconButton(
                                onPressed: () {},
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
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
