import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final ReturnVoid onPressed;
  const CustomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: const Text(
        '완료',
      ),
    );
  }
}

class ExitPage extends StatelessWidget {
  const ExitPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: const [
          CustomText(
            title: '나가기',
            fontSize: FontSize.largeSize,
            color: CustomColors.whiteColor,
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 40,
            color: whiteColor,
          )
        ],
      ),
    );
  }
}
