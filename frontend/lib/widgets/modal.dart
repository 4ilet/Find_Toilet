import 'package:find_toilet/utilities/global_func.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//* 내비게이션 앱 연결 모달
class NavigationModal extends StatelessWidget {
  final List<double> startPoint, endPoint;
  final String destination;
  const NavigationModal({
    super.key,
    required this.startPoint,
    required this.endPoint,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    const StringList appList = ['네이버맵', '카카오맵', 'T맵'];
    List<Image> imgList = [
      Image.asset(naverMap),
      Image.asset(kakaoMap),
      Image.asset(tMap)
    ];
    List<Uri> uriList = [
      Uri.parse(
          'nmap://route/car?slat=${startPoint[0]}&slng=${startPoint[1]}&sname=현위치&dlat=${endPoint[0]}&dlng=${endPoint[1]}&dname=$destination&appname=com.example.myapp'),
      Uri.parse(
          'kakaomap://route?sp=${startPoint[0]},${startPoint[1]}&ep=${endPoint[0]},${endPoint[1]}&by=CAR'),
      Uri.parse('tmap://open')
    ];
    ReturnVoid toMapApp(int i) {
      return () async {
        // final uri = uriList[i];
        // await launchUrl(uri, mode: LaunchMode.externalApplication);
        final newUri = Uri.parse(
            'https://map.naver.com/v5/directions/14134997.483033512,4519704.42999858,광화문,13161322,PLACE_POI/14130204.52216987,4512164.397202961,대교아파트,19000666,PLACE_POI/-/transit?c=12,0,0,0,dh'
            // 'https://apis.openapi.sk.com/tmap/routes/prediction?version=1&callback={callback}'
            );
        await launchUrl(newUri);
      };
    }

    return CustomModalWithClose(
      title: '내비게이션 켜기',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 3; i += 1)
              Column(
                children: [
                  GestureDetector(
                    onTap: toMapApp(i),
                    child: imgList[i],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomText(
                      title: appList[i],
                      fontSize: FontSize.defaultSize,
                      font: notoSans,
                    ),
                  )
                ],
              ),
          ],
        ),
      ],
    );
  }
}

//* 도움말 모달
class HelpModal extends StatelessWidget {
  final String title;
  const HelpModal({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (screenWidth == null || screenHeight == null) {
      initWidthHeight(context);
    }
    return CustomModalWithClose(
      title: title,
      children: [
        SingleChildScrollView(
          child: CustomBox(
            width: screenWidth * 0.8,
            // height: screenHeight,
            child: const Center(
              child: CustomText(
                title: '여기에 내용이 들어감',
                fontSize: FontSize.defaultSize,
                font: notoSans,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//* 입력창 존재 모달
class InputModal extends StatelessWidget {
  final String title, buttonText;
  const InputModal({
    super.key,
    required this.title,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: title,
      buttonText: buttonText,
      children: const [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextField(),
        )),
      ],
    );
  }
}

//* 모달 기본값
class CustomModal extends StatelessWidget {
  final String title, buttonText;
  final WidgetList children;
  final CustomColors titleColor;
  final bool onlyOne;
  final ReturnVoid? onPressed;
  const CustomModal({
    super.key,
    required this.title,
    required this.children,
    this.titleColor = CustomColors.blackColor,
    this.onlyOne = false,
    this.buttonText = '확인',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomText(
            title: title, fontSize: FontSize.largeSize, color: titleColor),
      ),
      children: [
        ...children,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                textColor: CustomColors.mainColor,
                onPressed: onPressed ?? routerPop(context: context),
                buttonText: buttonText),
            onlyOne
                ? const SizedBox()
                : CustomButton(
                    onPressed: routerPop(context: context),
                    buttonText: '취소',
                    textColor: CustomColors.mainColor,
                  )
          ],
        ),
      ],
    );
  }
}

//* 상단 위 종료 버튼 존재 모달
class CustomModalWithClose extends StatelessWidget {
  final String title;
  final WidgetList children;
  final CustomColors titleColor;
  const CustomModalWithClose({
    super.key,
    required this.title,
    required this.children,
    this.titleColor = CustomColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButton(
                    color: CustomColors.blackColor,
                    icon: closeIcon,
                    onPressed: routerPop(context: context))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomText(
                  title: title,
                  fontSize: FontSize.largeSize,
                  color: titleColor),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

// * 삭제 확인 모달
class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomModal(
      title: '폴더 삭제 확인',
      children: [
        CustomText(
            title: '폴더 삭제 시 내부의 즐겨찾기도 모두 삭제됩니다. 그래도 삭제하시겠습니까?',
            fontSize: FontSize.defaultSize,
            color: CustomColors.blackColor),
      ],
    );
  }
}

//* 즐겨찾기 추가 모달
class AddToBookMarkModal extends StatefulWidget {
  final int folderCnt;
  const AddToBookMarkModal({super.key, this.folderCnt = 10});

  @override
  State<AddToBookMarkModal> createState() => _AddToBookMarkModalState();
}

class _AddToBookMarkModalState extends State<AddToBookMarkModal> {
  int? selected;
  ReturnVoid selectFolder(int idx) {
    return () {
      setState(() {
        selected = idx;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: '즐겨찾기 추가',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              for (int i = 0; i < widget.folderCnt ~/ 2; i += 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int j = 0; j < 2; j += 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            CustomBox(
                              onTap: selectFolder(2 * i + j),
                              color: whiteColor,
                              border: Border.all(),
                              boxShadow: selected == 2 * i + j
                                  ? const [highlightShadow]
                                  : null,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: CustomText(
                                    title: '폴더명',
                                    fontSize: FontSize.defaultSize),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
