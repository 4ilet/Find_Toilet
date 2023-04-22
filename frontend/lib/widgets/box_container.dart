import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/user_provider.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: CustomBox(
        onTap: widget.onTap,
        height: 220,
        width: 170,
        color: whiteColor,
        boxShadow: widget.selected ? [redShadow] : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CustomBox(
              color: greyColor,
              height: 130,
              width: 130,
              child: SizedBox(),
            ),
            CustomText(title: widget.text)
          ],
        ),
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
    String printedName = folderName.length <= 3
        ? folderName
        : '${folderName.substring(0, 4)}\n${folderName.substring(4)}';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: printedName,
                  fontSize: FontSize.defaultSize,
                  color: CustomColors.mainColor,
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
                      iconSize: 25,
                    ),
                    CustomIconButton(
                      icon: deleteIcon,
                      color: CustomColors.redColor,
                      onPressed: () => showModal(context,
                          page: DeleteModal(
                            deleteMode: 1,
                            id: folderId,
                          )),
                      iconSize: 25,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  title: '$bookmarkCnt 개',
                  fontSize: FontSize.smallSize,
                  color: CustomColors.blackColor,
                ),
              ],
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

//* 화장실 목록 아이템
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
    late bool liked;
    final IconDataList iconList = [
      locationIcon,
      phoneIcon,
      clockIcon,
      starIcon
    ];

    void addIntoBookmark() async {
      final token = UserProvider().token;
      if (token == null || token == '') {
        routerPush(context,
            page: ReviewForm(
              toiletName: data.toiletName,
              toiletId: data.toiletId,
            ))();
      } else {
        showModal(context, page: const LoginConfirmModal());
      }
    }

    final infoList = [
      data.address,
      data.phoneNo,
      data.duration,
      '${data.score} (${data.reviewLen}개)'
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomBox(
        onTap: routerPush(
          context,
          page: isMain
              ? const Main(showReview: true)
              : const Search(
                  query: '',
                  showReview: true,
                ),
        ),
        color: whiteColor,
        height: 200,
        width: 500,
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
                  CustomText(
                      color: CustomColors.mainColor,
                      title: data.toiletName,
                      fontSize: FontSize.defaultSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => showModal(context,
                            //* 현재 추가 여부에 따라 다르게
                            page: const AddToBookMarkModal()),
                        icon: const CustomIcon(
                          icon: true ? heartIcon : emptyHeartIcon,
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWithIcon(
                    icon: locationIcon,
                    text: data.address,
                  ),
                  TextWithIcon(
                    icon: phoneIcon,
                    text: data.phoneNo,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWithIcon(
                    icon: clockIcon,
                    text: data.duration,
                  ),
                  TextWithIcon(
                    icon: starIcon,
                    text: '${data.score} (${data.reviewLen}개)',
                    iconColor: CustomColors.yellowColor,
                  ),
                ],
              ),
              const CustomText(
                title: '이용 가능 시설',
                fontSize: FontSize.smallSize,
                color: CustomColors.mainColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  data.can24hour
                      ? const CustomText(
                          title: '24시간 이용 가능',
                          fontSize: FontSize.smallSize,
                        )
                      : const SizedBox(),
                  data.privateDiaper
                      ? const CustomText(
                          title: '기저귀 교환대',
                          fontSize: FontSize.smallSize,
                        )
                      : const SizedBox(),
                  data.privateDisabledM1 ||
                          data.privateDisabledM2 ||
                          data.privateDisabledF
                      ? const CustomText(
                          title: '장애인용',
                          fontSize: FontSize.smallSize,
                        )
                      : const SizedBox(),
                  CustomButton(
                    fontSize: FontSize.smallSize,
                    onPressed: addIntoBookmark,
                    buttonText: '리뷰 남기기',
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
                  CustomText(
                    color: CustomColors.mainColor,
                    title: review.nickname,
                  ),
                  CustomIconButton(
                    color: CustomColors.mainColor,
                    icon: editIcon,
                    iconSize: 20,
                    onPressed: routerPush(
                      context,
                      page: ReviewForm(
                        toiletName: toiletName,
                        toiletId: toiletId,
                        reviewId: reviewId,
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
                        id: reviewId,
                      ),
                    ),
                  ),
                  TextWithIcon(
                    icon: starIcon,
                    text: '${review.score}',
                    iconColor: CustomColors.yellowColor,
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
