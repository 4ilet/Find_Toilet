//* 즐겨찾기 메인 화면 (폴더 존재)
import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BookMarkFolderList extends StatelessWidget {
  const BookMarkFolderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        toolbarHeight: isDefaultTheme(context) ? 65 : 75,
        flexibleSpace: Padding(
          padding:
              EdgeInsets.fromLTRB(20, statusBarHeight(context) + 15, 20, 0),
          child: Flexible(
            child: Row(
              children: [
                Flexible(
                  child: CustomIconButton(
                    icon: exitIcon,
                    color: CustomColors.whiteColor,
                    onPressed: routerPop(context),
                    iconSize: 45,
                    padding: EdgeInsets.zero,
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 5),
                      CustomText(
                        title:
                            '${getName(context)}님의\n즐겨 찾기 폴더${onRefresh(context)}',
                        fontSize: FontSize.largeSize,
                        color: CustomColors.whiteColor,
                        font: kimm,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: FolderProvider().getFolderList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Flexible(child: folderListView(snapshot));
              }
              return const Center(child: CircularProgressIndicator());
            },
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
            FolderBox(folderInfo: snapshot.data![2 * index + di]),
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
          FolderBox(
            folderInfo: snapshot.data![2 * index],
            onlyOne: length == 1,
          ),
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
