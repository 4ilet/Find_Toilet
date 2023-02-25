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
  final double iconSize;
  final ReturnVoid onPressed;
  final CustomColors color;
  final IconData icon;
  const CustomIconButton({
    super.key,
    required this.color,
    required this.icon,
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

class CustomCircleButton extends StatelessWidget {
  final Color color;
  final bool shadow;
  final double width, height;
  final Widget child;

  const CustomCircleButton({
    super.key,
    this.color = whiteColor,
    this.shadow = true,
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
          boxShadow: shadow ? [defaultShadow] : null),
      width: width,
      height: height,
      child: child,
    );
  }
}
