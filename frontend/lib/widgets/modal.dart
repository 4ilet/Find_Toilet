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
    const StringList appList = ['네이버맵', '카카오맵', 'T맵'];
    List<Image> imgList = [
      Image.asset(naverMap),
      Image.asset(naverMap),
      Image.asset(tMap)
    ];
    return CustomModalWithClose(title: '네비게이션 켜기', children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 3; i += 1)
            Column(
              children: [
                imgList[i],
                CustomText(
                  title: appList[i],
                  fontSize: FontSize.defaultSize,
                  color: CustomColors.blackColor,
                  font: notoSans,
                )
              ],
            ),
        ],
      ),
    ]);
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
  final String title, buttonText;
  const InputModal({
    super.key,
    required this.title,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: title,
      buttonText: buttonText,
      children: const [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextField(),
        )),
      ],
    );
  }
}

class CustomModal extends StatelessWidget {
  final String title, buttonText;
  final WidgetList children;
  final CustomColors titleColor;
  final bool onlyOne;
  final ReturnVoid? onPressed;
  const CustomModal({
    super.key,
    required this.title,
    required this.children,
    this.titleColor = CustomColors.blackColor,
    this.onlyOne = false,
    this.buttonText = '확인',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CustomText(
              title: title, fontSize: FontSize.largeSize, color: titleColor),
        ),
        children: [
          ...children,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  onPressed: onPressed ?? () => routerPop(context: context),
                  buttonText: buttonText),
              onlyOne
                  ? const SizedBox()
                  : CustomButton(
                      onPressed: () => routerPop(context: context),
                      buttonText: '취소')
            ],
          ),
        ]);
  }
}

class CustomModalWithClose extends StatelessWidget {
  final String title;
  final WidgetList children;
  final CustomColors titleColor;
  const CustomModalWithClose({
    super.key,
    required this.title,
    required this.children,
    this.titleColor = CustomColors.mainColor,
  });

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomText(
                  title: title,
                  fontSize: FontSize.largeSize,
                  color: titleColor),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomModal(title: '폴더 삭제 확인', children: [
      CustomText(
          title: '폴더 삭제 시 내부의 즐겨찾기도 모두 삭제됩니다. 그래도 삭제하시겠습니까?',
          fontSize: FontSize.defaultSize,
          color: CustomColors.blackColor),
    ]);
  }
}
