import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/review_form_screen.dart';
import 'package:find_toilet/screens/search_screen.dart';
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
  const ThemeBox(
      {super.key,
      required this.text,
      required this.selected,
      required this.onTap});

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
            color: greyColor,
            height: screenHeight(context) * 0.2,
            width: screenWidth(context) * 0.6,
            child: const SizedBox(),
          ),
          CustomText(title: widget.text)
        ],
      ),
    );
  }
}

//* 즐겨찾기 폴더
class FolderBox extends StatelessWidget {
  final FolderModel folderInfo;
  final bool add;
  // final ReturnVoid editFolder;
  const FolderBox({
    super.key,
    required this.folderInfo,
    // required this.editFolder,
    this.add = false,
  });

  @override
  Widget build(BuildContext context) {
    String folderName = folderInfo.folderName;
    int bookmarkCnt = folderInfo.bookmarkCnt;
    int folderId = folderInfo.folderId;
    String printedName = folderName.length <= 5
        ? folderName
        : '${folderName.substring(0, 5)}\n${folderName.substring(5)}';
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
                children: [
                  CustomText(
                    title: printedName,
                    fontSize: FontSize.defaultSize,
                    color: CustomColors.mainColor,
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
                          page: InputModal(
                            title: '즐겨 찾기 폴더명 수정',
                            buttonText: '수정',
                            isAlert: false,
                            kindOf: 'folder',
                            folderId: folderId,
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
  // final ReturnVoid createFolder;
  const AddBox({
    super.key,
    // required this.createFolder,
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
        builder: (context) => const InputModal(
          title: '즐겨 찾기 폴더 생성',
          buttonText: '만들기',
          isAlert: true,
          kindOf: 'folder',
          // onPressed: widget.createFolder,
        ),
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
  final bool showReview, isMain;
  const ListItem({
    super.key,
    required this.data,
    required this.showReview,
    required this.isMain,
  });

  @override
  Widget build(BuildContext context) {
    BoolList availableList = [
      data.can24hour,
      data.privateDiaper,
      data.privateDisabledM1 || data.privateDisabledM2 || data.privateDisabledF,
      data.privateChildF || data.privateChildM1 || data.privateChildM2
    ];
    // final IconDataList iconList = [
    //   locationIcon,
    //   phoneIcon,
    //   clockIcon,
    //   starIcon
    // ];

    void addOrEditReview() async {
      final token = getToken(context);
      if (token != null && token != '') {
        routerPush(context,
            page: ReviewForm(
              toiletName: data.toiletName,
              toiletId: data.toiletId,
              reviewId: data.reviewId,
            ))();
      } else {
        await showModal(context, page: const LoginConfirmModal());
        routerPop(context)();
      }
    }

    // final infoList = [
    //   data.address,
    //   data.phoneNo,
    //   data.duration,
    //   '${data.score} (${data.commentCnt}개)'
    // ];
    bool existState() {
      for (int i = 0; i < 4; i += 1) {
        if (availableList[i]) return true;
      }
      return false;
    }

    String available(int limit) {
      StringList facilityList = [
        '24시간 이용 가능',
        '기저귀 교환대',
        '장애인용',
        '유아용',
      ];
      String result = '';
      int length = 0;
      for (int i = 0; i < 4; i += 1) {
        if (availableList[i]) {
          final newLength = facilityList[i].length;
          if (length + newLength < limit) {
            result += ' ${facilityList[i]}';
            length += newLength;
          } else {
            result += '\n${facilityList[i]}';
            length = newLength;
          }
        }
      }
      return result;
    }

    String showedValue(String value, int limit) {
      String newValue = '';
      int quot = value.length ~/ limit;
      for (int i = 0; i < quot; i += 1) {
        newValue += '${value.substring(i * limit, (i + 1) * limit)}\n';
      }
      newValue += value.substring(quot * limit);
      return newValue;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomBox(
        onTap: routerPush(
          context,
          page: isMain
              ? Main(
                  showReview: true,
                  toiletModel: data,
                )
              : Search(
                  query: '',
                  showReview: true,
                  toiletModel: data,
                ),
        ),
        color: whiteColor,
        // height: 200,
        // width: screenWidth(context) * 0.8,
        height: screenHeight(context) * 0.3,
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
                  Flexible(
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
                          onPressed: () => showModal(
                            context,
                            page: data.folderId != 0
                                ? DeleteModal(
                                    deleteMode: 2,
                                    id: data.toiletId,
                                    folderId: data.folderId,
                                  )
                                : AddToBookMarkModal(toiletId: data.toiletId),
                          ),
                          icon: CustomIcon(
                            icon:
                                data.folderId != 0 ? heartIcon : emptyHeartIcon,
                            color: redColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => showModal(context,
                              page: NavigationModal(
                                startPoint: const [37.537229, 127.005515],
                                endPoint: [data.lat, data.lng],
                                destination: data.toiletName,
                              )),
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
                      text: showedValue(
                          data.address, data.phoneNo != '' ? 11 : 27),
                    ),
                  ),
                  data.phoneNo != ''
                      ? Flexible(
                          flex: 12,
                          child: TextWithIcon(
                            icon: phoneIcon,
                            text: data.phoneNo,
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
                      text: showedValue(data.duration, 13),
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
              Row(
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
                            ),
                            CustomText(
                              title: available(13),
                              fontSize: FontSize.smallSize,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  // Row toiletTopInfo(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Flexible(
  //         flex: 7,
  //         child: CustomText(
  //           color: CustomColors.mainColor,
  //           title: widget.toiletName,
  //           fontSize: FontSize.defaultSize,
  //         ),
  //       ),
  //       Flexible(
  //         flex: 2,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             CustomIconButton(
  //               onPressed: showModal(
  //                 context,
  //                 page: const AddToBookMarkModal(),
  //               ),
  //               icon: liked ? heartIcon : emptyHeartIcon,
  //               color: CustomColors.redColor,
  //             ),
  //             CustomIconButton(
  //               onPressed: showModal(
  //                 context,
  //                 page: NavigationModal(
  //                   startPoint: const [37.537229, 127.005515],
  //                   endPoint: const [37.4979502, 127.0276368],
  //                   destination: widget.toiletName,
  //                 ),
  //               ),
  //               icon: planeIcon,
  //               color: CustomColors.lightBlueColor,
  //               iconSize: 35,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Row toiletInfo(int i) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Flexible(
  //         flex: 7,
  //         child: TextWithIcon(
  //           icon: iconList[2 * i],
  //           text: infoList[2 * i],
  //         ),
  //       ),
  //       Flexible(
  //         flex: 4,
  //         child: i == 0
  //             ? TextWithIcon(
  //                 icon: iconList[2 * i + 1],
  //                 text: infoList[2 * i + 1],
  //               )
  //             : TextWithIcon(
  //                 icon: iconList[2 * i + 1],
  //                 text: infoList[2 * i + 1],
  //                 iconColor: CustomColors.yellowColor,
  //               ),
  //       )
  //     ],
  //   );
  // }
}

//* filter 상자, 화살표
class FilterBox extends StatefulWidget {
  const FilterBox({super.key});

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  int length = 4;
  StringList filterList = ['기저귀', '유아용', '장애인', '24시간'];
  late StringList showedFilter;
  late BoolList selectedList;
  ReturnVoid changeSelected(int i) {
    return () {
      setState(() {
        selectedList[i] = !selectedList[i];
      });
    };
  }

  @override
  void initState() {
    super.initState();
    showedFilter = [for (int i = 0; i < 3; i += 1) filterList[i]];
    selectedList = [for (int i = 0; i < length; i += 1) false];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: toLeftIcon,
          iconSize: 50,
          onPressed: () {},
          color: CustomColors.mainColor,
        ),
        for (int i = 0; i < 3; i += 1)
          CustomBox(
            onTap: changeSelected(i),
            // width: 100,
            // height: 30,
            color: selectedList[i] ? mainColor : whiteColor,
            radius: 5,
            boxShadow: const [defaultShadow],
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: CustomText(
                  title: showedFilter[i],
                  font: kimm,
                  fontSize: FontSize.smallSize,
                  color: selectedList[i]
                      ? CustomColors.whiteColor
                      : CustomColors.blackColor,
                ),
              ),
            ),
          ),
        CustomIconButton(
          icon: toRightIcon,
          iconSize: 50,
          onPressed: () {},
          color: CustomColors.mainColor,
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
