import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
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

//* 테마 선택 시의 상자
class ThemeBox extends StatefulWidget {
  final String text;
  final bool selected, isLarge;
  final ReturnVoid onTap;
  final FontSize fontSize;
  const ThemeBox({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    required this.isLarge,
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
              child: CustomBox(
                color: mainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      title: '제목',
                      color: CustomColors.whiteColor,
                      fontSize: widget.isLarge
                          ? FontSize.largeDefaultSize
                          : FontSize.defaultSize,
                      applyTheme: false,
                    ),
                    CustomText(
                      title: '내용',
                      color: CustomColors.whiteColor,
                      fontSize: widget.isLarge
                          ? FontSize.largeSmallSize
                          : FontSize.smallSize,
                      applyTheme: false,
                    ),
                    CustomText(
                      title: '제목',
                      font: kimm,
                      fontSize: widget.isLarge
                          ? FontSize.largeDefaultSize
                          : FontSize.defaultSize,
                      color: CustomColors.whiteColor,
                      applyTheme: false,
                    ),
                    CustomText(
                      title: '내용',
                      font: kimm,
                      fontSize: widget.isLarge
                          ? FontSize.largeSmallSize
                          : FontSize.smallSize,
                      color: CustomColors.whiteColor,
                      applyTheme: false,
                    )
                  ],
                ),
              )),
          CustomText(
            title: widget.text,
            fontSize: widget.fontSize,
            font: kimm,
          )
        ],
      ),
    );
  }
}

//* 즐겨찾기 폴더
class FolderBox extends StatelessWidget {
  final FolderModel folderInfo;
  final bool add, onlyOne;

  const FolderBox({
    super.key,
    required this.folderInfo,
    this.add = false,
    this.onlyOne = false,
  });

