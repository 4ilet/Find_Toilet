import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? initValue, hintText;
  final void Function(String)? onChanged, onSubmitted;
  final int maxLines;
  final double width, height, radius;
  final Widget? prefixIcon, suffixIcon;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final bool searchMode;
  const CustomTextField({
    super.key,
    this.initValue,
    required this.onChanged,
    this.maxLines = 1,
    this.width = 350,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 40,
    this.boxShadow,
    this.radius = 5,
    this.padding = const EdgeInsetsDirectional.all(30),
    this.onSubmitted,
    this.searchMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      width: width,
      height: getFontSize(context) == '기본' ? height : height * 1.2,
      radius: radius,
      color: whiteColor,
      boxShadow: boxShadow,
      child: Padding(
        padding: padding,
        child: TextField(
          controller: TextEditingController(text: initValue),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          maxLines: 5,
          style: TextStyle(
            fontSize:
                getFontSize(context) == '기본' ? defaultSize : defaultSize + 3,
            height: 1,
          ),
          textInputAction: searchMode ? TextInputAction.search : null,
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String title;
  final String? font;
  final FontSize fontSize;
  final CustomColors color;
  final bool isBoldText, isCentered, applyTheme;
  const CustomText({
    super.key,
    required this.title,
    this.fontSize = FontSize.defaultSize,
    this.color = CustomColors.blackColor,
    this.font,
    this.isBoldText = false,
    this.isCentered = false,
    this.applyTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: isCentered ? TextAlign.center : null,
      style: TextStyle(
        color: convertedColor(color),
        fontSize: convertedSize(
          applyTheme ? applyDefaultTheme(context, fontSize) : fontSize,
        ),
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
