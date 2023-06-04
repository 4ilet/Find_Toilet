import 'package:find_toilet/screens/book_mark_folder_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
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
  final ReturnVoid onSearchAction;
  final ReturnVoid? pressedFilter;
  const SearchBar({
    super.key,
    required this.isMain,
    required this.onChange,
    required this.onSearchAction,
    this.pressedFilter,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showDetail = false;

  @override
  void initState() {
    super.initState();
    // focus.addListener(() {
    //   setState(() {
    //     showDetail = true;
    //   });
    // });
  }

  void changeShowVar(bool value) {
    setState(() {
      showDetail = value;
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
              CustomBox(
                width: screenWidth(context) * 0.8,
                height: 40,
                boxShadow: const [defaultShadow],
                color: whiteColor,
                radius: 5,
                child: Focus(
                    onFocusChange: changeShowVar,
                    child: CustomTextField(
                      onChanged: widget.onChange,
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
                    )),
              ),
              //   width: 40,
              //   height: 40,
              //   child: CustomIconButton(
              //     onPressed: widget.onSearchAction,
              //     icon: searchIcon,
              //     color: CustomColors.blackColor,
              //   ),
              // ),
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
          FilterBox(onPressed: widget.pressedFilter),
          showDetail
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          CustomCircleButton(
                            width: 40,
                            height: 40,
                            child: CustomIconButton(
                              onPressed: widget.onSearchAction,
                              icon: searchIcon,
                              color: CustomColors.blackColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
