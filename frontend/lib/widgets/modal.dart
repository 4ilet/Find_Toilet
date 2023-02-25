import 'package:find_toilet/utilities/global_func.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NavigationModal extends StatelessWidget {
  const NavigationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CloseButton(),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CustomText(
                  title: '네비게이션 켜기',
                  fontSize: FontSize.largeSize,
                  color: CustomColors.mainColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(naverMap),
                    const CustomText(
                      title: '네이버맵',
                      fontSize: FontSize.defaultSize,
                      color: CustomColors.blackColor,
                      font: notoSans,
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset(kakaoMap),
                    const CustomText(
                      title: '카카오맵',
                      fontSize: FontSize.defaultSize,
                      color: CustomColors.blackColor,
                      font: notoSans,
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset(tMap),
                    const CustomText(
                      title: 'T맵',
                      fontSize: FontSize.defaultSize,
                      color: CustomColors.blackColor,
                      font: notoSans,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HelpModal extends StatelessWidget {
  const HelpModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: CustomText(
        title: '도움말',
        fontSize: FontSize.largeSize,
        color: CustomColors.blackColor,
      ),
    );
  }
}

class InputModal extends StatelessWidget {
  final String title;
  const InputModal({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: CustomText(
            title: title,
            fontSize: FontSize.defaultSize,
            color: CustomColors.blackColor),
        children: [
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  onPressed: () => routerPop(context: context),
                  buttonText: '수정'),
              CustomButton(
                  onPressed: () => routerPop(context: context),
                  buttonText: '취소')
            ],
          ),
        ]);
  }
}

class CustomModal extends StatelessWidget {
  const CustomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog();
  }
}
