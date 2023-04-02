import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SelectFontTheme extends StatefulWidget {
  const SelectFontTheme({super.key});

  @override
  State<SelectFontTheme> createState() => _SelectFontThemeState();
}

class _SelectFontThemeState extends State<SelectFontTheme> {
  Themes selected = Themes.largeFont;
  bool isLarge = true;

  ReturnVoid changeTheme(bool isLargeTheme) {
    return () {
      setState(() {
        if (isLarge != isLargeTheme) {
          selected = isLargeTheme ? Themes.largeFont : Themes.defaultFont;
          isLarge = !isLarge;
        }
      });
    };
  }

  void applyTheme() {
    theme = selected;
    isFirstVisit = false;
    setVisited();
    routerPush(context, page: const Main())();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: CustomText(
            title: '어서오세요',
            fontSize: FontSize.titleSize,
            color: CustomColors.whiteColor,
          )),
          const CustomText(
            title: '사용하실 테마를 선택해주세요.',
            color: CustomColors.whiteColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThemeBox(
                text: '큰 글씨',
                selected: isLarge,
                onTap: changeTheme(true),
              ),
              ThemeBox(
                text: '기본',
                selected: !isLarge,
                onTap: changeTheme(false),
              ),
            ],
          ),
          CustomButton(onPressed: applyTheme)
        ],
      ),
    );
  }
}
