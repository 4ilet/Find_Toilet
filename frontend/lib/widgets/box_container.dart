import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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

class BookMarkBox extends StatelessWidget {
  bool onlyOne, add;
  String folderName1;
  String folderName2;
  int listCnt1;
  int listCnt2;
  BookMarkBox({
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
          FolderBox(
            folderName: folderName1,
            add: onlyOne ? add : false,
            listCnt: listCnt1,
          ),
          onlyOne
              ? const SizedBox()
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
    void showBookMark() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookMarkList(
                    folderName: folderName,
                    listCnt: listCnt,
                  )));
    }

    return GestureDetector(
      onTap: showBookMark,
      child: CommonBox(
          height: 150,
          width: 150,
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: add
                ? const Center(
                    child: Icon(
                    Icons.add,
                    color: mainColor,
                    size: 50,
                  ))
                : Column(
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
                              SizedBox(
                                height: 37,
                                width: 30,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit,
                                        color: mainColor)),
                              ),
                              SizedBox(
                                height: 37,
                                width: 30,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete,
                                        color: redColor)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CustomText(
                          title: '$listCnt 개',
                          fontSize: FontSize.defaultSize,
                          color: CustomColors.blackColor)
                    ],
                  ),
          )),
    );
  }
}
