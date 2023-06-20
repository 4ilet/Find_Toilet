import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  final int toiletId;
  final String toiletName;
  final double? preScore;
  final String? preComment;
  final int reviewId;
  const ReviewForm({
    super.key,
    required this.toiletName,
    required this.toiletId,
    this.preComment,
    this.preScore,
    required this.reviewId,
  });

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  DynamicMap reviewData = {'comment': '', 'score': 0.0};
  bool enabled = true;

  void initData() async {
    final data = await ReviewProvider().getReview(widget.reviewId);
    changeScore(data.score.toInt() - 1);
    changeComment(data.comment);
  }

  @override
  void initState() {
    super.initState();
    if (widget.reviewId != 0) {
      if (widget.preComment != null && widget.preScore != null) {
        reviewData['comment'] = widget.preComment!;
        reviewData['score'] = widget.preScore!;
      } else {
        initData();
      }
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
      if (enabled) {
        setState(() {
          enabled = false;
        });
        late final String state;
        if (widget.reviewId == 0) {
          await ReviewProvider().postNewReview(
            toiletId: widget.toiletId,
            reviewData: reviewData,
          );
          state = '등록';
        } else {
          await ReviewProvider().updateReview(
            widget.reviewId,
            reviewData: reviewData,
          );
          state = '수정';
        }
        if (!mounted) return;
        routerPop(context)();
        showModal(
          context,
          page: AlertModal(
            title: '리뷰 $state',
            content: '리뷰가 성공적으로\n $state되었습니다',
          ),
        );
      }
    } catch (error) {
      print(error);
      final state = widget.reviewId != 0 ? '수정' : '등록';
      showModal(
        context,
        page: AlertModal(
          title: '오류 발생',
          content: '오류가 발생해 \n리뷰가 $state되지 않았습니다.',
        ),
      );
      setState(() {
        enabled = true;
      });
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
                font: kimm,
              ),
            ),
            const Flexible(
              child: CustomText(
                title: '어떠셨나요?',
                color: CustomColors.whiteColor,
              ),
            ),
            Flexible(
              flex: 2,
              child: reviewScore(),
            ),
            Flexible(
              flex: 5,
              child: CustomTextField(
                initValue: reviewData['comment'],
                onChanged: changeComment,
                maxLines: 5,
                height: 200,
                textHeight: 1.5,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
              ),
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

  SizedBox reviewScore() {
    return SizedBox(
      width: screenWidth(context) * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 5; i += 1)
            Flexible(
              child: CustomIconButton(
                onPressed: () => changeScore(i),
                icon: starIcon,
                iconSize: 50,
                color: i < reviewData['score']
                    ? CustomColors.yellowColor
                    : CustomColors.whiteColor,
              ),
            ),
        ],
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
          buttonText: widget.reviewId != 0 ? '수정' : '등록',
          buttonColor: whiteColor,
        ),
      ],
    );
  }
}
