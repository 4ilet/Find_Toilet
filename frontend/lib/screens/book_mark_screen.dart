import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BookMarkMain extends StatefulWidget {
  const BookMarkMain({super.key});

  @override
  State<BookMarkMain> createState() => _BookMarkMainState();
}

class _BookMarkMainState extends State<BookMarkMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const CustomText(
              title: '포일렛님의 즐겨 찾기 폴더',
              fontSize: FontSize.largeSize,
              color: CustomColors.whiteColor,
            ),
            const SizedBox(height: 10),
            BookMarkBox(),
            BookMarkBox(),
            BookMarkBox(),
            BookMarkBox(onlyOne: true),
          ]),
        ),
      ),
    );
  }
}
