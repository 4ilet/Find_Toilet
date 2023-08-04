import 'package:find_toilet/providers/bookmark_provider.dart';
import 'package:find_toilet/providers/review_provider.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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
      title: isHelpModal ? '도움말\n(터치 시 확대 가능)' : '라이선스',
      children: [
        isHelpModal
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, i) => GestureDetector(
                      child: Image.asset(helpImg[i]),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => InteractiveViewer(
                          child: CustomBox(
                            height: screenHeight(context),
                            onTap: routerPop(context),
                            child: Image.asset(helpImg[i]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: PolicyContent(
                    isPrivate: false,
                    isLicense: true,
                  ),
                ),
              )
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
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  final List<Tab> policyTabs = [
    const Tab(
      icon: CustomText(
        title: '개인 정보\n처리 방침',
        fontSize: FontSize.smallSize,
      ),
    ),
    const Tab(
      icon: CustomText(
        title: '위치 정보\n처리 방침',
        fontSize: FontSize.smallSize,
      ),
    ),
  ];
  late TabController tabController;

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
            labelPadding: const EdgeInsets.only(bottom: 5),
          ),
        ),
        Flexible(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CustomBox(
              radius: 0,
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
    return SingleChildScrollView(
      child: CustomBox(
        color: lightGreyColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: html.Html(
            data: isLicense
                ? license
                : isPrivate
                    ? privacyPolicy
                    : gpsPolicy,
          ),
        ),
      ),
    );
  }
}

//* 닉네임 변경 모달
class NicknameInputModal extends StatelessWidget {
  final bool isAlert;
  const NicknameInputModal({
    super.key,
    required this.isAlert,
  });

  @override
  Widget build(BuildContext context) {
    void setNickname(String? data) async {
      try {
        if (data == null || data == '') {
          showModal(
            context,
            page: const AlertModal(
              title: '올바르지 않은 닉네임',
              content: '닉네임을 바르게 입력해주세요.',
            ),
          );
        } else if (data == getName(context)) {
          showModal(
            context,
            page: const AlertModal(
              title: '닉네임 미변경',
              content: '이전과 다른 닉네임을 설정해주세요',
            ),
          );
        } else {
          UserProvider().changeName(data).then((result) {
            if (result['success'] != null) {
              changeName(context, result['success']);
              showModal(
                context,
                page: const AlertModal(
                  title: '닉네임 적용 성공',
                  content: '닉네임이 적용되었습니다.',
                ),
              ).then((_) {
                routerPop(context)();
              });
              return;
            } else {
              showModal(
                context,
                page: const AlertModal(
                  title: '닉네임 중복',
                  content: '중복된 닉네임입니다.\n다른 닉네임을 입력해주세요.',
                ),
              );
              return;
            }
          });
        }
      } catch (error) {
        showModal(
          context,
          page: const AlertModal(
            title: '오류 발생',
            content: '오류가 발생해\n 닉네임이 변경되지 않았습니다',
          ),
        );
      }
    }

    return InputModal(
      title: '닉네임 설정',
      buttonText: '확인',
      hideButton: isAlert,
      isAlert: isAlert,
      onPressed: setNickname,
      initialValue: getName(context),
    );
  }
}

//* 폴더 생성 / 폴더명 변경 모달
class CreateOrEditFolderModal extends StatelessWidget {
  final int? folderId;
  final String? folderName;
  const CreateOrEditFolderModal({
    super.key,
    this.folderId,
    this.folderName,
  });

