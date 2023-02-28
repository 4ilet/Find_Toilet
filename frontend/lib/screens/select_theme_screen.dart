import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_func.dart';
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
  @override
  Widget build(BuildContext context) {
    Themes selected = Themes.largeFont;
    Themes defaultFont = Themes.defaultFont;
    Themes largeFont = Themes.largeFont;

    void changeTheme(Themes fontSize) {
      if (fontSize == Themes.defaultFont) {
        setState(() {
          selected = Themes.defaultFont;
        });
      } else {
        setState(() {
          selected = Themes.largeFont;
        });
      }
    }

    bool isLarge() => selected == largeFont;
    bool isDefault() => selected == defaultFont;

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
          const SizedBox(height: 15),
          const CustomText(
            title: '사용하실 테마를 선택해주세요.',
            fontSize: FontSize.defaultSize,
            color: CustomColors.whiteColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: ThemeBox(text: '큰 글씨', selected: isLarge()),
                onTap: () => changeTheme(largeFont),
              ),
              GestureDetector(
                child: ThemeBox(text: '기본', selected: isDefault()),
                onTap: () => changeTheme(defaultFont),
              ),
            ],
          ),
          CustomButton(
              onPressed: routerPush(context: context, page: const Main()))
        ],
      ),
    );
  }
}
