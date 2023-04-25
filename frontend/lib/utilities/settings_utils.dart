import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/modal.dart';

//* 메뉴 목록
final StringList menuList = [
  '확대/축소 버튼',
  '글자 크기',
  '지도 반경',
  '문의하기',
  '개인 정보 및 위치 처리 방침',
  '라이선스',
  '도움말'
];

//* 메뉴 옆에 표시되는 아이콘 목록
final IconDataList iconList = [
  scaleIcon,
  fontIcon,
  gpsIcon,
  inquiryIcon,
  policyIcon,
  licenseIcon,
  helpIcon,
];

//* 옵션 목록
final List<StringList> optionList = [
  ['표시 안 함', '표시함'],
  ['큰 글씨', '기본'],
  ['300m', '500m', '700m'],
];

//* 옵션 인덱스 목록
IntList indexList = [0, 0, 0];

//* 모달 목록
WidgetList pages = [
  const PolicyModal(),
  const HelpModal(isHelpModal: false),
  const HelpModal()
];

//* 모달 내부 내용
const privatePolicy = '서비스 제공자(포일렛)은 사용자의 개인 정보를';
const gpsPolicy = '서비스 제공자(포일렛)은 사용자의 위치 정보를';
const license = '글꼴\n위치 정보';

//* 문의하기 내부 내용
String body({
  required String release,
  required int sdkInt,
  required String manufacturer,
  required String model,
  required String device,
  required String appVersion,
}) =>
    '''
안녕하세요, 화장실을 찾아서 개발팀입니다.\n
저희 서비스에 관심을 보내주셔서 감사합니다.\n
아래 양식에 맞추어 문의사항을 작성해 주시면 빠르게 검토하여 답변 드리겠습니다.\n
카테고리 : 오류 / 기능 제안 / 기타\n
답변 받으실 이메일 : \n
문의 내용 : \n
OS 버전: Android $release (SDK $sdkInt)
사용 기종 : $manufacturer $model $device \n
사용 버전 : $appVersion \n
''';
