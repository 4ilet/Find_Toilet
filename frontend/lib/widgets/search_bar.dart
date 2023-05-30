import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/book_mark_folder_screen.dart';
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

class SearchBar extends StatelessWidget {
  final bool isMain;
  final String query;
  final Function(String value) onChange;
  final ReturnVoid onSearchAction;
  const SearchBar({
    super.key,
    required this.isMain,
    required this.onChange,
    required this.onSearchAction,
    this.query = '',
  });

  @override
  Widget build(BuildContext context) {
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
            onChanged: onChange,
            controller: TextEditingController(text: query),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  '검색어를 입력하세요${context.watch<ApplyChangeProvider>().refresh.trim()}',
              prefixIcon: CustomIconButton(
                icon: hamburgerIcon,
                onPressed: routerPush(context, page: const Settings()),
                color: CustomColors.blackColor,
              ),
              suffixIcon: query != ''
                  ? CustomIconButton(
                      icon: closeIcon,
                      onPressed: () => onChange(''),
                      // onPressed: routerPush(context, page: const Main()),
                      color: CustomColors.blackColor,
                    )
                  : null,
            ),
          ),
        ),
        CustomCircleButton(
          width: 40,
          height: 40,
          child: CustomIconButton(
            onPressed: onSearchAction,
            icon: searchIcon,
            color: CustomColors.blackColor,
          ),
        ),
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
    );
  }
}
