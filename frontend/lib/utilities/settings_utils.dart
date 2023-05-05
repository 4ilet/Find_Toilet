//* 모달 목록

//* 모달 내부 내용
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

const privatePolicy = '서비스 제공자(포일렛)은 사용자의 개인 정보를';
const gpsPolicy = '서비스 제공자(포일렛)은 사용자의 위치 정보를';
const license = '글꼴\n위치 정보';

//* 오류 시 문의하기 내부 내용
String errorBody() {
  return '''안녕하세요, 화장실을 찾아서 개발팀입니다.\n
저희 서비스에 관심을 보내주셔서 감사합니다.\n
아래 양식에 맞추어 team.4ilet@gmail.com에
문의사항을 보내 주시면 빠르게 검토하여 답변 드리겠습니다.\n
카테고리 : 오류 / 기능 제안 / 기타\n
답변 받으실 이메일 : \n
문의 내용 : \n
''';
}

//* 문의하기 내부 내용
Future<String> body() async {
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
    return '''
안녕하세요, 화장실을 찾아서 개발팀입니다.\n
저희 서비스에 관심을 보내주셔서 감사합니다.\n
아래 양식에 맞추어 문의사항을 작성해 주시면 빠르게 검토하여 답변 드리겠습니다.\n
카테고리 : 오류 / 기능 제안 / 기타\n
답변 받으실 이메일 : \n
문의 내용 : \n
OS 버전: Android ${version['release']} (SDK ${version['sdkInt']})
사용 기종 : $manufacturer $model $device \n
사용 버전 : $appVersion \n
''';
  } catch (error) {
    throw Error();
  }
}
