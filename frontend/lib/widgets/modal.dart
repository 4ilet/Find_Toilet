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
import 'package:find_toilet/widgets/list_view.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final int? folderId;
  const InputModal({
    super.key,
    required this.title,
    required this.buttonText,
    required this.isAlert,
    required this.kindOf,
    this.folderId,
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
          folderId == null
              ? await FolderProvider().createNewFolder({'folderName': data!})
              : await FolderProvider().updateFolderName(folderId!,
                  folderData: {'folderName': data!});
          if (!context.mounted) return;
          routerPop(context)();
          showModal(
            context,
            page: AlertModal(
              title: folderId == null ? '폴더 생성 성공' : '폴더 수정 성공',
              content: folderId == null
                  ? '성공적으로 폴더가 생성되었습니다.'
                  : '성공적으로 폴더가 수정되었습니다.',
            ),
          );
        } else {
          showModal(
            context,
            page: const AlertModal(
              title: '폴더명 확인',
              content: '폴더명을 올바르게 입력해주세요.',
            ),
          );
        }
      } catch (error) {
        showModal(
          context,
          page: AlertModal(
            title: '오류 발생',
            content: folderId == null
                ? '오류가 발생해\n 폴더가 생성되지 않았습니다'
                : '오류가 발생해\n 폴더 이름이 변경되지 않았습니다',
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
      onPressed: kindOf == 'nickname'
          ? () => setNickname(data)
          : () => createFolder(context),
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
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SimpleDialog(
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
      ),
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
  const DeleteModal({super.key, required this.deleteMode, required this.id});

  @override
  Widget build(BuildContext context) {
    late final String target, message;
    void applyString() {
      switch (deleteMode) {
        case 0:
          target = '리뷰';
          message = '이 리뷰를\n삭제하시겠습니까?';
          break;
        default:
          target = '폴더';
          message = '폴더 삭제 시\n내부의 즐겨찾기도\n모두 삭제됩니다.\n그래도 삭제하시겠습니까?';
          break;
      }
    }

    void onPressed() async {
      try {
        switch (deleteMode) {
          case 0:
            await ReviewProvider().deleteReview(id);
            break;
          default:
            await FolderProvider().deleteFolder(id);
            break;
        }
        if (!context.mounted) return;
        routerPop(context)();
        showModal(
          context,
          page: const AlertModal(
              title: '삭제 확인', content: '성공적으로 삭제 작업이 완료되었습니다.'),
        );
        changeRefresh(context);
      } catch (error) {
        routerPop(context)();
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
class AddOrDeleteBookMarkModal extends StatefulWidget {
  final int toiletId;
  final List folderId;
  const AddOrDeleteBookMarkModal({
    super.key,
    required this.toiletId,
    required this.folderId,
  });

  @override
  State<AddOrDeleteBookMarkModal> createState() =>
      _AddOrDeleteBookMarkModalState();
}

class _AddOrDeleteBookMarkModalState extends State<AddOrDeleteBookMarkModal> {
  Set selectedFolder = {};
  @override
  void initState() {
    super.initState();
    selectedFolder.addAll(widget.folderId);
  }

  ReturnVoid selectFolder(int id) {
    return () {
      setState(() {
        if (selectedFolder.contains(id)) {
          selectedFolder.remove(id);
        } else {
          selectedFolder.add(id);
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      title: '즐겨찾기 폴더 선택',
      buttonText: '적용',
      onPressed: () async {
        if (widget.folderId.toSet() != selectedFolder) {
          await BookMarkProvider().addToilet(
            folderId: 1,
            // selectedFolder.toList(),
            toiletId: widget.toiletId,
          );
          changeRefresh(context);
          routerPop(context)();
        }
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: FolderProvider().getFolderList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Flexible(
                  child: CustomListView(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final folderInfo = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomBox(
                            onTap: selectFolder(folderInfo.folderId),
                            color: whiteColor,
                            border: Border.all(),
                            boxShadow:
                                selectedFolder.contains(folderInfo.folderId)
                                    ? const [highlightShadow]
                                    : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: CustomText(
                                title: folderInfo.folderName,
                                fontSize: FontSize.defaultSize,
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
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
    final packageNmae = dotenv.env['packageName'];
    const StringList appList = ['네이버맵', '카카오맵', 'T맵'];
    List<Image> imgList = [
      Image.asset(naverMap),
      Image.asset(kakaoMap),
      Image.asset(tMap)
    ];
    List<Uri> uriList = [
      Uri.parse(
          'nmap://route/car?slat=${startPoint[0]}&slng=${startPoint[1]}&sname=현위치&dlat=${endPoint[0]}&dlng=${endPoint[1]}&dname=$destination&appname=$packageNmae'),
      Uri.parse(
          'kakaomap://route?sp=${startPoint[0]},${startPoint[1]}&ep=${endPoint[0]},${endPoint[1]}&by=CAR'),
      Uri.parse(
          'tmap://route?goalname=$destination&goalx=${endPoint[1]}&goaly=${endPoint[0]}')
    ];
    ReturnVoid toMapApp(int i) {
      return () async {
        await launchUrl(uriList[i]);
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
        changeRefresh(context);
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
          isCentered: true,
        )
      ],
      onPressed: () async {
        await login(context);
        if (!context.mounted) return;
        routerPop(context)();
        changeRefresh(context);
      },
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
