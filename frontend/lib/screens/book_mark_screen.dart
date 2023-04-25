import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/scroll_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 즐겨찾기 메인 화면 (폴더 존재)
class BookMarkFolderList extends StatelessWidget {
  const BookMarkFolderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      icon: exitIcon,
                      color: CustomColors.whiteColor,
                      onPressed: routerPop(context),
                      iconSize: 50,
                    ),
                    CustomText(
                      title:
                          '${context.read<UserInfoProvider>().nickname}님의\n즐겨 찾기 폴더${context.watch<ApplyChangeProvider>().refresh.trim()}',
                      fontSize: FontSize.largeSize,
                      color: CustomColors.whiteColor,
                      font: kimm,
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: FolderProvider().getFolderList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(child: folderListView(snapshot));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView folderListView(AsyncSnapshot<FolderList> snapshot) {
    var length = snapshot.data!.length;
    var quot = length ~/ 2;
    var remain = length % 2;

    Row folderRow(int index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int di = 0; di < 2; di += 1)
            FolderBox(
              folderInfo: snapshot.data![2 * index + di],
            ),
        ],
      );
    }

    Widget addRow(int index) {
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;
      late final WidgetList children;
      if (length >= 10) {
        if (index >= 5) {
          return const SizedBox();
        }
        children = [
          for (int di = 0; di < 2; di += 1)
            FolderBox(
              folderInfo: snapshot.data![2 * index + di],
            ),
        ];
      } else if (remain == 0) {
        mainAxisAlignment = MainAxisAlignment.start;
        children = [const AddBox()];
      } else {
        children = [
          FolderBox(folderInfo: snapshot.data![2 * index]),
          const AddBox()
        ];
      }

      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return index < quot ? folderRow(index) : addRow(index);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: quot + 1,
    );
  }
}

//* 폴더 내 즐겨찾기 목록
class BookMarkList extends StatelessWidget {
  final String folderName;
  final int bookmarkCnt, folderId;

  const BookMarkList({
    super.key,
    required this.folderName,
    required this.bookmarkCnt,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: ToiletScrollView(
        folderId: folderId,
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
