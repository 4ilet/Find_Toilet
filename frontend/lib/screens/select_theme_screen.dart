import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:flutter/material.dart';

class SelectFontTheme extends StatelessWidget {
  const SelectFontTheme({super.key});

  @override
  Widget build(BuildContext context) {
    void toMain() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Main()));
    }

    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: WhiteText(title: '어서오세요', fontSize: FontSize.titleSize)),
          const SizedBox(height: 15),
          const WhiteText(
            title: '사용하실 테마를 선택해주세요.',
            fontSize: FontSize.defaultSize,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ThemeBox(text: '큰 글씨'),
              ThemeBox(text: '기본'),
            ],
          ),
          CustomButton(
            onPressed: toMain,
          )
        ],
      ),
    );
  }
}
