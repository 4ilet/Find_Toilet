import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final ReturnVoid onPressed;
  final String buttonText;
  const CustomButton(
      {super.key, required this.onPressed, this.buttonText = '완료'});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}

class ExitPage extends StatelessWidget {
  final CustomColors color;
  const ExitPage({super.key, this.color = CustomColors.whiteColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          CustomText(
            title: '나가기',
            fontSize: FontSize.largeSize,
            color: color,
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 40,
            color: convertedColor(color),
          )
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final double iconSize;
  final ReturnVoid onPressed;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: icon,
      iconSize: iconSize,
    );
  }
}
