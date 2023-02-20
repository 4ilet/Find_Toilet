import 'package:find_toilet/utilities/icon.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  @override
  Widget build(BuildContext context) {
    int score = -1;
    void changeScore(int i) {
      // print(i);
      // setState() {
      score = i;
      // }
    }

    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CustomText(
                title: '광주시립도서관화장실',
                fontSize: FontSize.largeSize,
                color: CustomColors.whiteColor),
            const CustomText(
                title: '어떠셨나요?',
                fontSize: FontSize.defaultSize,
                color: CustomColors.whiteColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i += 1)
                  IconButton(
                    onPressed: () => changeScore(i),
                    icon: Icon(
                      starIcon,
                      color: i <= score ? yellowColor : whiteColor,
                      size: 40,
                    ),
                  ),
              ],
            ),
            Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: whiteColor),
              child: const TextField(maxLines: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonText: '취소'),
                CustomButton(onPressed: () {}, buttonText: '등록'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
