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
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Widget loginOrLogoutBtn;

  @override
  void initState() {
    super.initState();
    changeBtn();
  }

  //* 모달 목록
  WidgetList pages = [
    const PolicyModal(),
    const HelpModal(isHelpModal: false),
    const HelpModal()
  ];

  //* 버튼 변경
  bool changeBtn() {
    final token = getToken(context);
    setState(() {
      loginOrLogoutBtn = token == null || token == ''
          ? Image.asset(kakaoLogin)
          : const TextWithIcon(
              icon: logoutIcon,
              text: '로그아웃',
              iconColor: CustomColors.blackColor,
              fontSize: FontSize.defaultSize,
            );
    });
    return true;
  }

  //* 문의하기
  void sendEmail() async {
    try {
      final Email email = Email(
        subject: '[화장실을 찾아서] 문의사항',
        recipients: ['team.4ilet@gmail.com'],
        body: await body(),
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } catch (error) {
      showModal(context, page: errorModal('email'));
    }
  }

  //* 로그인/로그아웃
  FutureBool loginOrLogout() async {
    try {
      final token = getToken(context);
      if (token == null || token == '') {
        await login(context);
        changeBtn();
      } else {
        if (!mounted) return false;
        changeToken(context, token: null, refresh: null);
      }
      return changeBtn();
    } catch (error) {
      showModal(context, page: errorModal('login'));
      changeRefresh(context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: GestureDetector(
          onHorizontalDragEnd: (_) {
            routerPop(context)();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      textColor: CustomColors.blackColor,
                      fontSize: FontSize.smallSize,
                      onPressed: () {
                        showModal(
                          context,
                          page: const InputModal(
                            title: '닉네임 설정',
                            buttonText: '확인',
                            isAlert: false,
                            kindOf: 'nickname',
                          ),
                        );
                      },
                      buttonText: '닉네임 변경',
                    ),
                    GestureDetector(
                      onTap: () => loginOrLogout(),
                      child: loginOrLogoutBtn,
                    ),
                  ],
                ),
              ),
              const Flexible(
                  flex: 1,
                  child: CustomText(
                    title: '어떤 것을 원하시나요?',
                    fontSize: FontSize.largeSize,
                    color: CustomColors.mainColor,
                    font: kimm,
                  )),
              Flexible(
                flex: 6,
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
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    ExitPage(color: CustomColors.blackColor),
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
    String optionTitle() {
      switch (i) {
        case 0:
          return context.watch<SettingsProvider>().magnigyState;
        case 1:
          return context.watch<SettingsProvider>().fontState;
        default:
          return context.watch<SettingsProvider>().radiusState;
      }
    }

    return CustomText(
      title: optionTitle(),
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
  }) {
    const StringList menuList = [
      '확대/축소 버튼',
      '글자 크기',
      '지도 반경',
      '문의하기',
      '개인 정보 및 위치 처리 방침',
      '라이선스',
      '도움말'
    ];
    const IconDataList iconList = [
      scaleIcon,
      fontIcon,
      gpsIcon,
      inquiryIcon,
      policyIcon,
      licenseIcon,
      helpIcon,
    ];
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
                flex: 20,
              ),
            ),
            child ?? const SizedBox()
          ],
        ),
      ),
    );
  }

  CustomModal errorModal(String feature) {
    const loginError = '카카오톡 로그인 오류가 발생했습니다.';
    return CustomModal(
      title: '오류 발생',
      isAlert: true,
      children: [
        CustomText(
          title: feature == 'email' ? errorBody() : loginError,
          fontSize: FontSize.defaultSize,
        ),
      ],
    );
  }
}
