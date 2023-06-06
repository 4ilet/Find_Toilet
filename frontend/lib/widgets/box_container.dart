import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/review_form_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 테마 선택 시의 상자
class ThemeBox extends StatefulWidget {
  final String text;
  final bool selected;
  final ReturnVoid onTap;
  final FontSize fontSize;
  final String path;
  const ThemeBox({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    required this.path,
    this.fontSize = FontSize.defaultSize,
  });

  @override
  State<ThemeBox> createState() => _ThemeBoxState();
}

class _ThemeBoxState extends State<ThemeBox> {
  @override
  Widget build(BuildContext context) {
    return CustomBox(
      onTap: widget.onTap,
      height: screenHeight(context) * 0.3,
      width: screenWidth(context) * 0.8,
      color: whiteColor,
      boxShadow: widget.selected ? [redShadow] : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomBox(
            height: screenHeight(context) * 0.2,
            width: screenWidth(context) * 0.6,
            child: Image.asset(
              widget.path,
              fit: BoxFit.fitWidth,
            ),
          ),
          CustomText(
            title: widget.text,
            fontSize: widget.fontSize,
          )
        ],
      ),
    );
  }
}

//* 즐겨찾기 폴더
class FolderBox extends StatelessWidget {
  final FolderModel folderInfo;
  final bool add;
  const FolderBox({
    super.key,
    required this.folderInfo,
    this.add = false,
  });

