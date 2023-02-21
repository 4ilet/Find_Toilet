import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/search_screen.dart';
import 'package:find_toilet/screens/settings_screen.dart';
import 'package:find_toilet/utilities/icon.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
  });

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
          context, MaterialPageRoute(builder: (context) => const Search()));
    }

    void toMain() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Main()));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        // IconButton(onPressed: toSettings, icon: const Icon(hamburgerIcon)),
        SizedBox(
          width: 250,
          height: 40,
          child: TextField(
            // autofocus: false,
            decoration: InputDecoration(
                // icon: Icon(searchIcon),
                hintText: '검색어를 입력하세요',
                focusedBorder: const OutlineInputBorder(),
                focusColor: mainColor,
                prefixIcon: IconButton(
                    onPressed: toSettings, icon: const Icon(hamburgerIcon)),
                suffixIcon: IconButton(
                  icon: const Icon(closeIcon),
                  onPressed: toMain,
                )),
          ),
        ),
        // const TextField(maxLines: 1),
        IconButton(onPressed: toSearch, icon: const Icon(searchIcon)),
        IconButton(onPressed: toBookMark, icon: const Icon(bookMarkIcon))
      ],
    );
  }
}
