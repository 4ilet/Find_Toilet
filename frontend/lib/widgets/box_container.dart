import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/review_form_screen.dart';
import 'package:find_toilet/utilities/global_func.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* 테마 선택 시의 상처
class ThemeBox extends StatefulWidget {
  final String text;
  late bool selected;
  ThemeBox({super.key, required this.text, required this.selected});

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
              CommonBox(
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
  late bool selected;
  CommonBox({
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
    return GestureDetector(
      onTap: () => routerPush(
          context: context,
          page: BookMarkList(folderName: folderName, listCnt: listCnt)),
      child: CommonBox(
          height: 150,
          width: 150,
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: folderName,
                      fontSize: FontSize.defaultSize,
                      color: CustomColors.mainColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          icon: editIcon,
                          color: CustomColors.mainColor,
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  const InputModal(title: '즐겨 찾기 폴더명 수정')),
                        ),
                        CustomIconButton(
                          icon: deleteIcon,
                          color: CustomColors.redColor,
                          onPressed: () {},
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
      onTap: () {},
      child: CommonBox(
        height: 150,
        width: 150,
        color: whiteColor,
        child: const Center(
            child: Icon(
          Icons.add,
          color: mainColor,
          size: 50,
        )),
      ),
    );
  }
}

//* 장소 목록 아이템
class ListItem extends StatelessWidget {
  final String font;
  final StringList? available;
  const ListItem({
    super.key,
    this.font = notoSans,
    this.available,
  });

  @override
  Widget build(BuildContext context) {
    void toReview() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ReviewForm()));
    }

    return CommonBox(
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
                    title: '광주시립도서관화장실',
                    fontSize: FontSize.defaultSize,
                    font: font),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: redColor,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => const NavigationModal());
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.lightBlue,
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
                  text: '광주광역시 북구 어쩌고길',
                  font: font,
                ),
                TextWithIcon(
                  icon: phoneIcon,
                  text: '062-xxxx-xxxx',
                  font: font,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithIcon(
                  icon: clockIcon,
                  text: '00:00 - 00:00',
                  textColor: CustomColors.blackColor,
                  font: font,
                ),
                TextWithIcon(
                    icon: starIcon,
                    text: '4.3 (30개)',
                    iconColor: CustomColors.yellowColor,
                    font: font),
              ],
            ),
            CustomText(
              title: '이용 가능 시설',
              fontSize: FontSize.smallSize,
              color: CustomColors.mainColor,
              font: font,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  title: '장애인용',
                  fontSize: FontSize.smallSize,
                  color: CustomColors.blackColor,
                  font: font,
                ),
                CustomText(
                    title: '유아용',
                    fontSize: FontSize.smallSize,
                    color: CustomColors.blackColor,
                    font: font),
                CustomText(
                  title: '기저귀 교환대',
                  fontSize: FontSize.smallSize,
                  color: CustomColors.blackColor,
                  font: font,
                ),
                CustomButton(
                  onPressed: toReview,
                  buttonText: '리뷰 남기기',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
