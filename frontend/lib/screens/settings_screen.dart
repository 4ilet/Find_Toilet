import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/icondata.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TextWithIcon(
                icon: personIcon,
                text: '로그인',
                iconColor: CustomColors.blackColor,
                fontSize: FontSize.defaultSize,
              ),
            ],
          ),
          const Center(
            child: CustomText(
              title: '어떤 것을 원하시나요?',
              fontSize: FontSize.largeSize,
              color: CustomColors.mainColor,
            ),
          ),
          Column(
            children: [
              for (int i = 0; i < 7; i += 1)
                GestureDetector(
                  // onTap: funcList[i],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextWithIcon(
                      icon: iconList[i],
                      text: menuList[i],
                      iconColor: CustomColors.blackColor,
                      fontSize: FontSize.defaultSize,
                    ),
                  ),
                )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              ExitPage(
                color: CustomColors.blackColor,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
