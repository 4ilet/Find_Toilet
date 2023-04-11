import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
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
  bool isLargeSize = true;

  ReturnVoid changeFontSize(bool isLargeTheme) {
    return () {
      setState(() {
        if (isLargeSize != isLargeTheme) {
          isLargeSize = isLargeTheme;
        }
      });
    };
  }

  void applyTheme() {
    applyFontSize(context, isLargeSize);
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
            font: kimm,
          )),
          const CustomText(
            title: '사용하실 테마를 선택해주세요.',
            color: CustomColors.whiteColor,
            font: kimm,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThemeBox(
                text: '큰 글씨',
                selected: isLargeSize,
                onTap: changeFontSize(true),
              ),
              ThemeBox(
                text: '기본',
                selected: !isLargeSize,
                onTap: changeFontSize(false),
              ),
            ],
          ),
          CustomButton(onPressed: applyTheme)
        ],
      ),
    );
  }
}
