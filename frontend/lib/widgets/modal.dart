import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//* 도움말, 라이선스 모달
class HelpModal extends StatelessWidget {
  final bool isHelpModal;
  const HelpModal({
    super.key,
    this.isHelpModal = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModalWithClose(
      title: isHelpModal ? '도움말' : '라이선스',
      children: [
        SingleChildScrollView(
            child: isHelpModal
                ? const CustomBox(
                    child: Center(
                      child: CustomText(
                        title: '여기에 내용이 들어감',
                        fontSize: FontSize.defaultSize,
                      ),
                    ),
                  )
                : const PolicyContent(
                    isPrivate: false,
                    isLicense: true,
                  )),
      ],
    );
  }
}

//* 처리 방침 모달
class PolicyModal extends StatefulWidget {
  const PolicyModal({super.key});

  @override
  State<PolicyModal> createState() => _PolicyModalState();
}

class _PolicyModalState extends State<PolicyModal>
    with TickerProviderStateMixin {
  final List<Tab> policyTabs = [
    const Tab(
      child: CustomText(
        title: '개인 정보 처리 방침',
        fontSize: FontSize.smallSize,
      ),
    ),
    const Tab(
      child: CustomText(
        title: '위치 정보 처리 방침',
        fontSize: FontSize.smallSize,
      ),
    ),
  ];
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalWithClose(
      children: [
        Flexible(
          flex: 1,
          child: TabBar(
            controller: tabController,
            tabs: policyTabs,
            indicatorColor: mainColor,
          ),
        ),
        Flexible(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CustomBox(
              child: TabBarView(
                controller: tabController,
                children: const [
                  PolicyContent(isPrivate: true),
                  PolicyContent(isPrivate: false),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//* 처리 방침, 라이선스 내용
class PolicyContent extends StatelessWidget {
  final bool isLicense;
  final bool isPrivate;
  const PolicyContent({
    super.key,
    required this.isPrivate,
    this.isLicense = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      color: lightGreyColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomText(
                isBoldText: true,
                title: isLicense
                    ? '라이선스'
                    : isPrivate
                        ? '개인 정보 처리 방침'
                        : '위치 정보 처리 방침',
                fontSize: FontSize.largeSize,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                title: isLicense
                    ? license
                    : isPrivate
                        ? privatePolicy
                        : gpsPolicy,
                fontSize: FontSize.smallSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//* 입력창 존재 모달
class InputModal extends StatelessWidget {
  final String title, buttonText;
  final bool isAlert;
  final String kindOf;
  const InputModal({
    super.key,
    required this.title,
    required this.buttonText,
    required this.isAlert,
    required this.kindOf,
  });

  @override
  Widget build(BuildContext context) {
    String? data;
    void fillData(String value) {
      data = value.trim();
    }

    void createFolder(BuildContext context) async {
      try {
        if (data != null && data != '') {
          final result =
              await FolderProvider().createNewFolder({'folderName': data!});
          if (!context.mounted) return;
          routerPop(context)();
          showModal(
            context,
            page: const AlertModal(
              title: '폴더 생성 성공',
              content: '성공적으로 폴더가 생성되었습니다.',
            ),
          );
        } else {}
        // routerPop(context)();
        // routerPush(context, page: const BookMarkFolderList())();
      } catch (error) {
        showModal(
          context,
          page: const AlertModal(
            title: '오류 발생',
            content: '오류가 발생해\n 폴더가 생성되지 않았습니다',
          ),
        );
      }
    }

    void setNickname(String? data) async {
      try {
        if (data != null && data != '') {
          final result = await UserProvider().changeName(data);
          print('result: $result');
          if (result['success'] != null) {
            context.read<UserInfoProvider>().setStoreName(result['success']);
            if (!context.mounted) return;
            routerPop(context)();
            showModal(
              context,
              page: const AlertModal(
                title: '닉네임 적용 성공',
                content: '닉네임이 적용되었습니다.',
              ),
            );
            return;
          } else {
            if (!context.mounted) return;
            showModal(
              context,
              page: const AlertModal(
                title: '닉네임 중복',
                content: '중복된 닉네임입니다.\n다른 닉네임을 입력해주세요.',
              ),
            );
            return;
          }
        }
        if (!context.mounted) return;
        showModal(
          context,
          page: const AlertModal(
            title: '올바르지 않은 닉네임',
            content: '닉네임을 바르게 입력해주세요.',
          ),
        );
      } catch (error) {
        print(error);
        showModal(
          context,
          page: const AlertModal(
            title: '오류 발생',
            content: '오류가 발생해\n 닉네임이 변경되지 않았습니다',
          ),
        );
      }
    }

    return CustomModal(
      title: title,
      buttonText: buttonText,
      onPressed: kindOf == 'folder'
          ? () => createFolder(context)
          : () => setNickname(data),
      isAlert: isAlert,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextField(onChanged: fillData),
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
  final bool isAlert;
  final ReturnVoid? onPressed;
  const CustomModal({
    super.key,
    required this.title,
    required this.children,
    this.titleColor = CustomColors.blackColor,
    this.isAlert = false,
    this.buttonText = '확인',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Flexible(
          child: Center(
            child: CustomText(
              title: title,
              fontSize: FontSize.largeSize,
              color: titleColor,
            ),
          ),
        ),
      ),
      children: [
        ...children,
        isAlert
            ? Flexible(
                child: modalButton(
                  context: context,
                  onPressed: onPressed ?? routerPop(context),
                  buttonText: buttonText,
                ),
              )
            : Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      modalButton(
                        context: context,
                        onPressed: onPressed ?? routerPop(context),
                        buttonText: buttonText,
                      ),
                      modalButton(
                        context: context,
                        onPressed: routerPop(context),
                        buttonText: '취소',
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  CustomButton modalButton({
    required BuildContext context,
    required ReturnVoid onPressed,
    required String buttonText,
  }) {
    return CustomButton(
      textColor: CustomColors.mainColor,
      onPressed: onPressed,
      buttonText: buttonText,
    );
  }
}

//* 상단 위 종료 버튼 존재 모달
class CustomModalWithClose extends StatelessWidget {
  final String? title;
  final WidgetList children;
  final CustomColors titleColor;
  const CustomModalWithClose({
    super.key,
    this.title,
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
                    onPressed: routerPop(context))
              ],
            ),
            title != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomText(
                        title: title!,
                        fontSize: FontSize.largeSize,
                        color: titleColor),
                  )
                : const SizedBox(),
            ...children,
          ],
        ),
      ),
    );
  }
}

// * 삭제 확인 모달
class DeleteModal extends StatelessWidget {
  final int deleteMode, id;
  final int? folderId;
  const DeleteModal(
      {super.key, required this.deleteMode, required this.id, this.folderId});

  @override
  Widget build(BuildContext context) {
    late final String target, message;
    void applyString() {
      switch (deleteMode) {
        case 0:
          target = '리뷰';
          message = '이 리뷰를\n삭제하시겠습니까?';
          break;
        case 1:
          target = '폴더';
          message = '폴더 삭제 시\n내부의 즐겨찾기도\n모두 삭제됩니다.\n그래도 삭제하시겠습니까?';
          break;
        default:
          target = '즐겨찾기';
          message = '즐겨 찾기 목록에서\n이 화장실을 삭제하시겠습니까?';
          break;
      }
    }

    void onPressed() async {
      try {
        late bool response;
        switch (deleteMode) {
          case 0:
            response = await ReviewProvider().deleteReview(id);
            break;
          case 1:
            response = await FolderProvider().deleteFolder(id);
            break;
          default:
            response = await BookMarkProvider()
                .deleteBookMark(folderId: id, toiletId: id);
            break;
        }
        if (!context.mounted) return;
        routerPop(context)();
        showModal(context, page: const SuccessBox(feature: '삭제', page: '폴더'));
      } catch (error) {
        showModal(
          context,
          page: AlertModal(
            title: '오류 발생',
            content: '오류가 발생해\n$target 삭제에 실패했습니다.',
          ),
        );
      }
    }

    applyString();

    return CustomModal(
      title: '$target 삭제 확인',
      onPressed: onPressed,
      children: [
        Center(
          child: CustomText(
              title: message,
              isCentered: true,
              fontSize: FontSize.defaultSize,
              color: CustomColors.blackColor),
        ),
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
      onPressed: () {},
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

//* 확인 버튼만 존재하는 모달
class AlertModal extends StatelessWidget {
  final String title, content;
  final ReturnVoid? onPressed;
  const AlertModal({
    super.key,
    required this.title,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: title,
      isAlert: true,
      onPressed: () {
        context.read<ApplyChangeProvider>().refreshPage();
        routerPop(context)();
      },
      children: [
        CustomText(
          title: content,
          isCentered: true,
        )
      ],
    );
  }
}

//* 로그인 확인 모달
class LoginConfirmModal extends StatelessWidget {
  const LoginConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: '로그인 확인',
      children: const [
        CustomText(
          title: '로그인하시겠습니까?',
        )
      ],
      onPressed: () => UserProvider().login(),
    );
  }
}

class ErrorModal extends StatelessWidget {
  final String feature;
  const ErrorModal({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return AlertModal(
      title: '$feature 오류',
      content: '오류가 발생해 $feature(이)가 처리되지 않았습니다.',
    );
  }
}
