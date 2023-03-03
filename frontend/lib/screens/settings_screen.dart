import 'package:find_toilet/utilities/global_func.dart';
import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ReturnVoid changeIndex(int i) {
    return () {
      if (i < 3) {
        if (indexList[i] < optionList[i].length - 1) {
          setState(() {
            indexList[i] += 1;
          });
        } else {
          setState(() {
            indexList[i] = 0;
          });
        }
      }
    };
  }

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
                for (int i = 0; i < 3; i += 1)
                  GestureDetector(
                    onTap: changeIndex(i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWithIcon(
                            icon: iconList[i],
                            text: menuList[i],
                            iconColor: CustomColors.blackColor,
                            fontSize: FontSize.defaultSize,
                          ),
                          i < 2
                              ? CustomText(
                                  title: optionList[i][indexList[i]],
                                  fontSize: FontSize.defaultSize,
                                  color: CustomColors.mainColor,
                                )
                              : Row(
                                  children: [
                                    const CustomIcon(
                                      icon: toLeftIcon,
                                      color: mainColor,
                                    ),
                                    CustomText(
                                      title: optionList[i][indexList[i]],
                                      fontSize: FontSize.defaultSize,
                                      color: CustomColors.mainColor,
                                    ),
                                    const CustomIcon(
                                      icon: toRightIcon,
                                      color: mainColor,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                for (int i = 3; i < 7; i += 1)
                  GestureDetector(
                    onTap: showModal(
                      context: context,
                      page: HelpModal(
                        title: menuList[i],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextWithIcon(
                        icon: iconList[i],
                        text: menuList[i],
                        iconColor: CustomColors.blackColor,
                        fontSize: FontSize.defaultSize,
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ExitPage(color: CustomColors.blackColor),
              ],
            )
          ],
        ),
      ),
    );
  }
}
