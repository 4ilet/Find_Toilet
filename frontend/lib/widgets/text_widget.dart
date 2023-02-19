import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title, font;
  final FontSize fontSize;
  final CustomColors color;
  const CustomText(
      {super.key,
      required this.title,
      required this.fontSize,
      required this.color,
      this.font = 'Kimm'});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: convertedColor(color),
          fontSize: convertedSize(fontSize),
          fontFamily: font),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text, font;
  final FontSize fontSize;
  final Color iconColor;
  final CustomColors textColor;
  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = FontSize.smallSize,
    this.iconColor = mainColor,
    this.textColor = CustomColors.blackColor,
    this.font = 'Kimm',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
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
