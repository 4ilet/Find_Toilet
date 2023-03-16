import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String? font;
  final FontSize fontSize;
  final CustomColors color;
  final bool isBoldText;
  const CustomText({
    super.key,
    required this.title,
    this.fontSize = FontSize.defaultSize,
    this.color = CustomColors.blackColor,
    this.font,
    this.isBoldText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: convertedColor(color),
        fontSize: convertedSize(fontSize),
        fontFamily: font,
        fontWeight: isBoldText ? FontWeight.bold : null,
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text, font;
  final FontSize fontSize;
  final CustomColors textColor, iconColor;
  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = FontSize.smallSize,
    this.iconColor = CustomColors.mainColor,
    this.textColor = CustomColors.blackColor,
    this.font = kimm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: convertedColor(iconColor)),
        const SizedBox(width: 10),
        CustomText(
          title: text,
          fontSize: fontSize,
          color: textColor,
          font: font,
        )
      ],
    );
  }
}
