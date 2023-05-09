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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool isMain;
  final String? query;
  const SearchBar({super.key, required this.isMain, this.query});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final StringMap input = {};
  @override
  void initState() {
    super.initState();
    input['value'] = widget.query ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 100),
        CustomBox(
          width: 270,
          height: 40,
          boxShadow: const [defaultShadow],
          color: whiteColor,
          radius: 5,
          child: TextField(
            onChanged: (value) => input['value'] = value,
            controller: widget.isMain
                ? null
                : TextEditingController(text: input['value']),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  '검색어를 입력하세요${context.watch<ApplyChangeProvider>().refresh.trim()}',
              prefixIcon: CustomIconButton(
                icon: hamburgerIcon,
                onPressed: routerPush(context, page: const Settings()),
                color: CustomColors.blackColor,
              ),
              suffixIcon: CustomIconButton(
                icon: closeIcon,
                onPressed: routerPush(context, page: const Main()),
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
                context,
                page: const Search(query: '광주'),
              ),
              icon: searchIcon,
              color: CustomColors.blackColor,
            )),
        CustomCircleButton(
          width: 40,
          height: 40,
          child: CustomIconButton(
            onPressed: getToken(context) != null
                ? routerPush(context, page: const BookMarkFolderList())
                : () => showModal(context, page: const LoginConfirmModal()),
            icon: bookMarkIcon,
            color: CustomColors.blackColor,
          ),
        ),
      ],
    );
  }
}
