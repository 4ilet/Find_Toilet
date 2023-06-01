import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    context.read<SettingsProvider>().initOption(isLargeSize);
    removedRouterPush(context, page: const Main());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: Scaffold(
        backgroundColor: mainColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: Column(
                    children: const [
                      CustomText(
                        title: '어서오세요',
                        fontSize: FontSize.titleSize,
                        color: CustomColors.whiteColor,
                        font: kimm,
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        title: '사용하실 테마를 선택해주세요.',
                        color: CustomColors.whiteColor,
                        font: kimm,
                      ),
                    ],
                  )),
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
                  CustomButton(onPressed: applyTheme)
                ],
              ),
            ),
            watchPressed(context)
                ? const Center(
                    child: CustomBox(
                      height: 60,
                      width: 300,
                      color: whiteColor,
                      child: CustomText(
                        title: '뒤로 가기 버튼을 한 번 더 누르시면 앱이 종료됩니다',
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
