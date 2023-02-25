import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/search_screen.dart';
import 'package:find_toilet/screens/settings_screen.dart';
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
    void toBookMark() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BookMarkMain(folderCnt: 4)));
    }

    void toSettings() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Settings()));
    }

    void toSearch() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Search(
                    query: '광주',
                  )));
    }

    void toMain() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Main()));
    }

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
            style: const TextStyle(fontFamily: 'Noto Sans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색어를 입력하세요',
              prefixIcon: CustomIconButton(
                icon: hamburgerIcon,
                iconSize: 30,
                onPressed: toSettings,
                color: CustomColors.blackColor,
              ),
              suffixIcon: CustomIconButton(
                icon: closeIcon,
                iconSize: 30,
                onPressed: toMain,
                color: CustomColors.blackColor,
              ),
            ),
          ),
        ),
        CustomCircleButton(
            width: 40,
            height: 40,
            child: CustomIconButton(
              onPressed: toSearch,
              icon: searchIcon,
              iconSize: 30,
              color: CustomColors.blackColor,
            )),
        CustomCircleButton(
            width: 40,
            height: 40,
            child: CustomIconButton(
              onPressed: toBookMark,
              icon: bookMarkIcon,
              iconSize: 30,
              color: CustomColors.blackColor,
            )),
      ],
    );
  }
}
