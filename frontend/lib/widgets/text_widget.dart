import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String? font;
  final FontSize fontSize;
  final CustomColors color;
  final bool isBoldText, isCentered;
  const CustomText({
    super.key,
    required this.title,
    this.fontSize = FontSize.defaultSize,
    this.color = CustomColors.blackColor,
    this.font,
    this.isBoldText = false,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: isCentered ? TextAlign.center : null,
      style: TextStyle(
        color: convertedColor(color),
        fontSize: convertedSize(fontSize),
        fontFamily: font,
        fontWeight: isBoldText ? FontWeight.bold : null,
      ),
      // overflow: TextOverflow.ellipsis,
      // maxLines: 3,
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? font;
  final FontSize fontSize;
  final CustomColors textColor, iconColor;
  final int flex;
  final MainAxisAlignment mainAxisAlignment;
  final double gap;
  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = FontSize.smallSize,
    this.iconColor = CustomColors.mainColor,
    this.textColor = CustomColors.blackColor,
    this.font,
    this.flex = 4,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.gap = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: Icon(
            icon,
            color: convertedColor(iconColor),
          ),
        ),
        Flexible(child: SizedBox(width: gap)),
        Flexible(
          flex: flex,
          fit: FlexFit.loose,
          child: CustomText(
            title: text,
            fontSize: fontSize,
            color: textColor,
            font: font,
          ),
        )
      ],
    );
  }
}
