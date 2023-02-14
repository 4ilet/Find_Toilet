import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:flutter/material.dart';

class SelectFontTheme extends StatelessWidget {
  const SelectFontTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: commonTitle('어서오세요')),
          commonTitle('사용하실 테마를 선택해주세요.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ThemeBox(),
              ThemeBox(),
            ],
          ),
          const CustomButton()
        ],
      ),
    );
  }
}
