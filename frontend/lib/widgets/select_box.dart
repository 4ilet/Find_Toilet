import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatelessWidget {
  final double width, height;
  final ReturnVoid onTap;
  final bool showList;
  final String value;
  const SelectBox({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.showList,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      onTap: onTap,
      width: width,
      height: height,
      color: whiteColor,
      radius: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: value,
              fontSize: FontSize.smallSize,
            ),
            const CustomIcon(icon: toDownIcon)
          ],
        ),
      ),
    );
  }
}