  @override
  Widget build(BuildContext context) {
    String folderName = folderInfo.folderName;
    int bookmarkCnt = folderInfo.bookmarkCnt;
    int folderId = folderInfo.folderId;
    return CustomBox(
      onTap: routerPush(
        context,
        page: BookMarkList(
          folderName: folderName,
          bookmarkCnt: bookmarkCnt,
          folderId: folderId,
        ),
      ),
      height: screenWidth(context) * 0.42,
      width: screenWidth(context) * 0.42,
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomText(
                      title: folderName,
                      fontSize: FontSize.defaultSize,
                      color: CustomColors.mainColor,
                      font: kimm,
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
                        // iconSize: 30,
                      ),
                      onlyOne
                          ? const SizedBox()
                          : CustomIconButton(
                              icon: deleteIcon,
                              color: CustomColors.redColor,
                              onPressed: () => showModal(
                                context,
                                page: DeleteModal(
                                  deleteMode: 1,
                                  id: folderId,
                                ),
                              ),
                              // iconSize: 30,
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
      height: screenWidth(context) * 0.42,
      width: screenWidth(context) * 0.42,
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
  final bool isMain, showReview;
  final ToiletModel? toiletModel;
  final ReturnVoid refreshPage;
  final int? index;

  const ListItem({
    super.key,
    this.toiletModel,
    required this.isMain,
    required this.showReview,
    required this.refreshPage,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final boxKey = GlobalKey();
    ToiletModel data = toiletModel ?? getToilet(context)!;
    BoolList availableList = [
      data.can24hour,
      data.privateDisabledM1 || data.privateDisabledM2 || data.privateDisabledF,
      data.privateChildF || data.privateChildM1 || data.privateChildM2,
      data.privateDiaper,
    ];

    StringList facilityList = [
      '• 24시간 이용',
      '• 장애인 전용',
      '• 유아 전용',
      '• 기저귀 교환대',
    ];

    bool existState() {
      for (int i = 0; i < 4; i += 1) {
        if (availableList[i]) return true;
      }
      return false;
    }

    String available(int limit) {
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
              showReview: showReview,
              afterWork: refreshPage,
            ))();
      } else {
        showModal(
          context,
          page: hideModal(context)
              ? LoginConfirmModal(
                  showReview: showReview,
                  toiletId: data.toiletId,
                  isMain: isMain,
                  afterLogin: refreshPage,
                )
              : JoinModal(
                  showReview: false,
                  refreshPage: refreshPage,
                ),
        );
      }
    }

    void pressedHeart() {
      final token = readToken(context);
      if (token != null && token != '') {
        showModal(
          context,
          page: AddOrDeleteBookMarkModal(
            toiletId: data.toiletId,
            folderId: data.folderId,
            afterWork: refreshPage,
          ),
        );
      } else {
        showModal(
          context,
          page: hideModal(context)
              ? LoginConfirmModal(
                  showReview: showReview,
                  toiletId: data.toiletId,
                  isMain: isMain,
                  afterLogin: refreshPage,
                )
              : JoinModal(
                  showReview: false,
                  refreshPage: refreshPage,
                ),
        );
      }
    }

    void toReview() {
      if (!showReview) {
        setItemHeight(context, index!);
        setToilet(context, data);
        routerPush(
          context,
          page: Main(
            showReview: true,
            refreshPage: refreshPage,
            needNear: isMain,
          ),
        )();
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index != null && !showReview && getHeight(context, index!) == 0) {
        if (boxKey.currentContext != null) {
          final renderBox =
              boxKey.currentContext!.findRenderObject() as RenderBox;
          setHeight(context, index!, renderBox.size.height);
        }
      }
    });

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CustomBox(
          key: boxKey,
          onTap: toReview,
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: pressedHeart,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  constraints: const BoxConstraints(),
                                  icon: CustomIcon(
                                    icon: getToken(context) != null &&
                                            data.folderId.isNotEmpty
                                        ? heartIcon
                                        : emptyHeartIcon,
                                    color: redColor,
                                  ),
                                ),
                                getToken(context) != null &&
                                        data.folderId.isNotEmpty
                                    ? GestureDetector(
                                        onTap: pressedHeart,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 10, 0, 0),
                                          child: CustomCircleButton(
                                            width: 20,
                                            height: 20,
                                            shadow: true,
                                            hasBorder: true,
                                            child: Center(
                                              child: CustomText(
                                                title:
                                                    '${data.folderId.length}',
                                                fontSize: FontSize.smallSize,
                                                color: CustomColors.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            IconButton(
                              onPressed: () => showModal(
                                context,
                                page: NavigationModal(
                                  startPoint: [
                                    readLat(context)!,
                                    readLng(context)!
                                  ],
                                  endPoint: [data.lat, data.lng],
                                  destination: data.toiletName,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              constraints: const BoxConstraints(),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextWithIcon(
                          icon: locationIcon,
                          text: data.address,
                          flex: 18,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Flexible(
                        // flex: 2,
                        child: TextWithIcon(
                          icon: clockIcon,
                          text: data.duration,
                          flex: 10,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 7,
                        child: TextWithIcon(
                          icon: starIcon,
                          text:
                              '${data.score.toStringAsFixed(2)} (${data.commentCnt >= 1000 ? '999+' : data.commentCnt}개)',
                          iconColor: CustomColors.yellowColor,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                      data.phoneNo != ''
                          ? Flexible(
                              flex: 8,
                              child: TextWithIcon(
                                icon: phoneIcon,
                                text: data.phoneNo,
                                flex: 6,
                                gap: 7,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      existState()
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  height: 1.6,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      CustomButton(
                        fontSize: FontSize.smallSize,
                        onPressed: addOrEditReview,
                        buttonText:
                            getToken(context) == null || data.reviewId == 0
                                ? '리뷰 남기기'
                                : '리뷰 수정하기',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//* filter 상자
class FilterBox extends StatefulWidget {
  final void Function(int) onPressed;
  final bool applyLong, isMain;
  final BoolList? filterList;
  const FilterBox({
    super.key,
    required this.onPressed,
    this.applyLong = true,
    this.isMain = false,
    this.filterList,
  });

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  StringList filterList = ['기저귀', '유아용', '장애인', '24시간'];
  StringList longFilterList = ['기저귀 교환대', '어린이용 화장실', '장애인용 화장실', '24시간 운영'];

  @override
  void initState() {
    super.initState();
  }

  void onTapInMain(int index) {
    setFilter(context, index, !readFilter(context, index));
    initLoadingData(context, isMain: true);
    widget.onPressed(index);
  }

  void onTapInSearch(int index) {
    initLoadingData(context, isSearch: true);
    widget.onPressed(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.applyLong
          ? [
              for (int i = 0; i < 2; i += 1)
                Row(
                  mainAxisAlignment: widget.isMain
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    for (int j = 0; j < 2; j += 1)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomBox(
                          width: screenWidth(context) * 0.44,
                          color:
                              widget.isMain && getFilter(context, (2 * i) + j)
                                  ? mainColor
                                  : whiteColor,
                          boxShadow: const [defaultShadow],
                          border: Border.all(
                            color: !widget.isMain &&
                                    widget.filterList![(2 * i) + j]
                                ? redColor
                                : whiteColor,
                          ),
                          onTap: widget.isMain
                              ? () => onTapInMain((2 * i) + j)
                              : () => onTapInSearch((2 * i) + j),
                          radius: 5,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12,
                              ),
                              child: CustomText(
                                title: longFilterList[(2 * i) + j],
                                font: kimm,
                                fontSize: FontSize.smallSize,
                                color: widget.isMain &&
                                        getFilter(context, (2 * i) + j)
                                    ? CustomColors.whiteColor
                                    : CustomColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
            ]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i += 1)
                    CustomBox(
                      onTap: () => onTapInMain(i),
                      // width: 100,
                      // height: 30,
                      color: getFilter(context, i) ? mainColor : whiteColor,
                      radius: 5,
                      boxShadow: const [defaultShadow],
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
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
              )
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
  const CustomBox({
    super.key,
    this.onTap,
    required this.child,
    this.width,
    this.height,
    this.color,
    this.radius = 10,
    this.boxShadow,
    this.borderRadius,
    this.border,
  });

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
  final ReturnVoid refreshPage;
  const ReviewBox({
    super.key,
    required this.review,
    required this.toiletId,
    required this.toiletName,
    required this.refreshPage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
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
                  flex: 4,
                  child: Row(
                    children: [
                      CustomText(
                        color: CustomColors.mainColor,
                        title: review.nickname,
                        fontSize: FontSize.smallSize,
                      ),
                      const SizedBox(width: 10),
                      getToken(context) != null &&
                              review.nickname == getName(context)
                          ? Row(
                              children: [
                                CustomIconButton(
                                  color: CustomColors.mainColor,
                                  icon: editIcon,
                                  iconSize: 20,
                                  onPressed: routerPush(
                                    context,
                                    page: ReviewForm(
                                      toiletName: toiletName,
                                      toiletId: toiletId,
                                      reviewId: review.id,
                                      preComment: review.comment,
                                      preScore: review.score,
                                      showReview: true,
                                      afterWork: refreshPage,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CustomIconButton(
                                  color: CustomColors.redColor,
                                  icon: deleteIcon,
                                  iconSize: 20,
                                  onPressed: () => showModal(
                                    context,
                                    page: DeleteModal(
                                      deleteMode: 0,
                                      id: review.id,
                                      refreshPage: refreshPage,
                                      reviewContext: context,
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
                    flex: 3,
                    icon: starIcon,
                    text: '${review.score}',
                    iconColor: CustomColors.yellowColor,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ],
            ),
            CustomText(title: review.comment),
            const SizedBox(
              height: 5,
            )
          ],
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
