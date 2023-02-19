import 'package:find_toilet/screens/review_form_screen.dart';
import 'package:find_toilet/utilities/icon.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BookMarkMain extends StatefulWidget {
  final String nickname;
  int folderCnt;
  BookMarkMain({super.key, this.nickname = '포일렛', this.folderCnt = 1});

  @override
  State<BookMarkMain> createState() => _BookMarkMainState();
}

class _BookMarkMainState extends State<BookMarkMain> {
  late int quot, remain;
  StringList folderNameList = ['광주', '서울', '24시간 개방', '깔끔'];
  IntList folderCntList = [12, 8, 5, 3];
  @override
  void initState() {
    super.initState();
    setState(() {
      quot = widget.folderCnt ~/ 2;
      remain = widget.folderCnt % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomText(
              title: '${widget.nickname}님의 즐겨 찾기 폴더',
              fontSize: FontSize.largeSize,
              color: CustomColors.whiteColor,
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < (quot); i += 1)
              BookMarkBox(
                folderName1: folderNameList[2 * i],
                folderName2: folderNameList[2 * i + 1],
                listCnt1: folderCntList[2 * i],
                listCnt2: folderCntList[2 * i + 1],
              ),
            remain == 0
                ? BookMarkBox(onlyOne: true, add: true)
                : BookMarkBox(
                    add: true,
                    folderName1: folderNameList.last,
                    listCnt1: folderCntList.last,
                  ),
            const ExitPage()
          ]),
        ),
      ),
    );
  }
}

class BookMarkList extends StatelessWidget {
  final String folderName;
  final int listCnt;
  const BookMarkList(
      {super.key, required this.folderName, required this.listCnt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CustomText(
                  title: folderName,
                  fontSize: FontSize.titleSize,
                  color: CustomColors.whiteColor,
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomText(
                  title: '$listCnt개',
                  fontSize: FontSize.defaultSize,
                  color: CustomColors.whiteColor,
                  font: 'Noto Sans',
                ),
              ],
            ),
          ),
          const ListItem(),
          const Padding(
            padding: EdgeInsets.all(20),
            child: ExitPage(),
          ),
        ]),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String font;
  final StringList? available;
  const ListItem({
    super.key,
    this.font = 'Noto Sans',
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
              children: const [
                TextWithIcon(
                    icon: clockIcon,
                    text: '00:00 - 00:00',
                    textColor: CustomColors.blackColor),
                TextWithIcon(
                  icon: startIcon,
                  text: '4.3(30개)',
                  iconColor: yellowColor,
                ),
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
