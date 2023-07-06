import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  final bool showReview;
  final int? toiletId;
  final ReturnVoid refreshPage;
  const Settings({
    super.key,
    required this.showReview,
    this.toiletId,
    required this.refreshPage,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool hasToken;
  @override
  void initState() {
    super.initState();
    hasToken = readToken(context) != null;
  }

  //* 모달 목록
  WidgetList pages = [
    const PolicyModal(),
    const HelpModal(isHelpModal: false),
    const HelpModal()
  ];

  //* 문의하기
  void sendEmail() async {
    String? emailBody;
    try {
      emailBody = await body();
      final Email email = Email(
        subject: '[화장실을 찾아서] 문의사항',
        recipients: ['team.4ilet@gmail.com'],
        body: emailBody,
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    } catch (error) {
      showModal(
        context,
        page: AlertModal(
          title: '문의하기',
          content: emailBody ?? inquiryBody(),
          onPressed: () => Clipboard.setData(
            ClipboardData(text: emailBody ?? inquiryBody()),
          ),
        ),
      );
    }
  }

  //* 로그인/로그아웃
  void loginOrLogout() async {
    try {
      final token = readToken(context);
      if (token == null || token == '') {
        if (hideModal(context)) {
          login(context).then((result) {});
        } else {
          showModal(
            context,
            page: JoinModal(
              showReview: widget.showReview,
              toiletId: widget.toiletId,
              refreshPage: widget.refreshPage,
              pageContext: context,
            ),
          );
        }
      } else {
        changeToken(context, token: null, refresh: null);
        changeName(context, null);
      }
    } catch (error) {
      setLoading(context, false);
      showModal(
        context,
        page: const AlertModal(
          title: '오류 발생',
          content: '카카오톡 로그인 오류가 발생했습니다.',
        ),
      );
    }
  }

  String optionTitle(int i) {
    switch (i) {
      case 0:
        return context.watch<SettingsProvider>().magnigyState;
      case 1:
        return context.watch<SettingsProvider>().fontState;
      default:
        return context.watch<SettingsProvider>().radiusState;
    }
  }

  final StringList menuList = [
    '확대/축소 버튼',
    '글자 크기',
    '지도 반경',
    '문의하기',
    '개인/위치 정보 처리 방침',
    '라이선스',
    '도움말'
  ];
  final IconDataList iconList = [
    scaleIcon,
    fontIcon,
    gpsIcon,
    inquiryIcon,
    policyIcon,
    licenseIcon,
    helpIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: GestureDetector(
          onHorizontalDragEnd: (_) {
            routerPop(context)();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: getToken(context) != null
                          ? CustomButton(
                              textColor: CustomColors.blackColor,
                              fontSize: FontSize.smallSize,
                              onPressed: () {
                                showModal(
                                  context,
                                  page: const NicknameInputModal(
                                    isAlert: false,
                                  ),
                                );
                              },
                              buttonText: '닉네임 변경',
                            )
                          : const SizedBox(),
                    ),
                    Flexible(
                      flex: 5,
                      child: GestureDetector(
                        onTap: loginOrLogout,
                        child: getToken(context) != null
                            ? TextWithIcon(
                                icon: logoutIcon,
                                text: '로그아웃',
                                iconColor: CustomColors.blackColor,
                                fontSize: getThemeState(context) == '기본'
                                    ? FontSize.defaultSize
                                    : FontSize.largeDefaultSize,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                applyTheme: false,
                              )
                            : Image.asset(kakaoLogin),
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                flex: 2,
                child: CustomText(
                  title: '어떤 것을 원하시나요?',
                  fontSize: FontSize.largeSize,
                  color: CustomColors.mainColor,
                  font: kimm,
                ),
              ),
              Flexible(
                flex: 14,
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i += 1)
                      eachMenu(
                        index: i,
                        onTap: () => changeOptions(context, i),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        child: option(i),
                      ),
                    eachMenu(
                      index: 3,
                      onTap: sendEmail,
                    ),
                    for (int i = 4; i < 7; i += 1)
                      eachMenu(
                        index: i,
                        onTap: () => showModal(
                          context,
                          page: pages[i - 4],
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExitPage(
                      color: CustomColors.blackColor,
                      onTap: routerPop(context),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget option(int i) {
    return CustomText(
      title: optionTitle(i),
      fontSize: FontSize.defaultSize,
      color: CustomColors.mainColor,
      font: kimm,
    );
  }

  GestureDetector eachMenu({
    required int index,
    Widget? child,
    required ReturnVoid onTap,
    MainAxisAlignment? mainAxisAlignment,
    int? flex,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment:
              mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextWithIcon(
                icon: iconList[index],
                text: menuList[index],
                iconColor: CustomColors.blackColor,
                fontSize: FontSize.defaultSize,
                font: kimm,
                flex: 15,
              ),
            ),
            child ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