  @override
  Widget build(BuildContext context) {
    String folderName = folderInfo.folderName;
    int bookmarkCnt = folderInfo.bookmarkCnt;
    int folderId = folderInfo.folderId;
    // String printedName = folderName.length <= 5
    //     ? folderName
    //     : '${folderName.substring(0, 5)}\n${folderName.substring(5)}';
    return CustomBox(
      onTap: routerPush(
        context,
        page: BookMarkList(
          folderName: folderName,
          bookmarkCnt: bookmarkCnt,
          folderId: folderId,
        ),
      ),
      height: 150,
      width: 150,
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomText(
                      title: folderName,
                      fontSize: FontSize.defaultSize,
                      color: CustomColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: '$bookmarkCnt 개',
                    fontSize: FontSize.smallSize,
                    color: CustomColors.blackColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        icon: editIcon,
                        color: CustomColors.mainColor,
                        onPressed: () => showModal(
                          context,
                          page: CreateOrEditFolderModal(
                            folderId: folderId,
                            folderName: folderName,
                          ),
                        ),
                        iconSize: 30,
                      ),
                      CustomIconButton(
                        icon: deleteIcon,
                        color: CustomColors.redColor,
                        onPressed: () => showModal(
                          context,
                          page: DeleteModal(
                            deleteMode: 1,
                            id: folderId,
                          ),
                        ),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//* 즐겨찾기 폴더 생성
class AddBox extends StatefulWidget {
  const AddBox({
    super.key,
  });

  @override
  State<AddBox> createState() => _AddBoxState();
}

class _AddBoxState extends State<AddBox> {
  @override
  Widget build(BuildContext context) {
    return CustomBox(
      onTap: () => showDialog(
        context: context,
        builder: (context) => const CreateOrEditFolderModal(),
      ),
      height: 150,
      width: 150,
      color: whiteColor,
      child: const Center(
        child: CustomIcon(
          icon: plusIcon,
          color: mainColor,
          size: 50,
        ),
      ),
    );
  }
}

//* 화장실, 리뷰 목록 아이템
class ListItem extends StatelessWidget {
  final ToiletModel data;
  final bool showReview;
  const ListItem({
    super.key,
    required this.data,
    required this.showReview,
  });

  @override
  Widget build(BuildContext context) {
    BoolList availableList = [
      data.can24hour,
      data.privateDiaper,
      data.privateDisabledM1 || data.privateDisabledM2 || data.privateDisabledF,
      data.privateChildF || data.privateChildM1 || data.privateChildM2
    ];

    bool existState() {
      for (int i = 0; i < 4; i += 1) {
        if (availableList[i]) return true;
      }
      return false;
    }

    String available(int limit) {
      StringList facilityList = [
        '24시간 이용',
        '장애인 전용',
        '유아 전용',
        '기저귀 교환대',
      ];
      String result = '';
      int length = 0;
      for (int i = 0; i < 4; i += 1) {
        if (availableList[i]) {
          final newLength = facilityList[i].length;
          if (length + newLength < limit) {
            result += '${facilityList[i]} ';
            length += newLength;
          } else {
            result += '\n${facilityList[i]} ';
            length = newLength;
          }
        }
      }
      return result;
    }

    void addOrEditReview() {
      final token = readToken(context);
      if (token != null && token != '') {
        routerPush(context,
            page: ReviewForm(
              toiletName: data.toiletName,
              toiletId: data.toiletId,
              reviewId: data.reviewId,
            ))();
      } else {
        showModal(context, page: const LoginConfirmModal()).then((_) {
          routerPop(context)();
        });
      }
    }

    void pressedHeart() {
      if (readToken(context) != null) {
        showModal(
          context,
          page: AddOrDeleteBookMarkModal(
            toiletId: data.toiletId,
            folderId: data.folderId,
          ),
        );
      } else {
        showModal(context, page: const LoginConfirmModal());
      }
    }

    // ReturnVoid pressedBox() {
    //   if (readToken(context) != null) {
    //     return routerPush(
    //       context,
    //       page: Main(
    //         showReview: true,
    //         toiletModel: data,
    //       ),
    //     );
    //   }
    //   return () {
    //     showModal(context, page: const LoginConfirmModal());
    //   };
    // }
    // print('height : ${screenHeight(context) * 0.33}');
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomBox(
        onTap: () => routerPush(
          context,
          page: Main(
            showReview: true,
            toiletModel: data,
          ),
        )(),
        color: whiteColor,
        // height: 200,
        // width: screenWidth(context) * 0.8,
        height: getFontSize(context) == '기본' ? 250 : 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // toiletTopInfo(context),
                  // for (int i = 0; i < 2; i += 1) toiletInfo(i),
                  Expanded(
                    flex: 2,
                    child: CustomText(
                      color: CustomColors.mainColor,
                      title: data.toiletName,
                      fontSize: FontSize.defaultSize,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: pressedHeart,
                          icon: CustomIcon(
                            icon: data.folderId.isNotEmpty
                                ? heartIcon
                                : emptyHeartIcon,
                            color: redColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => showModal(
                            context,
                            page: NavigationModal(
                              startPoint: const [37.537229, 127.005515],
                              endPoint: [data.lat, data.lng],
                              destination: data.toiletName,
                            ),
                          ),
                          icon: const CustomIcon(
                            icon: planeIcon,
                            color: Colors.lightBlue,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 17,
                    child: TextWithIcon(
                      icon: locationIcon,
                      text: data.address,
                      flex: data.phoneNo != '' ? 10 : 18,
                    ),
                  ),
                  data.phoneNo != ''
                      ? Flexible(
                          flex: 13,
                          child: TextWithIcon(
                            icon: phoneIcon,
                            text: data.phoneNo,
                            flex: 6,
                            gap: 7,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: TextWithIcon(
                      icon: clockIcon,
                      text: data.duration,
                      flex: 10,
                    ),
                  ),
                  Flexible(
                    child: TextWithIcon(
                      icon: starIcon,
                      text: '${data.score} (${data.commentCnt}개)',
                      iconColor: CustomColors.yellowColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    existState()
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomText(
                                title: '이용 가능 시설',
                                fontSize: FontSize.smallSize,
                                color: CustomColors.mainColor,
                                isBoldText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                title: available(15),
                                fontSize: FontSize.smallSize,
                                isCentered: true,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    CustomButton(
                      fontSize: FontSize.smallSize,
                      onPressed: addOrEditReview,
                      buttonText: data.reviewId == 0 ? '리뷰 남기기' : '리뷰 수정하기',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//* filter 상자
class FilterBox extends StatefulWidget {
  final ReturnVoid? onPressed;
  const FilterBox({
    super.key,
    this.onPressed,
  });

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  StringList filterList = ['기저귀', '유아용', '장애인', '24시간'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i += 1)
          CustomBox(
            onTap: () {
              setFilter(context, i);
              if (widget.onPressed != null) {
                widget.onPressed!();
              }
            },
            // width: 100,
            // height: 30,
            color: getFilter(context, i) ? mainColor : whiteColor,
            radius: 5,
            boxShadow: const [defaultShadow],
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: CustomText(
                  title: filterList[i],
                  font: kimm,
                  fontSize: FontSize.smallSize,
                  color: getFilter(context, i)
                      ? CustomColors.whiteColor
                      : CustomColors.blackColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

//* box 기본 틀
class CustomBox extends StatelessWidget {
  final ReturnVoid? onTap;
  final Widget child;
  final double? width, height;
  final Color? color;
  final double radius;
  final ShadowList? boxShadow;
  final BorderRadius? borderRadius;
  final Border? border;
  const CustomBox(
      {super.key,
      this.onTap,
      required this.child,
      this.width,
      this.height,
      this.color,
      this.radius = 10,
      this.boxShadow,
      this.borderRadius,
      this.border});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ??
              (radius != 0 ? BorderRadius.circular(radius) : null),
          boxShadow: boxShadow,
          border: border,
        ),
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

//* review 상자
class ReviewBox extends StatelessWidget {
  final String toiletName;
  final ReviewModel review;
  final int toiletId;
  const ReviewBox({
    super.key,
    required this.review,
    required this.toiletId,
    required this.toiletName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomBox(
        color: whiteColor,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          color: CustomColors.mainColor,
                          title: review.nickname,
                          fontSize: FontSize.smallSize,
                        ),
                        review.nickname ==
                                context.read<UserInfoProvider>().nickname
                            ? Row(
                                children: [
                                  CustomIconButton(
                                    color: CustomColors.mainColor,
                                    icon: editIcon,
                                    iconSize: 20,
                                    onPressed: () => routerPush(
                                      context,
                                      page: ReviewForm(
                                        toiletName: toiletName,
                                        toiletId: toiletId,
                                        reviewId: review.id,
                                        preComment: review.comment,
                                        preScore: review.score,
                                      ),
                                    ),
                                  ),
                                  CustomIconButton(
                                    color: CustomColors.redColor,
                                    icon: deleteIcon,
                                    iconSize: 20,
                                    onPressed: () => showModal(
                                      context,
                                      page: DeleteModal(
                                        deleteMode: 0,
                                        id: review.id,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextWithIcon(
                      icon: starIcon,
                      text: '${review.score}',
                      iconColor: CustomColors.yellowColor,
                    ),
                  ),
                ],
              ),
              CustomText(title: review.comment)
            ],
          ),
        ),
      ),
    );
  }
}

//* 성공 시 알림
class SuccessBox extends StatefulWidget {
  final String feature, page;
  const SuccessBox({
    super.key,
    required this.feature,
    required this.page,
  });

  @override
  State<SuccessBox> createState() => _SuccessBoxState();
}

class _SuccessBoxState extends State<SuccessBox> {
  bool isShown = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        routerPop(context)();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShown
        ? CustomBox(
            color: whiteColor,
            child: CustomText(
                title: '성공적으로 ${widget.page}가 ${widget.feature}되었습니다'))
        : const SizedBox();
  }
}

//* 실패 시 알림
class FailBox extends StatelessWidget {
  final String feature, page;
  final String? message;
  const FailBox({
    super.key,
    required this.feature,
    required this.page,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
        child:
            CustomText(title: message ?? '오류가 발생해 $page $feature 처리되지 않았습니다'));
  }
}
