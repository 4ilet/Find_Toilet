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

//* 즐겨찾기 상자 한 줄
class BookMarkBox extends StatelessWidget {
  final bool onlyOne, add;
  final String folderName1;
  final String folderName2;
  final int listCnt1;
  final int listCnt2;
  const BookMarkBox({
    super.key,
    this.onlyOne = false,
    this.folderName1 = '기본',
    this.folderName2 = '기본',
    this.listCnt1 = 0,
    this.listCnt2 = 0,
    this.add = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          add && onlyOne
              ? const AddBox()
              : FolderBox(
                  folderName: folderName1,
                  add: onlyOne ? add : false,
                  listCnt: listCnt1,
                ),
          onlyOne
              ? const SizedBox()
              : add
                  ? const AddBox()
                  : FolderBox(
                      folderName: folderName2,
                      add: add,
                      listCnt: listCnt2,
                    ),
        ],
      ),
    );
  }
}

//* 즐겨찾기 폴더
class FolderBox extends StatelessWidget {
  const FolderBox(
      {super.key,
      required this.folderName,
      required this.folderId,
      this.listCnt = 0,
      this.add = false});

  final String folderName;
  final int listCnt, folderId;
  final bool add;

  @override
  Widget build(BuildContext context) {
    String printedName = folderName.length < 3
        ? folderName
        : '${folderName.substring(0, 4)}\n${folderName.substring(4)}';
    return CustomBox(
      onTap: routerPush(
        context,
        page: BookMarkList(folderName: folderName, listCnt: listCnt),
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
                      onPressed: showModal(
                        context,
                        page: const InputModal(
                          title: '즐겨 찾기 폴더명 수정',
                          buttonText: '수정',
                        ),
                      ),
                      iconSize: 25,
                    ),
                    CustomIconButton(
                      icon: deleteIcon,
                      color: CustomColors.redColor,
                      onPressed: showModal(context,
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
                  title: '$listCnt 개',
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
  const AddBox({super.key});

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
class ListItem extends StatefulWidget {
  final String toiletName, address, phoneNo, duration;
  final StringList available;
  final double score;
  final int reviewCnt, toiletId;
  final bool isLiked, showReview, isMain;
  const ListItem({
    super.key,
    this.toiletName = '광주시립도서관화장실',
    this.address = '광주광역시 북구 어쩌고길',
    this.phoneNo = '062-xxx-xxxx',
    this.duration = '00:00 - 00:00',
    this.score = 4.3,
    this.reviewCnt = 30,
    this.available = const ['장애인용', '유아용', '기저귀 교환대'],
    this.isLiked = false,
    required this.showReview,
    this.isMain = true,
    this.toiletId = 13,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late bool liked;
  final IconDataList iconList = [locationIcon, phoneIcon, clockIcon, starIcon];
  late final StringList infoList;
  void changeLiked() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  void initState() {
    super.initState();
    liked = widget.isLiked;
    infoList = [
      widget.address,
      widget.phoneNo,
      widget.duration,
      '${widget.score} (${widget.reviewCnt}개)'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomBox(
        onTap: routerPush(
          context,
          page: widget.isMain
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
                      title: widget.toiletName,
                      fontSize: FontSize.defaultSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: showModal(context,
                            page: const AddToBookMarkModal()),
                        icon: CustomIcon(
                          icon: liked ? heartIcon : emptyHeartIcon,
                          color: redColor,
                        ),
                      ),
                      IconButton(
                        onPressed: showModal(context,
                            page: NavigationModal(
                              startPoint: const [37.537229, 127.005515],
                              endPoint: const [37.4979502, 127.0276368],
                              destination: widget.toiletName,
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
                    text: widget.address,
                  ),
                  TextWithIcon(
                    icon: phoneIcon,
                    text: widget.phoneNo,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWithIcon(
                    icon: clockIcon,
                    text: widget.duration,
                  ),
                  TextWithIcon(
                    icon: starIcon,
                    text: '${widget.score} (${widget.reviewCnt}개)',
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
                  for (String each in widget.available)
                    CustomText(
                      title: each,
                      fontSize: FontSize.smallSize,
                    ),
                  CustomButton(
                    fontSize: FontSize.smallSize,
                    onPressed: routerPush(context,
                        page: ReviewForm(
                          toiletName: widget.toiletName,
                          toiletId: widget.toiletId,
                        )),
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

  Row toiletTopInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: CustomText(
            color: CustomColors.mainColor,
            title: widget.toiletName,
            fontSize: FontSize.defaultSize,
          ),
        ),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                onPressed: showModal(
                  context,
                  page: const AddToBookMarkModal(),
                ),
                icon: liked ? heartIcon : emptyHeartIcon,
                color: CustomColors.redColor,
              ),
              CustomIconButton(
                onPressed: showModal(
                  context,
                  page: NavigationModal(
                    startPoint: const [37.537229, 127.005515],
                    endPoint: const [37.4979502, 127.0276368],
                    destination: widget.toiletName,
                  ),
                ),
                icon: planeIcon,
                color: CustomColors.lightBlueColor,
                iconSize: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row toiletInfo(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: TextWithIcon(
            icon: iconList[2 * i],
            text: infoList[2 * i],
          ),
        ),
        Flexible(
          flex: 4,
          child: i == 0
              ? TextWithIcon(
                  icon: iconList[2 * i + 1],
                  text: infoList[2 * i + 1],
                )
              : TextWithIcon(
                  icon: iconList[2 * i + 1],
                  text: infoList[2 * i + 1],
                  iconColor: CustomColors.yellowColor,
                ),
        )
      ],
    );
  }
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
  final String nickname, content, toiletName;
  final int toiletId, reviewId;
  final double score;
  const ReviewBox({
    super.key,
    required this.nickname,
    required this.score,
    required this.content,
    required this.toiletName,
    required this.toiletId,
    required this.reviewId,
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
                    title: nickname,
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
                        preComment: content,
                        preScore: score,
                      ),
                    ),
                  ),
                  CustomIconButton(
                    color: CustomColors.redColor,
                    icon: deleteIcon,
                    iconSize: 20,
                    onPressed: showModal(
                      context,
                      page: DeleteModal(
                        deleteMode: 0,
                        id: reviewId,
                      ),
                    ),
                  ),
                  TextWithIcon(
                    icon: starIcon,
                    text: '$score',
                    iconColor: CustomColors.yellowColor,
                  ),
                ],
              ),
              CustomText(title: content)
            ],
          ),
        ),
      ),
    );
  }
}
