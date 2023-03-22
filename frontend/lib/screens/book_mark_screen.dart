import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/scroll_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//* 즐겨찾기 메인 화면 (폴더 존재)
class BookMarkFolderList extends StatefulWidget {
  final String nickname;

  const BookMarkFolderList({super.key, required this.nickname});

  @override
  State<BookMarkFolderList> createState() => _BookMarkFolderListState();
}

class _BookMarkFolderListState extends State<BookMarkFolderList> {
  late Future<FolderList> folderList;
  // late int folderCnt;
  // List folderList = [];
  // int folderCnt = 0;
  late int folderCnt, quot, remain;
  void initFolderList() async {
    folderList = await FolderProvider.getFolderList(memberId);
    folderCnt = folderList.length;
    quot = folderCnt ~/ 2;
    remain = folderCnt % 2;
  }

  @override
  void initState() {
    super.initState();
    initFolderList();
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
            FutureBuilder(
                future: folderList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        folderListView(snapshot),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            for (int i = 0; i < quot; i += 1)
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Row(
                  children: [
                    for (int j = 0; j < 2; j += 1)
                      FolderBox(folderInfo: folderList[2 * i + j]),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Row(
                children: [
                  for (int j = 0; j < remain; j += 1)
                    FolderBox(folderInfo: folderList[-1]),
                  quot < 5 ? const AddBox() : const SizedBox()
                ],
              ),
            ),
            const ExitPage()
          ]),
        ),
      ),
    );
  }

  ListView folderListView(AsyncSnapshot<FolderList> snapshot) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var folder = snapshot.data![index];
        return FolderBox(folderInfo: folder);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: folderCnt,
    );
  }
}

//* 폴더 내 즐겨찾기 목록
class BookMarkList extends StatelessWidget {
  final String folderName;
  final int bookmarkCnt;

  const BookMarkList(
      {super.key, required this.folderName, required this.bookmarkCnt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: ToiletScrollView(
        toolbarHeight: 50,
        expandedHeight: 80,
        flexibleSpace: Padding(
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
                title: '$bookmarkCnt',
                fontSize: FontSize.defaultSize,
                color: CustomColors.whiteColor,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: ExitPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
