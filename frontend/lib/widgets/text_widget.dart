import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final FontSize fontSize;
  final CustomColors color;
  const CustomText(
      {super.key,
      required this.title,
      required this.fontSize,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: convertedColor(color),
        fontSize: convertedSize(fontSize),
      ),
    );
  }
}
