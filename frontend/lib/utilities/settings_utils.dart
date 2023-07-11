//* 모달 목록

//* 모달 내부 내용
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

const privatePolicy = '''
<p>내용</p>
''';
const gpsPolicy = '서비스 제공자(포일렛)은 사용자의 위치 정보를';
const license = '''
<p>글꼴<p><span>한국기계연구원 서체,</span>\n한국기계연구원,\nkimm.re.kr/webfont</p><p><span>Noto Sans</span>,\nGoogle Fonts,\nhttps://fonts.google.com/noto/specimen/Noto+Sans+KR</p></p>
''';

//* 문의하기 내부 내용
String inquiryBody() {
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

화장실을 찾아서 개발팀 (team.4ilet@gmail.com)
''';
  } catch (error) {
    throw Error();
  }
}
