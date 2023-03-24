import 'package:device_info_plus/device_info_plus.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/settings_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/button.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:find_toilet/widgets/modal.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ReturnVoid changeIndex(int i) {
    return () {
      setState(() {
        if (indexList[i] < optionList[i].length - 1) {
          indexList[i] += 1;
        } else {
          indexList[i] = 0;
        }
      });
    };
  }

  void sendEmail() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final info = deviceInfo.data;
      final version = info['version'];
      final manufacturer = info['manufacturer'];
      final model = info['model'];
      final device = info['device'];

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;

      final Email email = Email(
        subject: '[화장실을 찾아서 문의]',
        recipients: ['team.4ilet@gmail.com'],
        body: body(
          release: version['release'],
          sdkInt: version['sdkInt'],
          manufacturer: manufacturer,
          model: model,
          device: device,
          appVersion: appVersion,
        ),
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } catch (error) {
      showModal(context, page: errorModal('email'))();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => UserProvider().login(context),
                    child: accessToken == ''
                        ? Image.asset(kakaoLogin)
                        : const TextWithIcon(
                            icon: logoutIcon,
                            text: '로그아웃',
                            iconColor: CustomColors.blackColor,
                            fontSize: FontSize.defaultSize,
                          ),
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
              ),
            ),
            Flexible(
              flex: 6,
              child: Column(
                children: [
                  for (int i = 0; i < 3; i += 1)
                    eachMenu(
                      index: i,
                      onTap: changeIndex(i),
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
                      onTap: showModal(
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
    );
  }

  Widget option(int i) {
    return i < 2
        ? CustomText(
            title: optionList[i][indexList[i]],
            fontSize: FontSize.defaultSize,
            color: CustomColors.mainColor,
            font: kimm,
          )
        : Row(
            children: [
              const CustomIcon(
                icon: toLeftIcon,
                color: mainColor,
              ),
              CustomText(
                title: optionList[i][indexList[i]],
                font: kimm,
                fontSize: FontSize.defaultSize,
                color: CustomColors.mainColor,
              ),
              const CustomIcon(
                icon: toRightIcon,
                color: mainColor,
              ),
            ],
          );
  }

  GestureDetector eachMenu(
      {required int index,
      Widget? child,
      required ReturnVoid onTap,
      MainAxisAlignment? mainAxisAlignment}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: [
            TextWithIcon(
              icon: iconList[index],
              text: menuList[index],
              iconColor: CustomColors.blackColor,
              fontSize: FontSize.defaultSize,
              font: kimm,
            ),
            child ?? const SizedBox()
          ],
        ),
      ),
    );
  }

  CustomModal errorModal(String feature) {
    const emailError =
        '문의 메일 전송 오류가 발생했습니다.\n gmail앱이 존재하지 않거나, \n기타 오류 때문일 수 있습니다. \n 문의사항은 아래 이메일로 연락주세요 \n team.4ilet@gmail.com';
    const loginError = '카카오톡 로그인 오류가 발생했습니다.';
    return CustomModal(
      title: '오류 발생',
      isAlert: true,
      children: [
        CustomText(
          title: feature == 'email' ? emailError : loginError,
          fontSize: FontSize.defaultSize,
        ),
      ],
    );
  }
}
