import 'package:find_toilet/utilities/global_func.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  final String toiletName;
  const ReviewForm({super.key, required this.toiletName});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int score = -1;
  void changeScore(int i) {
    setState(() {
      score = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child: CustomText(
                  title: widget.toiletName,
                  fontSize: FontSize.largeSize,
                  color: CustomColors.whiteColor),
            ),
            const Flexible(
              child: CustomText(
                title: '어떠셨나요?',
                fontSize: FontSize.defaultSize,
                color: CustomColors.whiteColor,
                font: notoSans,
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < 5; i += 1)
                      CustomIconButton(
                        onPressed: () => changeScore(i),
                        icon: starIcon,
                        iconSize: 50,
                        color: i <= score
                            ? CustomColors.yellowColor
                            : CustomColors.whiteColor,
                      ),
                  ],
                ),
              ),
            ),
            const Flexible(
              flex: 5,
              child: CustomBox(
                width: 350,
                color: whiteColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 10,
                    style: TextStyle(
                      fontFamily: notoSans,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onPressed: routerPop(context: context),
                    buttonText: '취소',
                    buttonColor: whiteColor,
                  ),
                  CustomButton(
                    onPressed: () {},
                    buttonText: '등록',
                    buttonColor: whiteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
