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

//* 첫 방문 여부
var isFirstVisit = true;
//* access token
var accessToken = '';
//* 테마
var theme = Themes.defaultFont;
//* 지도 반경
var mapRadius = MapRadius.three;

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
제목 말머리로 [오류]/[문의]/[제안]/[기타] 중 한 가지를 작성해주세요.\n
문의 사항
\n\n\n\n
--------------------
OS 버전: Android $release (SDK $sdkInt)
기기: $manufacturer $model $device
앱 버전: $appVersion
''';
