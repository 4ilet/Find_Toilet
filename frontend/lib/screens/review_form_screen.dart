import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  final int toiletId;
  final String toiletName;
  final double? preScore;
  final String? preComment;
  final int? reviewId;
  const ReviewForm({
    super.key,
    required this.toiletName,
    required this.toiletId,
    this.preComment,
    this.preScore,
    this.reviewId,
  });

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  DynamicMap reviewData = {'comment': '', 'score': 0.0};

  @override
  void initState() {
    super.initState();
    if (widget.preComment != null) {
      reviewData['comment'] = widget.preComment!;
    }
    if (widget.preScore != null) {
      reviewData['score'] = widget.preScore!;
    }
  }

  void changeScore(int i) {
    setState(() {
      reviewData['score'] = (i + 1).toDouble();
    });
  }

  void changeComment(String comment) => reviewData['comment'] = comment;
  void addOrEditReview() async {
    try {
      if (widget.reviewId != null) {
        await ReviewProvider.postNewReview(
          memberId: memberId,
          toiletId: widget.toiletId,
          reviewData: reviewData,
        );
      } else {
        await ReviewProvider.updateReview(
          reviewId: widget.reviewId!,
          reviewData: reviewData,
        );
      }
    } catch (error) {
      final state = widget.reviewId != null ? '수정' : '등록';
      showModal(
        context,
        page: ErrorModal(
          content: '오류가 발생해 \n리뷰가 $state되지 않았습니다.',
        ),
      )();
    }
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
                color: CustomColors.whiteColor,
              ),
            ),
            const Flexible(
              child: CustomText(
                title: '어떠셨나요?',
                fontSize: FontSize.defaultSize,
                color: CustomColors.whiteColor,
              ),
            ),
            Flexible(
              flex: 2,
              child: reviewScore(),
            ),
            Flexible(
              flex: 5,
              child: reviewInput(),
            ),
            Flexible(
              flex: 3,
              child: reviewButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  Padding reviewScore() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 5; i += 1)
            CustomIconButton(
              onPressed: () => changeScore(i),
              icon: starIcon,
              iconSize: 50,
              color: i < reviewData['score']
                  ? CustomColors.yellowColor
                  : CustomColors.whiteColor,
            ),
        ],
      ),
    );
  }

  CustomBox reviewInput() {
    return CustomBox(
      width: 350,
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: TextField(
          controller: TextEditingController(text: widget.preComment),
          onChanged: changeComment,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          maxLines: 5,
          style: const TextStyle(
            fontSize: defaultSize,
          ),
        ),
      ),
    );
  }

  Row reviewButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          onPressed: routerPop(context),
          buttonText: '취소',
          buttonColor: whiteColor,
        ),
        CustomButton(
          onPressed: addOrEditReview,
          buttonText: '등록',
          buttonColor: whiteColor,
        ),
      ],
    );
  }
}