  @override
  Widget build(BuildContext context) {
    final work = folderId == null ? '생성' : '수정';
    void Function(String) createFolder(BuildContext context) {
      return (String? data) async {
        try {
          if (data != null && data != '') {
            folderId == null
                ? await FolderProvider().createNewFolder({'folderName': data})
                : await FolderProvider().updateFolderName(
                    folderId!,
                    folderData: {'folderName': data},
                  );
            if (!context.mounted) return;
            routerPop(context)();
            showModal(
              context,
              page: AlertModal(
                title: '폴더 $work 성공',
                content: '성공적으로 폴더가 $work되었습니다.',
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
      };
    }

    return InputModal(
      title: folderId == null ? '폴더 $work' : '폴더명 $work',
      buttonText: work,
      isAlert: false,
      onPressed: createFolder(context),
      initialValue: folderName,
    );
  }
}

//* 입력창 존재 모달
class InputModal extends StatelessWidget {
  final String title, buttonText;
  final bool isAlert, hideButton;
  final int? folderId;
  final void Function(String) onPressed;
  final String? initialValue;
  const InputModal({
    super.key,
    required this.title,
    required this.buttonText,
    required this.isAlert,
    required this.onPressed,
    this.folderId,
    this.initialValue,
    this.hideButton = false,
  });

  @override
  Widget build(BuildContext context) {
    String? data = initialValue;
    void fillData(String value) {
      data = value.trim();
    }

    void changeValue() {
      if (initialValue != data) {
        onPressed(data!);
      } else {
        showModal(
          context,
          page: AlertModal(
            title: title,
            content: '새로운 닉네임을 설정해주세요',
          ),
        );
      }
    }

    return CustomModalWithClose(
      title: title,
      titleColor: CustomColors.blackColor,
      iconColor: CustomColors.mainColor,
      font: kimm,
      hideButton: hideButton,
      children: [
        CustomTextField(
          onChanged: fillData,
          initValue: data,
          hasBorder: true,
          height: 50,
          padding: const EdgeInsets.only(left: 10),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: isAlert
              ? Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: changeValue,
                        textColor: CustomColors.whiteColor,
                        buttonColor: mainColor,
                        fontSize: FontSize.smallSize,
                      ),
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        buttonText: '취소',
                        textColor: CustomColors.blackColor,
                        buttonColor: whiteColor,
                        fontSize: FontSize.smallSize,
                        onPressed: routerPop(context),
                      ),
                      CustomButton(
                        buttonText: buttonText,
                        onPressed: changeValue,
                        textColor: CustomColors.whiteColor,
                        buttonColor: mainColor,
                        fontSize: FontSize.smallSize,
                      ),
                    ],
                  ),
                ),
        )
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
          child: Center(
            child: CustomText(
              title: title,
              color: titleColor,
            ),
          ),
        ),
        children: [
          ...children,
          isAlert
              ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      modalButton(
                        onPressed: onPressed ?? routerPop(context),
                        buttonText: buttonText,
                        isButtonWhite: false,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      modalButton(
                        onPressed: routerPop(context),
                        buttonText: '취소',
                        isButtonWhite: true,
                      ),
                      modalButton(
                        onPressed: onPressed ??
                            routerPop(
                              getKey(context)?.currentContext ?? context,
                            ),
                        buttonText: buttonText,
                        isButtonWhite: false,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  CustomButton modalButton({
    required ReturnVoid onPressed,
    required String buttonText,
    required bool isButtonWhite,
  }) {
    return CustomButton(
      textColor:
          isButtonWhite ? CustomColors.mainColor : CustomColors.whiteColor,
      onPressed: onPressed,
      buttonText: buttonText,
      buttonColor: isButtonWhite ? whiteColor : mainColor,
      fontSize: FontSize.smallSize,
    );
  }
}

//* 상단 위 종료 버튼 존재 모달
class CustomModalWithClose extends StatelessWidget {
  final String? title, font;
  final Widget? titleWidget;
  final WidgetList children;
  final CustomColors titleColor, iconColor;
  final bool isBoldText, hideButton;
  final ReturnVoid? onClosed;
  final CrossAxisAlignment crossAxisAlignment;
  const CustomModalWithClose({
    super.key,
    this.title,
    required this.children,
    this.titleWidget,
    this.titleColor = CustomColors.mainColor,
    this.iconColor = CustomColors.blackColor,
    this.isBoldText = true,
    this.font,
    this.onClosed,
    this.hideButton = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  title != null
                      ? CustomText(
                          title: title!,
                          color: titleColor,
                          isBoldText: isBoldText,
                          font: font,
                        )
                      : titleWidget ?? const SizedBox(),
                  hideButton
                      ? const SizedBox()
                      : CustomIconButton(
                          color: iconColor,
                          icon: closeIcon,
                          onPressed: onClosed ?? routerPop(context),
                        )
                ],
              ),
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
  final int deleteMode, id;
  final ReturnVoid? refreshPage;
  final BuildContext? reviewContext;
  const DeleteModal({
    super.key,
    required this.deleteMode,
    required this.id,
    this.refreshPage,
    this.reviewContext,
  });

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
          target = '계정';
          message = '정말 \'화장실을 찾아서\'를 떠나시나요?';
          break;
      }
    }

    void onPressed() async {
      try {
        switch (deleteMode) {
          case 0:
            ReviewProvider().deleteReview(id).then((_) {
              ToiletProvider()
                  .getToilet(getToiletId(reviewContext ?? context)!)
                  .then((data) {
                setToilet(reviewContext ?? context, data);
                refreshPage!();
              });
            });
            break;
          case 1:
            FolderProvider().deleteFolder(id).then((_) {
              changeRefresh(context);
            });
            break;
          default:
            UserProvider().deleteUser().then((_) async {
              changeToken(context, token: null, refresh: null);
              changeName(context, null);
              await UserApi.instance.unlink();
              routerPop(reviewContext ?? context)();
              showModal(
                reviewContext ?? context,
                page: const AlertModal(
                  title: '탈퇴 확인',
                  content: '탈퇴되었습니다.',
                ),
              );
            }).catchError((_) {
              routerPop(context)();
              showModal(
                context,
                page: AlertModal(
                  title: '오류 발생',
                  content: '오류가 발생해\n$target 삭제에 실패했습니다.',
                ),
              );
            });
            break;
        }
        if (!context.mounted) return;
        if (deleteMode != 2) {
          routerPop(reviewContext ?? context)();
          showModal(
            context,
            page: const AlertModal(
              title: '삭제 확인',
              content: '성공적으로 삭제 작업이 완료되었습니다.',
            ),
          );
        }
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
      buttonText: deleteMode != 2 ? '확인' : '탈퇴',
      onPressed: onPressed,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: CustomText(
              title: message,
              isCentered: true,
              fontSize: FontSize.defaultSize,
              color: CustomColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}

//* 즐겨찾기 추가 모달
class AddOrDeleteBookMarkModal extends StatefulWidget {
  final int toiletId;
  final List folderId;
  final ReturnVoid afterWork;
  const AddOrDeleteBookMarkModal({
    super.key,
    required this.toiletId,
    required this.folderId,
    required this.afterWork,
  });

  @override
  State<AddOrDeleteBookMarkModal> createState() =>
      _AddOrDeleteBookMarkModalState();
}

class _AddOrDeleteBookMarkModalState extends State<AddOrDeleteBookMarkModal> {
  Set selectedFolder = {};
  Set initialFolder = {};
  @override
  void initState() {
    super.initState();
    selectedFolder.addAll(widget.folderId);
    initialFolder.addAll(widget.folderId);
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

  void addOrDelete() {
    if (initialFolder != selectedFolder) {
      BookMarkProvider()
          .addOrDeleteToilet(
        addFolderIdList: (selectedFolder.difference(initialFolder)).toList(),
        delFolderIdList: (initialFolder.difference(selectedFolder)).toList(),
        toiletId: widget.toiletId,
      )
          .then((_) {
        changeRefresh(context);
        routerPop(context)();
        showModal(
          context,
          page: const AlertModal(
              title: '즐겨찾기 추가/삭제 완료', content: '즐겨찾기에 추가/삭제되었습니다'),
        ).then((value) {
          widget.afterWork();
        });
      }).catchError((_) {
        showModal(
          context,
          page: const AlertModal(
              title: '오류 발생', content: '오류가 발생해 작업이 처리되지 않았습니다'),
        );
      });
    }
  }

  void onClosed() {
    if (initialFolder.length == selectedFolder.length &&
        initialFolder.containsAll(selectedFolder)) {
      routerPop(context)();
    } else {
      showModal(
        context,
        page: CustomModal(
          onPressed: () {
            routerPop(context)();
            routerPop(context)();
          },
          title: '즐겨찾기 추가/삭제 취소',
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                title: '즐겨찾기 추가/삭제 작업을 종료하시겠습니까?',
                fontSize: FontSize.smallSize,
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalWithClose(
      title: '즐겨찾기 추가 / 삭제',
      iconColor: CustomColors.mainColor,
      onClosed: onClosed,
      font: kimm,
      children: [
        CustomBox(
          height: screenHeight(context) * 0.6,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 10,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: CustomBox(
                                    onTap: selectFolder(folderInfo.folderId),
                                    color: whiteColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: TextWithIcon(
                                        flex: 12,
                                        icon: selectedFolder
                                                .contains(folderInfo.folderId)
                                            ? heartIcon
                                            : emptyHeartIcon,
                                        iconColor: CustomColors.redColor,
                                        text: folderInfo.folderName,
                                        fontSize: FontSize.smallSize,
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
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                buttonColor: mainColor,
                textColor: CustomColors.whiteColor,
                fontSize: isDefaultTheme(context)
                    ? FontSize.smallSize
                    : FontSize.largeSmallSize,
                onPressed: addOrDelete,
              ),
            ),
          ],
        )
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
      Image.asset(
        naverMap,
        filterQuality: FilterQuality.high,
      ),
      Image.asset(
        kakaoMap,
        filterQuality: FilterQuality.high,
      ),
      Image.asset(
        tMap,
        filterQuality: FilterQuality.high,
      )
    ];
    List<Uri> uriList = [
      Uri.parse(
          'nmap://route/car?slat=${startPoint[0]}&slng=${startPoint[1]}&sname=현위치&dlat=${endPoint[0]}&dlng=${endPoint[1]}&dname=$destination&appname=$packageNmae'),
      Uri.parse(
          'kakaomap://route?sp=${startPoint[0]},${startPoint[1]}&ep=${endPoint[0]},${endPoint[1]}&by=CAR'),
      Uri.parse(
          'tmap://route?goalname=$destination&goalx=${endPoint[1]}&goaly=${endPoint[0]}')
    ];

    StringList packageNameList = [
      'com.nhn.android.nmap',
      'net.daum.android.map',
      'com.skt.tmap.ku'
    ];
    ReturnVoid toMapApp(int i) {
      return () async {
        try {
          await launchUrl(uriList[i]);
        } catch (error) {
          await launchUrl(
            Uri.parse('market://details?id=${packageNameList[i]}'),
          );
        }
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
                      fontSize: FontSize.smallSize,
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
  final double? width;
  const AlertModal({
    super.key,
    required this.title,
    required this.content,
    this.onPressed,
    this.width,
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
          fontSize: FontSize.smallSize,
        )
      ],
    );
  }
}

//* 로그인 확인 모달
class LoginConfirmModal extends StatelessWidget {
  final ReturnVoid afterLogin;
  final bool showReview, isMain;
  final int? toiletId;
  final Widget? page;
  const LoginConfirmModal({
    super.key,
    required this.showReview,
    required this.isMain,
    this.toiletId,
    required this.afterLogin,
    this.page,
  });

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
        //* login

        final newContext = getKey(context)?.currentContext;
        login(newContext ?? context).then((_) {
          afterLogin();
          routerPop(context)();
        });
      },
    );
  }
}

//* 오류 발생 alert
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

//* 회원가입 수집 정보
class JoinModal extends StatefulWidget {
  final ReturnVoid refreshPage;
  final bool showReview;
  final int? toiletId;
  final BuildContext? pageContext;
  const JoinModal({
    super.key,
    required this.refreshPage,
    required this.showReview,
    this.toiletId,
    this.pageContext,
  });

  @override
  State<JoinModal> createState() => _JoinModalState();
}

class _JoinModalState extends State<JoinModal> {
  bool checked = false;
  void changeChecked() {
    setState(() {
      checked = !checked;
    });
  }

  void joinOrLogin() {
    if (checked) {
      setJoin(context);
    }
    final newContext = widget.pageContext ?? getKey(context)?.currentContext;
    login(newContext ?? context).then((result) {
      widget.refreshPage();
    });
    routerPop(context)();
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalWithClose(
      titleColor: CustomColors.mainColor,
      iconColor: CustomColors.mainColor,
      crossAxisAlignment: CrossAxisAlignment.start,
      titleWidget: RichText(
        text: TextSpan(
          text: '화장실을 찾아서',
          style: titleStyle(color: mainColor),
          children: [
            TextSpan(
              text: '는\n회원가입하실 때\n이런 정보를\n제공 받아요!',
              style: titleStyle(),
            ),
          ],
        ),
      ),
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      CustomText(
                        title: '수집 정보 : 이름, 이메일',
                        fontSize: FontSize.smallSize,
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      CustomText(
                        title: '수집 이유 : 회원 식별',
                        fontSize: FontSize.smallSize,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(linkIcon, color: mainColor),
                        ),
                        TextSpan(
                          text: '개인 정보 및 위치 처리방침',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showModal(
                                context,
                                page: const PolicyModal(),
                              );
                            },
                          style: TextStyle(
                            height: 1.5,
                            color: mainColor,
                            decoration: TextDecoration.underline,
                            fontSize: isDefaultTheme(context)
                                ? smallSize
                                : largeSmallSize,
                          ),
                        ),
                        TextSpan(
                          text: '을 통해 더 자세히 확인하실 수 있어요',
                          style: TextStyle(
                            height: 1.5,
                            color: blackColor,
                            fontSize: isDefaultTheme(context)
                                ? smallSize
                                : largeSmallSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: GestureDetector(
                      onTap: changeChecked,
                      child: TextWithIcon(
                        icon: checked ? checkedIcon : circleIcon,
                        text: '다시 보지 않기',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          onPressed: routerPop(context),
                          buttonText: '취소',
                          buttonColor: greyColor,
                          textColor: CustomColors.whiteColor,
                        ),
                        CustomButton(
                          onPressed: joinOrLogin,
                          buttonText: '회원가입',
                          buttonColor: mainColor,
                          textColor: CustomColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle titleStyle({Color? color}) => TextStyle(
        color: color ?? blackColor,
        fontFamily: kimm,
        fontSize: isDefaultTheme(context) ? defaultSize : largeDefaultSize,
        height: 1.3,
      );
}
