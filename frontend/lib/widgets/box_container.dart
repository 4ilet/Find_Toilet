import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/review_form_screen.dart';
import 'package:find_toilet/utilities/global_func.dart';
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
  const ThemeBox({super.key, required this.text, required this.selected});

  @override
  State<ThemeBox> createState() => _ThemeBoxState();
}

class _ThemeBoxState extends State<ThemeBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: CommonBox(
          height: 220,
          width: 170,
          color: whiteColor,
          selected: widget.selected,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CommonBox(
                color: Colors.grey,
                height: 130,
                width: 130,
              ),
              Text(
                widget.text,
                style: const TextStyle(fontSize: defaultSize),
              ),
            ],
          )),
    );
  }
}

//* 상자 형태 기본값
class CommonBox extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final double height, width;
  final bool selected;
  const CommonBox({
    super.key,
    this.child,
    this.color,
    required this.height,
    required this.width,
    this.selected = false,
  });

  @override
  State<CommonBox> createState() => _CommonBoxState();
}

class _CommonBoxState extends State<CommonBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
        boxShadow: widget.selected
            ? const [
                BoxShadow(blurRadius: 10, spreadRadius: 5, color: Colors.red),
              ]
            : null,
      ),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: widget.child,
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
      this.listCnt = 0,
      this.add = false});

  final String folderName;
  final int listCnt;
  final bool add;

  @override
  Widget build(BuildContext context) {
    String printedName = folderName.length < 3
        ? folderName
        : '${folderName.substring(0, 4)}\n${folderName.substring(4)}';
    return GestureDetector(
      onTap: routerPush(
          context: context,
          page: BookMarkList(folderName: folderName, listCnt: listCnt)),
      child: CommonBox(
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
                              context: context,
                              page: const InputModal(
                                title: '즐겨 찾기 폴더명 수정',
                                buttonText: '수정',
                              )),
                          iconSize: 25,
                        ),
                        CustomIconButton(
                          icon: deleteIcon,
                          color: CustomColors.redColor,
                          onPressed: showModal(
                              context: context, page: const DeleteModal()),
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
                      font: notoSans,
                    ),
                  ],
                )
              ],
            ),
          )),
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
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => const InputModal(
                title: '즐겨 찾기 폴더 생성',
                buttonText: '만들기',
              )),
      child: const CommonBox(
        height: 150,
        width: 150,
        color: whiteColor,
        child: Center(
          child: CustomIcon(
            icon: plusIcon,
            color: mainColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}

//* 장소 목록 아이템
class ListItem extends StatefulWidget {
  final String font;
  final StringList available;
  final String toiletName, address, phoneNo, duration;
  final double score;
  final int reviewCnt;
  final bool isLiked;
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
    this.font = notoSans,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late bool liked;
  void changeLiked() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  void initState() {
    super.initState();
    liked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {},
        child: CommonBox(
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
                    CustomText(
                        color: CustomColors.mainColor,
                        title: widget.toiletName,
                        fontSize: FontSize.defaultSize,
                        font: widget.font),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: showModal(
                              context: context,
                              page: const AddToBookMarkModal()),
                          icon: CustomIcon(
                              icon: liked ? heartIcon : emptyHeartIcon,
                              color: redColor),
                        ),
                        IconButton(
                            onPressed: showModal(
                                context: context,
                                page: const NavigationModal()),
                            icon: const CustomIcon(
                              icon: planeIcon,
                              color: Colors.lightBlue,
                              size: 35,
                            )),
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
                      font: widget.font,
                    ),
                    TextWithIcon(
                      icon: phoneIcon,
                      text: widget.phoneNo,
                      font: widget.font,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWithIcon(
                      icon: clockIcon,
                      text: widget.duration,
                      font: widget.font,
                    ),
                    TextWithIcon(
                        icon: starIcon,
                        text: '${widget.score} (${widget.reviewCnt}개)',
                        iconColor: CustomColors.yellowColor,
                        font: widget.font),
                  ],
                ),
                CustomText(
                  title: '이용 가능 시설',
                  fontSize: FontSize.smallSize,
                  color: CustomColors.mainColor,
                  font: widget.font,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (String each in widget.available)
                      CustomText(
                        title: each,
                        fontSize: FontSize.smallSize,
                        font: widget.font,
                      ),
                    CustomButton(
                      onPressed: routerPush(
                          context: context,
                          page: ReviewForm(toiletName: widget.toiletName)),
                      buttonText: '리뷰 남기기',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
  void changeSelected(int i) {
    setState(() {
      selectedList[i] = !selectedList[i];
    });
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
          GestureDetector(
            onTap: () => changeSelected(i),
            child: Container(
              // width: 100,
              // height: 30,
              decoration: BoxDecoration(
                  color: selectedList[i] ? mainColor : whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [defaultShadow]),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: CustomText(
                    title: showedFilter[i],
                    fontSize: FontSize.smallSize,
                    color: selectedList[i]
                        ? CustomColors.whiteColor
                        : CustomColors.blackColor,
                  ),
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
