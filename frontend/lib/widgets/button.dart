import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* 버튼
class CustomButton extends StatelessWidget {
  final ReturnVoid onPressed;
  final String buttonText;
  final CustomColors textColor;
  final Color? buttonColor;
  final FontSize fontSize;
  final String font;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.buttonText = '완료',
    this.textColor = CustomColors.mainColor,
    this.buttonColor = whiteColor,
    this.fontSize = FontSize.defaultSize,
    this.font = 'Kimm',
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
      child: CustomText(
        title: buttonText,
        color: textColor,
        fontSize: fontSize,
        font: font,
      ),
    );
  }
}

//* 나가기 버튼
class ExitPage extends StatelessWidget {
  final CustomColors color;
  const ExitPage({super.key, this.color = CustomColors.whiteColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: routerPop(context),
      child: Row(
        children: [
          CustomText(
            title: '나가기',
            fontSize: getThemeState(context) == '기본'
                ? FontSize.largeSize
                : FontSize.largeLargeSize,
            color: color,
            applyTheme: false,
          ),
          CustomIcon(
            icon: exitIcon,
            size: 40,
            color: convertedColor(color),
          )
        ],
      ),
    );
  }
}

//* 아이콘 버튼
class CustomIconButton extends StatelessWidget {
  final double iconSize;
  final ReturnVoid onPressed;
  final CustomColors color;
  final IconData icon;
  const CustomIconButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onPressed,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      iconSize: iconSize,
      icon: CustomIcon(
        icon: icon,
        color: convertedColor(color),
        size: iconSize,
      ),
    );
  }
}

//* 원으로 감싸진 버튼
class CustomCircleButton extends StatelessWidget {
  final Color color;
  final bool shadow, hasBorder;
  final double width, height;
  final Widget child;

  const CustomCircleButton({
    super.key,
    this.color = whiteColor,
    this.shadow = true,
    this.hasBorder = false,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: shadow ? [defaultShadow] : null,
        border: hasBorder ? Border.all(color: mainColor) : null,
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
