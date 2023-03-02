import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/search_screen.dart';
import 'package:find_toilet/screens/settings_screen.dart';
import 'package:find_toilet/utilities/global_func.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool isMain;
  final String? query;
  const SearchBar({super.key, required this.isMain, this.query});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 100),
        Container(
          width: 270,
          height: 40,
          decoration: BoxDecoration(
              boxShadow: const [defaultShadow],
              color: whiteColor,
              borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: widget.isMain
                ? null
                : TextEditingController(text: widget.query),
            style: const TextStyle(fontFamily: notoSans),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색어를 입력하세요',
              prefixIcon: CustomIconButton(
                icon: hamburgerIcon,
                onPressed: routerPush(context: context, page: const Settings()),
                color: CustomColors.blackColor,
              ),
              suffixIcon: CustomIconButton(
                icon: closeIcon,
                onPressed: routerPush(context: context, page: const Main()),
                color: CustomColors.blackColor,
              ),
            ),
          ),
        ),
        CustomCircleButton(
            width: 40,
            height: 40,
            child: CustomIconButton(
              onPressed: routerPush(
                context: context,
                page: const Search(query: '광주'),
              ),
              icon: searchIcon,
              color: CustomColors.blackColor,
            )),
        CustomCircleButton(
            width: 40,
            height: 40,
            child: CustomIconButton(
              onPressed: routerPush(
                  context: context, page: const BookMarkMain(folderCnt: 4)),
              icon: bookMarkIcon,
              color: CustomColors.blackColor,
            )),
      ],
    );
  }
}
