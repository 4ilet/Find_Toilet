import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* 즐겨찾기 메인 화면 (폴더 존재)
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
                ? const BookMarkBox(onlyOne: true, add: true)
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

//* 폴더 내 즐겨찾기 목록
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
                  font: notoSans,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              for (int i = 0; i < 7; i += 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListItem(),
                ),
            ],
          )),
          const Padding(
            padding: EdgeInsets.all(20),
            child: ExitPage(),
          ),
        ]),
      ),
    );
  }
}
