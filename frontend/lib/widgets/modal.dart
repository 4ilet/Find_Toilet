import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NavigationModal extends StatelessWidget {
  const NavigationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                CloseButton(),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CustomText(
                  title: '네비게이션 켜기',
                  fontSize: FontSize.largeSize,
                  color: CustomColors.mainColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [Text('네이버맵')],
                ),
                Column(
                  children: const [Text('카카오맵')],
                ),
                Column(
                  children: const [Text('T맵')],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
