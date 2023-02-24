import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/select_box.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ToiletList extends StatefulWidget {
  final bool isMain;
  const ToiletList({super.key, required this.isMain});

  @override
  State<ToiletList> createState() => _ToiletListState();
}

class _ToiletListState extends State<ToiletList> {
  late double height;
  final double lowLimit = 300;
  final double upThresh = 300;
  final double boundary = 500;
  final double downThresh = 550;
  bool longAnimation = false;

  @override
  void initState() {
    super.initState();
    height = lowLimit;
  }

  @override
  Widget build(BuildContext context) {
    const List<String> sortOrder = ['거리 순', '평점 순', '리뷰 많은 순'];
    final double highLimit = MediaQuery.of(context).size.height * 0.8;
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onVerticalDragUpdate: ((details) {
          // delta: y축의 변화량, 우리가 보기에 위로 움직이면 양의 값, 아래로 움직이면 음의 값
          double? delta = details.primaryDelta;
          if (delta != null) {
            /// Long Animation이 진행 되고 있을 때는 드래그로 높이 변화 방지,
            /// 그리고 low limit 보다 작을 때 delta가 양수,
            /// High limit 보다 크거나 같을 때 delta가 음수이면 드래그로 높이 변화 방지
            if (longAnimation ||
                (height <= lowLimit && delta > 0) ||
                (height >= highLimit && delta < 0)) return;
            setState(() {
              /// 600으로 높이 설정
              if (upThresh <= height && height <= boundary) {
                height = highLimit;
                longAnimation = true;
              }

              /// 100으로 높이 설정
              else if (boundary <= height && height <= downThresh) {
                height = lowLimit;
                longAnimation = true;
              }

              /// 기본 작동
              else {
                height -= delta;
              }
            });
          }
        }),
        child: AnimatedContainer(
          curve: Curves.bounceOut,
          onEnd: () {
            if (longAnimation) {
              setState(() {
                longAnimation = false;
              });
            }
          },
          duration: const Duration(milliseconds: 400),
          decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          width: MediaQuery.of(context).size.width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 70,
                //   height: 4.5,
                //   decoration: const BoxDecoration(
                //       color: whiteColor,
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: widget.isMain ? '주변 화장실' : '검색 결과',
                        fontSize: FontSize.largeSize,
                        color: CustomColors.whiteColor,
                      ),
                      widget.isMain
                          ? const SizedBox()
                          : const SelectBox(
                              selectList: sortOrder, width: 120, height: 30)
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomText(
                    title: '필터를 적용한 결과입니다',
                    fontSize: FontSize.smallSize,
                    color: CustomColors.whiteColor,
                    font: 'Noto Sans',
                  ),
                ),
                Column(
                  children: const [
                    ListItem(),
                    ListItem(),
                    ListItem(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
