//* 모달 목록

//* 모달 내부 내용
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

const privacyPolicy = '''
<article id="f226de8e-69fc-40ab-ad37-1981c64182da" class="page sans"><h3 class="page-title">개인 정보 처리 방침</h3><div class="page-body"><p id="a25895c8-a2a3-4c71-b654-b64ad3d75cc5" class=""><strong>화장실을 찾아서(이하 &quot;포일렛&quot;)</strong>는 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다. 이 개인정보처리방침은2023년 1월 1일부터 적용됩니다.</p><p id="2df8c863-31fc-4c56-af62-7773be098613" class="">
</p><h3 id="56148bd8-1842-45f8-a9ef-ab454404cd43" class="">제 1 조 (개인정보의 처리 목적)</h3><p id="ee06ea37-21f0-44f6-8d98-032d5aed863e" class="">포일렛은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</p><p id="db34d9ae-9258-47e0-81fb-baf5de16d833" class="">1. 홈페이지 회원가입 및 관리<div class="indented"><ul id="8f370cf8-57dd-43d7-a6c4-4750ae15290c" class="bulleted-list"><li style="list-style-type:disc">회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정이용 방지 목적으로 개인정보를 처리합니다.</li></ul></div></p><p id="ab999aaf-7076-4bec-97ad-5ee0b0a78dbd" class="">2. 재화 또는 서비스 제공<div class="indented"><ul id="28ee3942-88c9-45ce-9387-73e54731263a" class="bulleted-list"><li style="list-style-type:disc">서비스 제공, 맞춤서비스 제공, 본인인증을 목적으로 개인정보를 처리합니다.</li></ul></div></p><p id="b43c92b7-0c41-4786-8059-3a8736170fb3" class="">
</p><h3 id="a9ce05be-7eef-48ba-8a88-7477463d2d72" class="">제 2 조 (개인정보의 처리 및 보유 기간)</h3><p id="7bcd318e-7079-4cca-aea7-2ccf2269d7f5" class="">포일렛은 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.</p><p id="c73e7486-09d0-412e-80ff-69c253e38d9e" class="">각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.</p><ol type="1" id="bcc452a3-8c4b-4688-b7a4-b52aab082fcc" class="numbered-list" start="1"><li>홈페이지 회원가입 및 관리<ul id="ad9d9dbd-4a46-4e46-aca7-b04b08107f61" class="bulleted-list"><li style="list-style-type:disc">홈페이지 회원가입 및 관리와 관련한 개인정보는 수집.이용에 관한 동의일로부터&lt;지체없이 파기&gt;까지 위 이용목적을 위하여 보유.이용됩니다.</li></ul><ul id="50cf1eb7-3682-423a-8cc3-c52ac59f5ae6" class="bulleted-list"><li style="list-style-type:disc">보유근거 : 고객 가입 및 관리</li></ul></li></ol><p id="49f58a88-8407-48d7-b027-9e8b49d4d2e6" class="">
</p><h3 id="f50db14f-b2dc-4db3-86e6-b84dd72988da" class="">제 3 조 (처리하는 개인정보의 항목)</h3><p id="115a9cbb-c10a-4fce-9118-05a288089893" class="">포일렛은 다음의 개인정보 항목을 처리하고 있습니다.</p><ol type="1" id="b706578c-4e5e-4fde-bfef-d523d0ef4d23" class="numbered-list" start="1"><li>홈페이지 회원가입 및 관리<ul id="8b950818-70ae-4ab5-a881-e5e41b5a4f0a" class="bulleted-list"><li style="list-style-type:disc">필수항목 : 이름, 비밀번호, 이메일</li></ul></li></ol><p id="2e5bc3e9-e871-4761-b85d-2aac81728bc8" class="">이 약관에 명시되지 않은 사항에 대해서는 위치 정보의 보호 및 이용 등에 관한 법률, 개인정보보호법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관계법령 및 포일렛이 정한 지침 등의 규정에 따릅니다.</p><h3 id="da3d386f-536c-465e-8528-49ca6b3e5f53" class="">제 4 조 (개인정보의 파기절차 및 파기방법)</h3><p id="d1d3037c-c94d-4e5f-8be8-32160ffdb43d" class="">① 포일렛은 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.</p><p id="e83eb13b-55ef-4860-ac5f-cc0cb95d0dcb" class="">② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.</p><p id="8a24cf1a-467e-4510-a93a-7bead3ad1640" class="">1. 법령 근거 :</p><p id="248531b4-c365-44a3-9474-c90060499a6c" class="">2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜</p><p id="e227d894-235f-4225-b0a4-436740bde764" class="">
</p><p id="448ad819-6702-4dcd-8267-0adf8b77c689" class="">③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.</p><p id="7236120e-0b23-4bfa-9882-660f997fc3eb" class="">1. 파기절차</p><p id="28e4913a-e96e-46a9-8da9-90f55ff48eac" class="">포일렛은 파기 사유가 발생한 개인정보를 선정하고, 포일렛 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.</p><p id="5b03a3aa-9cbe-458e-a52c-5e7dd90d72cc" class="">2. 파기방법</p><p id="4c9d9001-2477-41f3-8805-7f748e5371fb" class="">전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다</p><h3 id="2a2bea44-4bf0-4712-8478-45445cd99512" class="">제 5 조 (서비스 이용요금)</h3><p id="09ceea46-865e-4410-93a7-a06c52e294d2" class="">포일렛이 제공하는 위치기반서비스는 무료입니다. 단, 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며, 이용자가 가입한 각 이동통신사의 정책에 따릅니다.</p><p id="25ef64e2-dcc0-4af1-8340-c07935a36b92" class="">
</p><h3 id="a4b0953e-0da9-47b7-bcda-c7d4055f611d" class="">제 6 조 (개인정보의 안전성 확보조치에 관한 사항)</h3><p id="6ee005ec-faad-4be0-9f99-71dce3a538b5" class="">포일렛은 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.</p><p id="eb4ecc2a-d1d3-4667-b483-2de2affbb567" class="">1. 내부관리계획의 수립 및 시행</p><p id="6a3e4ec3-4a71-4c5c-b9aa-49e028ba7a66" class="">개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.</p><p id="d0b55a85-ba0b-4874-983d-ffbe0931b8e5" class="">2. 개인정보 취급 직원의 최소화 및 교육</p><p id="1497c2cc-ce00-49e9-8e6b-a1cad2496432" class="">개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.</p><p id="5f1274e3-a660-479b-90cb-299e8aeb287e" class="">3. 정기적인 자체 감사 실시</p><p id="faae95c3-38bf-40aa-b613-ceb4487e9ea2" class="">개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.</p><p id="a35a2629-fc56-42a0-91c8-f14cc8f62c3d" class="">
</p><h3 id="2c977b55-8aa6-469e-9e56-f9507ac7233c" class="">제 7 조 (개인정보를 자동으로 수집하는 장치의 설치·운영 및 그 거부에 관한 사항)</h3><p id="5b6f8456-e267-42c5-b5c7-db87cb59b187" class="">① 포일렛 은(는) 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.</p><p id="6a5ae87e-0e30-4cee-9ee3-2309efbb584a" class="">② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.</p><p id="fe247472-5413-4820-b852-0bc85d85dd3e" class="">가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.</p><p id="6dcdce2e-5b12-4485-8acc-4c6958dfe9e0" class="">나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구&gt;인터넷 옵션&gt;개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.</p><p id="7e85bd7d-f990-43c2-a45a-8c38293ec1a4" class="">다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.</p><p id="54f0cebc-e281-4541-8cab-f29d005f3555" class="">
</p><h3 id="572509f9-6a3e-475f-a5ed-06199a0e4867" class="">제 8 조 (개인정보 보호책임자에 관한 사항)</h3><p id="a120c655-90f5-4f6f-956e-ec9fde2e858a" class="">① 포일렛은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</p><p id="83cd6598-6749-429b-b7dc-22a4d9238698" class="">▶ 개인정보 보호책임자</p><ul id="e2a8e61e-25e0-4528-b03d-c97d12c42d5a" class="bulleted-list"><li style="list-style-type:disc">성명 : 나장엽</li></ul><ul id="f6c9af1f-d4f0-4af0-a167-b78ebdb7ee88" class="bulleted-list"><li style="list-style-type:disc">직책 : 개발자</li></ul><ul id="b8184cc4-9dac-437e-9060-e7d24fd7c850" class="bulleted-list"><li style="list-style-type:disc">직급 : 개발자</li></ul><ul id="bb99b30d-5d64-42ca-8c31-ca5e9ba7d2c5" class="bulleted-list"><li style="list-style-type:disc">연락처 : 01046705324, team.4ilet@gmail.com</li></ul><p id="7d2b3348-65f5-40de-998f-f0ede119d1fb" class="">
</p><p id="48cd8e17-d9f1-4b98-bb13-92b064078635" class="">② 정보주체께서는 포일렛 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 포일렛은 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.</p><h3 id="7e7b176e-56b9-4ec5-ba8d-337fec109842" class="">제 9 조 (개인정보의 열람청구를 접수·처리하는 부서)</h3><p id="c5857e7e-761e-4e34-b6d6-c25ba62bdc0d" class="">정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 포일렛은 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.</p><p id="88624526-3ff1-4d81-9590-c691d1f85b5a" class="">▶ 개인정보 열람청구 접수·처리 부서</p><ul id="34d85d3b-b844-4467-b75d-5ccf3b6727d2" class="bulleted-list"><li style="list-style-type:disc">부서명 :</li></ul><ul id="d1953d74-8fd6-4e97-bd1e-ac3bc350ac7a" class="bulleted-list"><li style="list-style-type:disc">담당자 :</li></ul><ul id="a3bf8f37-a97a-4ea1-a5fa-cc41f6c6250e" class="bulleted-list"><li style="list-style-type:disc">연락처 :</li></ul><p id="6ab7f916-2fb1-4000-a14e-a8e70a204045" class="">
</p><h3 id="6146fb24-63d1-4882-8102-77f4fae3b4ab" class="">제10조(정보주체의 권익침해에 대한 구제방법)</h3><p id="0c2af609-670b-4d16-af75-6f63b397efc2" class="">정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.</p><ol type="1" id="86d41649-e8d7-4070-97be-74c1c4cf50dd" class="numbered-list" start="1"><li>개인정보분쟁조정위원회 : (국번없이) 1833-6972 (<a href="http://www.kopico.go.kr/">www.kopico.go.kr</a>)</li></ol><ol type="1" id="826ac6e5-8401-475e-a312-a62b29b90b1c" class="numbered-list" start="2"><li>개인정보침해신고센터 : (국번없이) 118 (<a href="http://privacy.kisa.or.kr/">privacy.kisa.or.kr</a>)</li></ol><ol type="1" id="827df1e0-594c-4312-9b2b-04d4b2692742" class="numbered-list" start="3"><li>대검찰청 : (국번없이) 1301 (<a href="http://www.spo.go.kr/">www.spo.go.kr</a>)</li></ol><ol type="1" id="47605c23-0633-4396-bc0f-cde80138aa11" class="numbered-list" start="4"><li>경찰청 : (국번없이) 182 (<a href="http://ecrm.cyber.go.kr/">ecrm.cyber.go.kr</a>)</li></ol><p id="46e5a593-3401-4389-8ed7-fb69a77ca3e2" class="">
</p><p id="cef4a4c6-50ff-4b10-bb5a-2767a03bb8a6" class="">「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.</p><p id="f573c5b7-8966-4a59-b5b9-e2b5069781b9" class="">
</p><p id="8a3df7ed-ac20-45e7-9898-dde0f70e5aa8" class="">※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(<a href="http://www.simpan.go.kr/">www.simpan.go.kr</a>) 홈페이지를 참고하시기 바랍니다.</p><p id="101a0a10-4e93-4407-bd4f-bc8a60684dd5" class="">
</p><h3 id="1e298680-9f5e-4327-aca3-fbdb2cd98f46" class="">제11조(개인정보 처리방침 변경)</h3><p id="5f5d34fb-af45-416a-9fd7-fe621774c047" class="">① 이 개인정보처리방침은 2023년 1월 1부터 적용됩니다.</p><p id="44fc9cf5-cc25-4d8d-a32a-29a35b7b32a2" class="">② 이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다. </p><p id="4f7f1330-e2dd-4b3e-a2ea-0d298371e499" class="">2023. 1. 1 ~ (현재)</p><p id="008caab8-afcf-4060-a6bb-fa744e945c3d" class="">
</p></div></article>
''';
const gpsPolicy = '''
<article id="e6ad8490-9696-417a-a61c-cdcd27d44967" class="page sans"><h3 class="page-title">위치 정보 처리 방침</h3><div class="page-body"><h3 id="ec00d917-d129-42c5-bdca-d70258b4a206" class="">제 1 조 (목적)</h3><p id="4bd8ee97-ddf9-43ab-8fcd-5ade2a6dbd87" class="">본 약관은 화장실을찾아서가(이하 &quot;포일렛&quot;)가 제공하는 위치기반서비스에 대해 포일렛과 위치기반서비스를 이용하는 개인위치정보주체(이하 &quot;이용자&quot;)간의 권리·의무 및 책임사항, 기타 필요한 사항 규정을 목적으로 합니다.</p><h3 id="3494adba-fbc5-4e22-8826-93cd47bf9f49" class="">제 2 조 (이용약관의 효력 및 변경)</h3><ul id="3ec9296f-c497-4a76-8dcc-f9a9f11df8b3" class="bulleted-list"><li style="list-style-type:disc">①본 약관은 이용자가 본 약관에 동의하고 포일렛이 정한 절차에 따라 위치기반서비스의 이용자로 등록됨으로써 효력이 발생합니다.</li></ul><ul id="bfb029da-6c1a-4c60-9591-ad6bd71a0d27" class="bulleted-list"><li style="list-style-type:disc">②이용자가 본 약관의 “동의하기” 버튼을 클릭하였을 경우 본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다.</li></ul><ul id="6621a2ec-e140-44a2-a008-6b7c3c38a51d" class="bulleted-list"><li style="list-style-type:disc">③포일렛은 위치기반서비스의 변경사항을 반영하기 위한 목적 등으로 필요한 경우 관련 법령을 위배하지 않는 범위에서 본 약관을 수정할 수 있습니다.</li></ul><ul id="c49b25e5-a1b7-45ad-a927-bd84a3f3ac34" class="bulleted-list"><li style="list-style-type:disc">④약관이 변경되는 경우 포일렛은 변경사항을 그 적용일자 최소 15일 전에 회사의 홈페이지 또는 서비스 공지사항 등(이하, 홈페이지 등)을 통해 공지합니다. 다만, 개정되는 내용이 이용자 권리의 중대한 변경을 발생시키는 경우 적용일 최소 30일 전에 이메일(이메일주소가 없는 경우 서비스 내 전자쪽지 발송, 서비스 내 알림 메시지를 띄우는 등의 별도의 전자적 수단) 발송 또는 등록한 휴대폰번호로 카카오톡 메시지 또는 문자메시지를 발송하는 방법 등으로 개별적으로 고지합니다.</li></ul><ul id="baa64ea6-f4b0-4681-a746-c6f23cf5060f" class="bulleted-list"><li style="list-style-type:disc">⑤포일렛이 전항에 따라 공지 또는 통지를 하면서 공지 또는 통지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 이용자의 의사표시가 없는 경우에는 변경된 약관을 승인한 것으로 봅니다. 이용자가 개정약관에 동의하지 않을 경우 본 약관에 대한 동의를 철회할 수 있습니다.</li></ul><h3 id="d41aed3c-b462-4924-92e4-9d2b4035704d" class="">제 3 조 (약관 외 준칙)</h3><p id="982efd1b-2fe0-4ebd-af03-4e590dc1d5b6" class="">이 약관에 명시되지 않은 사항에 대해서는 위치 정보의 보호 및 이용 등에 관한 법률, 개인정보보호법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관계법령 및 포일렛이 정한 지침 등의 규정에 따릅니다.</p><h3 id="913767c1-6c08-4c25-b905-9d04f5e1c455" class="">제 4 조 (서비스의 내용)</h3><p id="d2334e51-8bf4-4865-964c-2e001df46c74" class="">포일렛은 위치정보사업자 등으로부터 수집한 이용자의 위치정보를 이용하여 아래와 같은 위치기반서비스를 제공합니다.</p><ul id="849a3f55-ce95-4934-85f4-0d44a9b93239" class="bulleted-list"><li style="list-style-type:disc">①위치정보를 활용한 정보 검색결과 및 콘텐츠를 제공</li></ul><h3 id="11b2f64b-bd74-4b1e-ac0d-66db00bccec1" class="">제 5 조 (서비스 이용요금)</h3><p id="1d0fb5ed-802f-470a-a85d-8f9893ecfa9a" class="">포일렛이 제공하는 위치기반서비스는 무료입니다.단, 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며, 이용자가 가입한 각 이동통신사의 정책에 따릅니다.</p><h3 id="81d7baf0-98f3-488d-9ef8-1bbfb8848536" class="">제 6 조 (서비스의 변경・제한・중지)</h3><ul id="cb97832c-40bf-42a0-92d7-5373ae45ee17" class="bulleted-list"><li style="list-style-type:disc">①포일렛은 정책변경 또는 관련법령 변경 등과 같은 제반 사정을 이유로 위치기반서비스를 유지할 수 없는 경우 위치기반서비스의 전부 또는 일부를 변경·제한·중지할 수 있습니다.</li></ul><ul id="115a5c26-cbb9-4ab5-80c6-d1450771bad2" class="bulleted-list"><li style="list-style-type:disc">②포일렛은 아래 각호의 경우에는 이용자의 서비스 이용을 제한하거나 중지시킬 수 있습니다.<ul id="5a621782-9cf6-4026-9c09-e2ba9341f721" class="bulleted-list"><li style="list-style-type:circle">1.이용자가 포일렛 서비스의 운영을 고의 또는 중과실로 방해하는 경우</li></ul><ul id="b7565cfd-08e2-4411-b8fc-94e535f7756e" class="bulleted-list"><li style="list-style-type:circle">2.서비스용 설비 점검, 보수 또는 공사로 인하여 부득이한 경우</li></ul><ul id="58fddbc6-dc21-4c4a-bb16-47739e8f160e" class="bulleted-list"><li style="list-style-type:circle">3.전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우</li></ul><ul id="ddbfbc09-1f4c-4505-be3e-2838768c24a0" class="bulleted-list"><li style="list-style-type:circle">4.국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때</li></ul><ul id="2d02e250-a1a9-4dd0-bcd9-40c14f63a7e7" class="bulleted-list"><li style="list-style-type:circle">5.기타 중대한 사유로 인하여 포일렛 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우</li></ul></li></ul><ul id="9c4c6f41-8a3d-4158-9ad5-07cdb7b10b91" class="bulleted-list"><li style="list-style-type:disc">③포일렛이 제1항 및 제2항의 규정에 의하여 서비스 이용을 제한하거나 중지한 때에는 그 사유 및 제한기간 등을 회사 홈페이지 등을 통해 사전 공지하거나 이용자에게 통지합니다.</li></ul><h3 id="1c114d66-b222-495a-973a-2e690f931093" class="">제 7 조 (개인위치정보의 이용 또는 제공)</h3><ul id="98f43e15-3805-432f-a405-7b7d88a4604c" class="bulleted-list"><li style="list-style-type:disc">①포일렛은 개인위치정보를 이용하여 위치기반서비스를 제공하는 경우 본 약관에 고지하고 동의를 받습니다.</li></ul><ul id="cf8f33eb-7225-4c00-8387-b5a7c9cf223f" class="bulleted-list"><li style="list-style-type:disc">②포일렛은 이용자의 동의 없이 개인위치정보를 제3자에게 제공하지 않으며, 제3자에게 제공하는 경우에는 제공받는 자 및 제공목적을 사전에 이용자에게 고지하고 동의를 받습니다.</li></ul><ul id="50bc1db3-b321-4cac-8abe-21f01c898b19" class="bulleted-list"><li style="list-style-type:disc">③포일렛은 개인위치정보를 이용자가 지정하는 제3자에게 제공하는 경우 개인위치정보를 수집한 통신단말장치로 매회 이용자에게 제공받는 자, 제공일시 및 제공목적을 즉시 통지합니다. 단, 아래의 경우 이용자가 미리 특정하여 지정한 통신단말장치 또는 전자우편주소, 온라인게시 등으로 통지합니다.<ul id="28a00048-0978-445d-8b83-249c763d92df" class="bulleted-list"><li style="list-style-type:circle">1.개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우</li></ul><ul id="12027a9a-b3a4-46fc-be43-076838bc4f4f" class="bulleted-list"><li style="list-style-type:circle">2.이용자의 개인위치정보를 수집한 통신단말장치 외의 통신단말장치 또는 전자우편주소, 온라인게시 등으로 통보할 것을 미리 요청한 경우</li></ul></li></ul><ul id="40d4b8da-705b-4f07-bb7a-7473db2b10bf" class="bulleted-list"><li style="list-style-type:disc">④포일렛 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 근거하여 개인위치정보 이용·제공사실 확인자료를 자동으로 기록·보존하며, 해당 자료는 6개월간 보관합니다.</li></ul><h3 id="d74f0135-afaf-4d0a-b276-774c7312872b" class="">제 8 조 (개인위치정보의 보유 목적 및 보유기간)</h3><p id="c868e3ec-7061-4502-b8c4-c4629ef748aa" class="">포일렛은 위치기반서비스 제공을 위해 아래와 같이 개인위치정보를 보유합니다.</p><ul id="4a66366e-9661-4dc1-8b11-e9f54005c6d6" class="bulleted-list"><li style="list-style-type:disc">①본 약관 제4조 따른 위치기반서비스 이용 및 제공 목적 달성한 때에는 지체없이 개인위치정보를 파기합니다.</li></ul><ul id="7aca122b-0f6e-40db-a7ca-743a872b0251" class="bulleted-list"><li style="list-style-type:disc">②다만, 이용자가 작성한 게시물 또는 콘텐츠와 함께 위치정보가 저장되는 서비스의 경우 해당 게시물 또는 콘텐츠의 보관기간 동안 개인위치정보가 보관됩니다.</li></ul><ul id="bdcbe6f9-5d6d-4fc0-bfdc-a99c00fe5ffb" class="bulleted-list"><li style="list-style-type:disc">③그 외 위치기반서비스 제공을 위해 필요한 경우 이용목적 달성을 위해 필요한 최소한의 기간 동안 개인위치정보를 보유할 수 있습니다.</li></ul><ul id="3a41ea3b-cf24-4259-9575-0c95669eb3cf" class="bulleted-list"><li style="list-style-type:disc">④위 1, 2, 3항에도 불구하고 다른 법령 또는 위치정보법에 따라 보유해야하는 정당한 사유가 있는 경우에는 그에 따릅니다.</li></ul><h3 id="a9cfc13a-1c9d-4d49-b308-cd122784b3bb" class="">제 9 조 (개인위치정보주체의 권리)</h3><ul id="0c3c97e1-370a-41f4-ae95-fc6531ed2681" class="bulleted-list"><li style="list-style-type:disc">①이용자는 언제든지 개인위치정보를 이용한 위치기반서비스의 이용 및 제공에 대한 동의 전부 또는 일부를 유보할 수 있습니다.</li></ul><ul id="7f3011cc-5b2e-4916-8fd8-d2e86766124d" class="bulleted-list"><li style="list-style-type:disc">②이용자는 언제든지 개인위치정보를 이용한 위치기반서비스의 이용 및 제공에 대한 동의 전부 또는 일부를 철회할 수 있습니다. 이 경우 포일렛은 지체 없이 철회된 범위의 개인위치정보 및 위치정보 이용·제공사실 확인자료를 파기합니다.</li></ul><ul id="af188a8f-50f9-4444-8e14-3a45dce15b4e" class="bulleted-list"><li style="list-style-type:disc">③이용자는 개인위치정보의 이용·제공의 일시적인 중지를 요구할 수 있습니다. 이 경우 포일렛은 이를 거절할 수 없으며 이를 충족하는 기술적 수단을 마련합니다</li></ul><ul id="5904e074-06b1-422c-86c5-7b18ebc5d100" class="bulleted-list"><li style="list-style-type:disc">④이용자는 포일렛에 대하여 아래 자료에 대한 열람 또는 고지를 요구할 수 있으며, 해당 자료에 오류가 있는 경우에는 정정을 요구할 수 있습니다. 이 경우 포일렛은 정당한 사유 없이 요구를 거절하지 않습니다.<ul id="976e62e8-aa0a-4c1d-a8a6-2e613f7cd450" class="bulleted-list"><li style="list-style-type:circle">1.이용자에 대한 위치정보 이용·제공사실 확인자료</li></ul><ul id="5ae8414c-e014-485d-8194-c980603fcc01" class="bulleted-list"><li style="list-style-type:circle">2.이용자의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법령의 규정에 의하여 제3자에게 제공된 이유 및 내용</li></ul></li></ul><ul id="fc2f3cd8-c452-4918-8844-9873bc68c82d" class="bulleted-list"><li style="list-style-type:disc">⑤이용자는 권리행사를 위해 본 약관 제14조의 연락처를 이용하여 포일렛은 요청할 수 있습니다.</li></ul><h3 id="45e1a0b5-ea69-4da1-a072-bd55ce4eb6d3" class="">제 10 조 (법정대리인의 권리)</h3><ul id="97547355-113a-4307-823a-62017186955c" class="bulleted-list"><li style="list-style-type:disc">①포일렛은 14세 미만의 이용자에 대해서는 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의를 이용자 및 이용자의 법정대리인으로부터 받아야 합니다. 이 경우 법정대리인은 본 약관 제8조에 의한 이용자의 권리를 모두 가집니다.</li></ul><ul id="5781c8ee-fbb2-47af-a90e-cf799fdc34c4" class="bulleted-list"><li style="list-style-type:disc">②포일렛은 14세 미만의 아동의 개인위치정보 또는 위치정보 이용, 제공사실 확인자료를 이용약관에 명시 또는 고지한 범위를 넘어 이용하거나 제3자에게 제공하고자 하는 경우 이용자와 이용자의 법정대리인의 동의를 받아야 합니다. 단, 아래의 경우는 제외합니다.<ul id="0bcbd199-e8d9-4ef5-8a43-b974010ca0e6" class="bulleted-list"><li style="list-style-type:circle">1.위치정보 및 위치기반서비스 제공에 따른 요금정산을 위하여 위치정보 이용, 제공사실 확인자료가 필요한 경우</li></ul><ul id="4dd19381-da5b-423e-a90d-91a0d1a1b18c" class="bulleted-list"><li style="list-style-type:circle">2.통계작성, 학술연구 또는 시장조사를 위하여 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우</li></ul></li></ul><h3 id="65554121-f289-4058-8b54-aca9253b347f" class="">제 11 조 (8세 이하의 아동 등의 보호의무자의 권리)</h3><ul id="8c5a5555-be84-44c3-ba37-7e3c6579d921" class="bulleted-list"><li style="list-style-type:disc">①포일렛은 아래의 경우에 해당하는 자(이하 “8세 이하의 아동 등”)의 위치정보의 보호 및 이용 등에 관한 법률 제26조2항에 해당하는 자(이하 “보호의무자”)가 8세 이하의 아동 등의 생명 또는 신체보호를 위하여 개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.<ul id="6052fe97-85a1-4694-91af-df85cc1a3631" class="bulleted-list"><li style="list-style-type:circle">1.8세 이하의 아동</li></ul><ul id="809166af-d416-4f82-a173-fa8659169fa0" class="bulleted-list"><li style="list-style-type:circle">2.피성년후견인</li></ul><ul id="d52927f6-9571-42ff-b070-337e5a721eb3" class="bulleted-list"><li style="list-style-type:circle">3.장애인복지법 제2조제2항제2호에 따른 정신적 장애를 가진 사람으로서 장애인고용촉진 및 직업재활법 제2조제2호에 따른 중증장애인에 해당하는 사람(장애인복지법 제32조에 따라 장애인 등록을 한 사람만 해당한다)</li></ul></li></ul><ul id="05ba9d73-5bb6-40ab-b0ac-909f28e20384" class="bulleted-list"><li style="list-style-type:disc">②8세 이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무자임을 증명하는 서면을 첨부하여 포일렛은 제출하여야 합니다.</li></ul><ul id="4208e9da-e3eb-4c97-a9b1-ad02a2e352fe" class="bulleted-list"><li style="list-style-type:disc">③보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 본 약관 제9조에 의한 이용자의 권리를 모두 가집니다.</li></ul><h3 id="d88a323b-60b2-4f2b-9fb5-ae954733edce" class="">제 12 조 (손해배상)</h3><p id="5149e6e2-529c-4a07-8c87-20649baa3f04" class="">포일렛은 위치정보의 보호 및 이용 등에 관한 법률 제15조 및 26조의 규정을 위반한 행위로 인해 손해를 입은 경우 이용자는 포일렛에 손해배상을 청구할 수 있습니다. 포일렛은 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.</p><h3 id="21fd0c6e-1bd7-43cb-892b-351eb5e0b911" class="">제 13 조 (면책)</h3><ul id="66613780-6fa2-4ecc-ac80-c421a8d29c9e" class="bulleted-list"><li style="list-style-type:disc">①포일렛은 다음 각 호의 경우로 위치기반서비스를 제공할 수 없는 경우 이로 인하여 이용자에게 발생한 손해에 대해서는 책임을 부담하지 않습니다.<ul id="9ab5e7e6-6592-46f9-8e57-01825e240ad2" class="bulleted-list"><li style="list-style-type:circle">1.천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우</li></ul><ul id="ab392054-de7d-4374-a5fa-76da7fb950e2" class="bulleted-list"><li style="list-style-type:circle">2.위치기반서비스 제공을 위하여 포일렛과 서비스 제휴계약을 체결한 제3자의 고의적인 서비스 방해가 있는 경우</li></ul><ul id="5d3be51e-c5ae-4d2a-800f-0a10ba64151b" class="bulleted-list"><li style="list-style-type:circle">3.이용자의 귀책사유로 위치기반서비스 이용에 장애가 있는 경우</li></ul><ul id="a86ed5e8-4049-4518-ace7-8494a259bf07" class="bulleted-list"><li style="list-style-type:circle">4.제1호 내지 제3호를 제외한 기타 포일렛의 고의·과실이 없는 사유로 인한 경우</li></ul></li></ul><ul id="baa2b5f0-7343-4796-970c-82fc85dc3585" class="bulleted-list"><li style="list-style-type:disc">②포일렛은 위치기반서비스 및 위치기반서비스에 게재된 정보, 자료, 사실의 신뢰도, 정확성 등에 대해서는 보증을 하지 않으며 이로 인해 발생한 이용자의 손해에 대하여는 책임을 부담하지 아니합니다.</li></ul><h3 id="c7f8b946-27db-4edd-ba43-d2c6272eb070" class="">제 14 조 (분쟁의 조정 및 기타)</h3><ul id="ac11773a-38b4-4a2b-90f0-54684e1b6706" class="bulleted-list"><li style="list-style-type:disc">①포일렛은 위치정보와 관련된 분쟁의 해결을 위해 이용자와 성실히 협의합니다.</li></ul><ul id="220b8e5b-f0e7-4e9f-a849-c3afe06ca5b1" class="bulleted-list"><li style="list-style-type:disc">②전항의 협의에서 분쟁이 해결되지 않은 경우, 포일렛은 이용자는 위치정보의 보호 및 이용 등에 관한 법률 제28조의 규정에 의해 방송통신위원회에 재정을 신청하거나, 개인정보보호법 제43조의 규정에 의해 개인정보 분쟁조정위원회에 조정을 신청할 수 있습니다.</li></ul><h3 id="f9a2530b-dc3b-456e-9b06-c12cb20ddd27" class="">제 15 조 (포일렛의 주소 및 연락처)</h3><p id="e11d3446-8de6-4a90-a951-6c8ae987bf3d" class="">포일렛의 상호, 주소 및 연락처는 아래와 같습니다.</p><ul id="ea369e12-0949-4ec1-9c8f-eb0f37279961" class="bulleted-list"><li style="list-style-type:disc"><mark class="highlight-red">상호 : </mark></li></ul><ul id="ecf47705-0fbf-4b88-866c-598776af3bb0" class="bulleted-list"><li style="list-style-type:disc"><mark class="highlight-red">주소 : </mark></li></ul><ul id="de23cfb0-6544-4e63-b3b1-5cf10cce9ba6" class="bulleted-list"><li style="list-style-type:disc"><mark class="highlight-red">대표전화 : </mark></li></ul><h3 id="0e3863fc-8838-4031-abe4-a3a5d3300f4e" class="">부칙</h3><p id="5ac369a8-e708-451b-889c-b0c613b35581" class=""><strong>제 1 조 (시행일)</strong></p><p id="9be2ecd8-9f37-4e32-bdb6-cb6689dec8e0" class=""><mark class="highlight-red">본 약관은 0000년 0월 0일부터 시행됩니다.</mark></p><p id="80ab6f0f-78d5-432b-9342-b2aa54659bee" class=""><strong>제 2 조 (위치정보관리책임자 정보)</strong></p><p id="b0e832cc-b254-4df1-9e78-ce3e0ddbd8a6" class="">포일렛은 개인위치정보를 적절히 관리·보호하고, 이용자의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 지위에 있는 자를 위치정보관리책임자로 지정해 운영하고 있으며, 위치정보관리책임자는 위치기반서비스를 제공하는 부서의 부서장으로서 성명과 연락처는 아래와 같습니다.</p><ul id="c555e78c-4fa0-468d-b92b-301b77846d64" class="bulleted-list"><li style="list-style-type:disc"><mark class="highlight-red">성명 : </mark></li></ul><ul id="8fdc2a0b-b840-49d3-abf3-d21b31c7e31c" class="bulleted-list"><li style="list-style-type:disc"><mark class="highlight-red">대표전화 :</mark> </li></ul><p id="9cdd93c4-736f-4be2-abab-83407ecfa581" class=""></p></div></article>
''';
const license = '''
<article>
<h3>화장실 데이터</h3><p><b>지방행정 인허가 데이터 개방 시스템,</b><br>행정자치부,<br><a href="https://www.localdata.go.kr/main.do">https://www.localdata.go.kr/main.do</a></p>
<h3>글꼴</h3><p><b>한국기계연구원 서체 Bold,</b><br>한국기계연구원,<br><a href="https://www.kimm.re.kr/webfont">https://www.kimm.re.kr/webfont</a></p>
<p><b>Noto Sans</b>,<br>Google Fonts,<br><a href="https://fonts.google.com/noto/specimen/Noto+Sans+KR">https://fonts.google.com/noto/specimen/Noto+Sans+KR</a></p>
<br></br>
<h3>오픈소스</h3>
<p><b>cached_network_image</b><br>The MIT License (MIT)<br>Copyright (c) 2018 Rene Floor<br><a href="https://github.com/Baseflow/flutter_cached_network_image">https://github.com/Baseflow/flutter_cached_network_image</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>dio</b><br>MIT License<br>Copyright (c) 2018 wendux<br><a href="https://github.com/flutterchina/dio">https://github.com/flutterchina/dio</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>flutter</b><br>Copyright 2014 The Flutter Authors<br><a href="https://flutter.dev">https://flutter.dev</a><br>Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
<p><b>flutter_dotenv</b><br>The MIT License (MIT)<br>Copyright (c) 2018 java-james<br><a href="https://github.com/java-james/flutter_dotenv">https://github.com/java-james/flutter_dotenv</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>flutter_email_sender</b><br>Apache License<br>Version 2.0, January 2004<br>https://github.com/sidlatau/flutter_email_sender<br>http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.</p>
<p><b>flutter_html</b><br>MIT License<br>Copyright (c) 2019 Matthew Whitaker<br><a href="https://github.com/Sub6Resources/flutter_html">https://github.com/Sub6Resources/flutter_html</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>flutter_lints</b><br>Copyright 2013 The Flutter Authors<br><a href="https://github.com/flutter/packages/tree/main/packages/flutter_lints">https://github.com/flutter/packages/tree/main/packages/flutter_lints</a><br>Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
<p><b>flutter_oss_licenses</b><br>MIT License<br>Copyright (c) 2019 Takashi Kawasaki<br><a href="https://pub.dev/packages/flutter_oss_licenses">https://pub.dev/packages/flutter_oss_licenses</a><br>Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google LLC nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
<p><b>flutter_secure_storage</b><br>BSD 3-Clause License<br>Copyright 2017 German Saprykin<br><a href="https://github.com/mogol/flutter_secure_storage/tree/develop/flutter_secure_storage">https://github.com/mogol/flutter_secure_storage/tree/develop/flutter_secure_storage</a><br>All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
<p><b>geolocator</b><br>MIT License<br>Copyright (c) 2018 Baseflow<br>https://github.com/baseflow/flutter-geolocator/tree/main/geolocator<br>
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>kakao_flutter_sdk_user</b><br>Apache License<br>Version 2.0, January 2004<br><a href="https://github.com/kakao/kakao_flutter_sdk">https://github.com/kakao/kakao_flutter_sdk</a><br>http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.</p>
<p><b>location</b><br>Copyright (c) 2017 Guillaume Bernos<br><a href="https://github.com/Lyokone/flutterlocation">https://github.com/Lyokone/flutterlocation</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>map</b><br>MIT License<br>Copyright (c) 2020-2022 Mahdi K. Fard<br><a href="https://github.com/xclud/flutter_map">https://github.com/xclud/flutter_map</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>package_info_plus</b><br>Copyright 2017 The Chromium Authors<br><a href="https://github.com/fluttercommunity/plus_plugins/tree/main/packages">https://github.com/fluttercommunity/plus_plugins/tree/main/packages</a><br>Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

   * Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above
copyright notice, this list of conditions and the following disclaimer
in the documentation and/or other materials provided with the
distribution.
   * Neither the name of Google Inc. nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
<p><b>provider</b><br>MIT License<br>Copyright (c) 2019 Remi Rousselet<br><a href="https://github.com/rrousselGit/provider">https://github.com/rrousselGit/provider</a><br>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</p>
<p><b>shared_preferences</b><br>Copyright 2013 The Flutter Authors<br><a href="https://github.com/rrousselGit/provider">https://github.com/rrousselGit/provider</a></p>
<p><b>url_launcher</b><br>Copyright 2013 The Flutter Authors<br><a href="https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher">https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher</a><br></p>
<a id='project_Apache_License_2.0'></a>
<h3>Apache License 2.0</h3>
<div class='dependency'>
<p><strong> 1.</strong> <strong>Group:</strong> io.swagger <strong>Name:</strong> swagger-annotations <strong>Version:</strong> 1.5.20 </p><label>POM License</label>
<div class='dependency-value'>Apache License 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.html'>http://www.apache.org/licenses/LICENSE-2.0.html</a></div>
</div>
<div class='dependency'>
<p><strong> 2.</strong> <strong>Group:</strong> io.swagger <strong>Name:</strong> swagger-models <strong>Version:</strong> 1.5.20 </p><label>POM License</label>
<div class='dependency-value'>Apache License 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.html'>http://www.apache.org/licenses/LICENSE-2.0.html</a></div>
</div>
<div class='dependency'>
<p><strong> 3.</strong> <strong>Group:</strong> io.swagger.core.v3 <strong>Name:</strong> swagger-annotations <strong>Version:</strong> 2.1.2 </p><label>POM License</label>
<div class='dependency-value'>Apache License 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.html'>http://www.apache.org/licenses/LICENSE-2.0.html</a></div>
</div>
<div class='dependency'>
<p><strong> 4.</strong> <strong>Group:</strong> io.swagger.core.v3 <strong>Name:</strong> swagger-models <strong>Version:</strong> 2.1.2 </p><label>POM License</label>
<div class='dependency-value'>Apache License 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.html'>http://www.apache.org/licenses/LICENSE-2.0.html</a></div>
</div>
<a id='project_Apache_License,_Version_2.0'></a>
<h3>Apache License, Version 2.0</h3>
<div class='dependency'>
<p><strong> 5.</strong> <strong>Group:</strong> com.fasterxml <strong>Name:</strong> classmate <strong>Version:</strong> 1.5.1 </p><label>Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/java-classmate'>https://github.com/FasterXML/java-classmate</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='classmate-1.5.1.jar/META-INF/LICENSE'>classmate-1.5.1.jar/META-INF/LICENSE</a><br><a href='classmate-1.5.1.jar/META-INF/NOTICE'>classmate-1.5.1.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 6.</strong> <strong>Group:</strong> com.fasterxml.jackson.core <strong>Name:</strong> jackson-core <strong>Version:</strong> 2.13.4 </p><label>Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-core'>https://github.com/FasterXML/jackson-core</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-core-2.13.4.jar/META-INF/LICENSE'>jackson-core-2.13.4.jar/META-INF/LICENSE</a><br><a href='jackson-core-2.13.4.jar/META-INF/NOTICE'>jackson-core-2.13.4.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 7.</strong> <strong>Group:</strong> com.fasterxml.jackson.core <strong>Name:</strong> jackson-databind <strong>Version:</strong> 2.13.4.2 </p><label>Project URL</label>
<div class='dependency-value'><a href='http://github.com/FasterXML/jackson'>http://github.com/FasterXML/jackson</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-databind-2.13.4.2.jar/META-INF/LICENSE'>jackson-databind-2.13.4.2.jar/META-INF/LICENSE</a><br><a href='jackson-databind-2.13.4.2.jar/META-INF/NOTICE'>jackson-databind-2.13.4.2.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 8.</strong> <strong>Group:</strong> com.fasterxml.jackson.datatype <strong>Name:</strong> jackson-datatype-jdk8 <strong>Version:</strong> 2.13.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jdk8'>https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jdk8</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 9.</strong> <strong>Group:</strong> com.fasterxml.jackson.datatype <strong>Name:</strong> jackson-datatype-jsr310 <strong>Version:</strong> 2.13.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jsr310'>https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jsr310</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-datatype-jsr310-2.13.4.jar/META-INF/LICENSE'>jackson-datatype-jsr310-2.13.4.jar/META-INF/LICENSE</a></div>
</div>
<div class='dependency'>
<p><strong> 10.</strong> <strong>Group:</strong> com.fasterxml.jackson.module <strong>Name:</strong> jackson-module-parameter-names <strong>Version:</strong> 2.13.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-modules-java8/jackson-module-parameter-names'>https://github.com/FasterXML/jackson-modules-java8/jackson-module-parameter-names</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 11.</strong> <strong>Group:</strong> com.github.stephenc.jcip <strong>Name:</strong> jcip-annotations <strong>Version:</strong> 1.0-1 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='http://stephenc.github.com/jcip-annotations'>http://stephenc.github.com/jcip-annotations</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 12.</strong> <strong>Group:</strong> com.querydsl <strong>Name:</strong> querydsl-core <strong>Version:</strong> 5.0.0 </p><label>POM Project URL</label>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 13.</strong> <strong>Group:</strong> com.querydsl <strong>Name:</strong> querydsl-jpa <strong>Version:</strong> 5.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 14.</strong> <strong>Group:</strong> io.jsonwebtoken <strong>Name:</strong> jjwt-api <strong>Version:</strong> 0.11.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/jwtk/jjwt'>https://github.com/jwtk/jjwt</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0'>http://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 15.</strong> <strong>Group:</strong> io.jsonwebtoken <strong>Name:</strong> jjwt-impl <strong>Version:</strong> 0.11.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/jwtk/jjwt'>https://github.com/jwtk/jjwt</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0'>http://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 16.</strong> <strong>Group:</strong> io.jsonwebtoken <strong>Name:</strong> jjwt-jackson <strong>Version:</strong> 0.11.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/jwtk/jjwt'>https://github.com/jwtk/jjwt</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0'>http://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 17.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-buffer <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 18.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-codec <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 19.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-codec-dns <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 20.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-codec-http <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 21.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-codec-http2 <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 22.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-codec-socks <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 23.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-common <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 24.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-handler <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 25.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-handler-proxy <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 26.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-resolver <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 27.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-resolver-dns <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 28.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-resolver-dns-classes-macos <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 29.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-resolver-dns-native-macos <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 30.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-transport <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 31.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-transport-classes-epoll <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 32.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-transport-native-epoll <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 33.</strong> <strong>Group:</strong> io.netty <strong>Name:</strong> netty-transport-native-unix-common <strong>Version:</strong> 4.1.87.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://netty.io/'>https://netty.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 34.</strong> <strong>Group:</strong> io.projectreactor <strong>Name:</strong> reactor-core <strong>Version:</strong> 3.4.26 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/reactor/reactor-core'>https://github.com/reactor/reactor-core</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 35.</strong> <strong>Group:</strong> net.bytebuddy <strong>Name:</strong> byte-buddy <strong>Version:</strong> 1.12.22 </p><label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='byte-buddy-1.12.22.jar/META-INF/LICENSE'>byte-buddy-1.12.22.jar/META-INF/LICENSE</a><br><a href='byte-buddy-1.12.22.jar/META-INF/NOTICE'>byte-buddy-1.12.22.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 36.</strong> <strong>Group:</strong> org.apache.logging.log4j <strong>Name:</strong> log4j-api <strong>Version:</strong> 2.17.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.apache.org/'>https://www.apache.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='log4j-api-2.17.2.jar/META-INF/LICENSE'>log4j-api-2.17.2.jar/META-INF/LICENSE</a><br><a href='log4j-api-2.17.2.jar/META-INF/NOTICE'>log4j-api-2.17.2.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 37.</strong> <strong>Group:</strong> org.apache.logging.log4j <strong>Name:</strong> log4j-to-slf4j <strong>Version:</strong> 2.17.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.apache.org/'>https://www.apache.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='log4j-to-slf4j-2.17.2.jar/META-INF/LICENSE'>log4j-to-slf4j-2.17.2.jar/META-INF/LICENSE</a><br><a href='log4j-to-slf4j-2.17.2.jar/META-INF/NOTICE'>log4j-to-slf4j-2.17.2.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 38.</strong> <strong>Group:</strong> org.apache.tomcat.embed <strong>Name:</strong> tomcat-embed-core <strong>Version:</strong> 9.0.71 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://tomcat.apache.org/'>https://tomcat.apache.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='tomcat-embed-core-9.0.71.jar/META-INF/LICENSE'>tomcat-embed-core-9.0.71.jar/META-INF/LICENSE</a><br><a href='tomcat-embed-core-9.0.71.jar/META-INF/NOTICE'>tomcat-embed-core-9.0.71.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 39.</strong> <strong>Group:</strong> org.apache.tomcat.embed <strong>Name:</strong> tomcat-embed-el <strong>Version:</strong> 9.0.71 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://tomcat.apache.org/'>https://tomcat.apache.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='tomcat-embed-el-9.0.71.jar/META-INF/LICENSE'>tomcat-embed-el-9.0.71.jar/META-INF/LICENSE</a><br><a href='tomcat-embed-el-9.0.71.jar/META-INF/NOTICE'>tomcat-embed-el-9.0.71.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 40.</strong> <strong>Group:</strong> org.apache.tomcat.embed <strong>Name:</strong> tomcat-embed-websocket <strong>Version:</strong> 9.0.71 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://tomcat.apache.org/'>https://tomcat.apache.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='tomcat-embed-websocket-9.0.71.jar/META-INF/LICENSE'>tomcat-embed-websocket-9.0.71.jar/META-INF/LICENSE</a><br><a href='tomcat-embed-websocket-9.0.71.jar/META-INF/NOTICE'>tomcat-embed-websocket-9.0.71.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 41.</strong> <strong>Group:</strong> org.jboss <strong>Name:</strong> jandex <strong>Version:</strong> 2.4.2.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://www.jboss.org'>http://www.jboss.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>Public Domain - <a href='http://repository.jboss.org/licenses/cc0-1.0.txt'>http://repository.jboss.org/licenses/cc0-1.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 42.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-aop <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-aop-5.3.25.jar/META-INF/license.txt'>spring-aop-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-aop-5.3.25.jar/META-INF/notice.txt'>spring-aop-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 43.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-aspects <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-aspects-5.3.25.jar/META-INF/license.txt'>spring-aspects-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-aspects-5.3.25.jar/META-INF/notice.txt'>spring-aspects-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 44.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-beans <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-beans-5.3.25.jar/META-INF/license.txt'>spring-beans-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-beans-5.3.25.jar/META-INF/notice.txt'>spring-beans-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 45.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-context <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-context-5.3.25.jar/META-INF/license.txt'>spring-context-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-context-5.3.25.jar/META-INF/notice.txt'>spring-context-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 46.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-core <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-core-5.3.25.jar/META-INF/license.txt'>spring-core-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-core-5.3.25.jar/META-INF/notice.txt'>spring-core-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 47.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-expression <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-expression-5.3.25.jar/META-INF/license.txt'>spring-expression-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-expression-5.3.25.jar/META-INF/notice.txt'>spring-expression-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 48.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-jcl <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-jcl-5.3.25.jar/META-INF/license.txt'>spring-jcl-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-jcl-5.3.25.jar/META-INF/notice.txt'>spring-jcl-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 49.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-jdbc <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-jdbc-5.3.25.jar/META-INF/license.txt'>spring-jdbc-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-jdbc-5.3.25.jar/META-INF/notice.txt'>spring-jdbc-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 50.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-orm <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-orm-5.3.25.jar/META-INF/license.txt'>spring-orm-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-orm-5.3.25.jar/META-INF/notice.txt'>spring-orm-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 51.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-tx <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-tx-5.3.25.jar/META-INF/license.txt'>spring-tx-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-tx-5.3.25.jar/META-INF/notice.txt'>spring-tx-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 52.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-web <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-web-5.3.25.jar/META-INF/license.txt'>spring-web-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-web-5.3.25.jar/META-INF/notice.txt'>spring-web-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 53.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-webflux <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-webflux-5.3.25.jar/META-INF/license.txt'>spring-webflux-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-webflux-5.3.25.jar/META-INF/notice.txt'>spring-webflux-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 54.</strong> <strong>Group:</strong> org.springframework <strong>Name:</strong> spring-webmvc <strong>Version:</strong> 5.3.25 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/spring-projects/spring-framework'>https://github.com/spring-projects/spring-framework</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-webmvc-5.3.25.jar/META-INF/license.txt'>spring-webmvc-5.3.25.jar/META-INF/license.txt</a><br><a href='spring-webmvc-5.3.25.jar/META-INF/notice.txt'>spring-webmvc-5.3.25.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 55.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 56.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-autoconfigure <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-autoconfigure-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-autoconfigure-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-autoconfigure-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-autoconfigure-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 57.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-devtools <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-devtools-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-devtools-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-devtools-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-devtools-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 58.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 59.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-aop <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-aop-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-aop-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-aop-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-aop-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 60.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-data-jpa <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-data-jpa-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-data-jpa-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-data-jpa-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-data-jpa-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 61.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-jdbc <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-jdbc-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-jdbc-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-jdbc-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-jdbc-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 62.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-json <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-json-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-json-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-json-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-json-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 63.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-logging <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-logging-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-logging-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-logging-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-logging-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 64.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-oauth3-client <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-oauth3-client-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-oauth3-client-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-oauth3-client-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-oauth3-client-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 65.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-reactor-netty <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-reactor-netty-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-reactor-netty-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-reactor-netty-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-reactor-netty-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 66.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-security <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-security-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-security-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-security-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-security-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 67.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-tomcat <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-tomcat-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-tomcat-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-tomcat-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-tomcat-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 68.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-web <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-web-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-web-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-web-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-web-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 69.</strong> <strong>Group:</strong> org.springframework.boot <strong>Name:</strong> spring-boot-starter-webflux <strong>Version:</strong> 2.7.8 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-boot'>https://spring.io/projects/spring-boot</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-boot-starter-webflux-2.7.8.jar/META-INF/LICENSE.txt'>spring-boot-starter-webflux-2.7.8.jar/META-INF/LICENSE.txt</a><br><a href='spring-boot-starter-webflux-2.7.8.jar/META-INF/NOTICE.txt'>spring-boot-starter-webflux-2.7.8.jar/META-INF/NOTICE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 70.</strong> <strong>Group:</strong> org.springframework.data <strong>Name:</strong> spring-data-commons <strong>Version:</strong> 2.7.7 </p><label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-data-commons-2.7.7.jar/license.txt'>spring-data-commons-2.7.7.jar/license.txt</a><br><a href='spring-data-commons-2.7.7.jar/notice.txt'>spring-data-commons-2.7.7.jar/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 71.</strong> <strong>Group:</strong> org.springframework.data <strong>Name:</strong> spring-data-jpa <strong>Version:</strong> 2.7.7 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-data-jpa'>https://spring.io/projects/spring-data-jpa</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-data-jpa-2.7.7.jar/license.txt'>spring-data-jpa-2.7.7.jar/license.txt</a><br><a href='spring-data-jpa-2.7.7.jar/notice.txt'>spring-data-jpa-2.7.7.jar/notice.txt</a><br><a href='spring-data-jpa-2.7.7.jar/readme.txt'>spring-data-jpa-2.7.7.jar/readme.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 72.</strong> <strong>Group:</strong> org.springframework.plugin <strong>Name:</strong> spring-plugin-core <strong>Version:</strong> 2.0.0.RELEASE </p><label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-plugin-core-2.0.0.RELEASE.jar/META-INF/license.txt'>spring-plugin-core-2.0.0.RELEASE.jar/META-INF/license.txt</a><br><a href='spring-plugin-core-2.0.0.RELEASE.jar/META-INF/notice.txt'>spring-plugin-core-2.0.0.RELEASE.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 73.</strong> <strong>Group:</strong> org.springframework.plugin <strong>Name:</strong> spring-plugin-metadata <strong>Version:</strong> 2.0.0.RELEASE </p><label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='spring-plugin-metadata-2.0.0.RELEASE.jar/META-INF/license.txt'>spring-plugin-metadata-2.0.0.RELEASE.jar/META-INF/license.txt</a><br><a href='spring-plugin-metadata-2.0.0.RELEASE.jar/META-INF/notice.txt'>spring-plugin-metadata-2.0.0.RELEASE.jar/META-INF/notice.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 74.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-config <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 75.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-core <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 76.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-crypto <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 77.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-oauth3-client <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 78.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-oauth3-core <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 79.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-oauth3-jose <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 80.</strong> <strong>Group:</strong> org.springframework.security <strong>Name:</strong> spring-security-web <strong>Version:</strong> 5.7.6 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://spring.io/projects/spring-security'>https://spring.io/projects/spring-security</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0'>https://www.apache.org/licenses/LICENSE-2.0</a></div>
</div>
<div class='dependency'>
<p><strong> 81.</strong> <strong>Group:</strong> org.yaml <strong>Name:</strong> snakeyaml <strong>Version:</strong> 1.30 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://bitbucket.org/snakeyaml/snakeyaml'>https://bitbucket.org/snakeyaml/snakeyaml</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<a id='project_Apache_License,_version_2.0'></a>
<h3>Apache License, version 2.0</h3>
<div class='dependency'>
<p><strong> 82.</strong> <strong>Group:</strong> com.nimbusds <strong>Name:</strong> oauth3-oidc-sdk <strong>Version:</strong> 9.35 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://connect2id.com'>https://connect2id.com</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://bitbucket.org/connect2id/oauth-2.0-sdk-with-openid-connect-extensions'>https://bitbucket.org/connect2id/oauth-2.0-sdk-with-openid-connect-extensions</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.html'>https://www.apache.org/licenses/LICENSE-2.0.html</a></div>
</div>
<div class='dependency'>
<p><strong> 83.</strong> <strong>Group:</strong> org.jboss.logging <strong>Name:</strong> jboss-logging <strong>Version:</strong> 3.4.3.Final </p><label>Project URL</label>
<div class='dependency-value'><a href='http://www.jboss.org'>http://www.jboss.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>Public Domain - <a href='http://repository.jboss.org/licenses/cc0-1.0.txt'>http://repository.jboss.org/licenses/cc0-1.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jboss-logging-3.4.3.Final.jar/META-INF/LICENSE.txt'>jboss-logging-3.4.3.Final.jar/META-INF/LICENSE.txt</a></div>
</div>
<a id='project_BSD_License'></a>
<h3>BSD License</h3>
<div class='dependency'>
<p><strong> 84.</strong> <strong>Group:</strong> antlr <strong>Name:</strong> antlr <strong>Version:</strong> 2.7.7 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='http://www.antlr.org/'>http://www.antlr.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>BSD License - <a href='http://www.antlr.org/license.html'>http://www.antlr.org/license.html</a></div>
</div>
<a id='project_BSD-3-Clause'></a>
<h3>BSD-3-Clause</h3>
<div class='dependency'>
<p><strong> 85.</strong> <strong>Group:</strong> org.ow2.asm <strong>Name:</strong> asm <strong>Version:</strong> 9.1 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://asm.ow2.org'>http://asm.ow2.org</a></div>
<label>Manifest License</label>
<div class='dependency-value'>BSD-3-Clause;link=https://asm.ow2.io/LICENSE.txt (Not Packaged)</div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='http://asm.ow2.io/'>http://asm.ow2.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>BSD-3-Clause - <a href='https://asm.ow2.io/license.html'>https://asm.ow2.io/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<a id='project_EDL_1.0'></a>
<h3>EDL 1.0</h3>
<div class='dependency'>
<p><strong> 86.</strong> <strong>Group:</strong> com.sun.activation <strong>Name:</strong> jakarta.activation <strong>Version:</strong> 1.2.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>EDL 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.activation-1.2.2.jar/META-INF/LICENSE.md'>jakarta.activation-1.2.2.jar/META-INF/LICENSE.md</a><br><a href='jakarta.activation-1.2.2.jar/META-INF/NOTICE.md'>jakarta.activation-1.2.2.jar/META-INF/NOTICE.md</a></div>
</div>
<a id='project_EPL_2.0'></a>
<h3>EPL 2.0</h3>
<div class='dependency'>
<p><strong> 87.</strong> <strong>Group:</strong> jakarta.annotation <strong>Name:</strong> jakarta.annotation-api <strong>Version:</strong> 1.3.5 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.ca'>https://projects.eclipse.org/projects/ee4j.ca</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md</a><br><a href='jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 88.</strong> <strong>Group:</strong> jakarta.transaction <strong>Name:</strong> jakarta.transaction-api <strong>Version:</strong> 1.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j'>https://github.com/eclipse-ee4j</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.jta'>https://projects.eclipse.org/projects/ee4j.jta</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<a id='project_Eclipse_Distribution_License_-_v_1.0'></a>
<h3>Eclipse Distribution License - v 1.0</h3>
<div class='dependency'>
<p><strong> 89.</strong> <strong>Group:</strong> com.sun.istack <strong>Name:</strong> istack-commons-runtime <strong>Version:</strong> 3.0.12 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='istack-commons-runtime-3.0.12.jar/META-INF/LICENSE.md'>istack-commons-runtime-3.0.12.jar/META-INF/LICENSE.md</a><br><a href='istack-commons-runtime-3.0.12.jar/META-INF/NOTICE.md'>istack-commons-runtime-3.0.12.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 90.</strong> <strong>Group:</strong> jakarta.xml.bind <strong>Name:</strong> jakarta.xml.bind-api <strong>Version:</strong> 2.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.xml.bind-api-2.3.3.jar/META-INF/LICENSE.md'>jakarta.xml.bind-api-2.3.3.jar/META-INF/LICENSE.md</a><br><a href='jakarta.xml.bind-api-2.3.3.jar/META-INF/NOTICE.md'>jakarta.xml.bind-api-2.3.3.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 91.</strong> <strong>Group:</strong> org.glassfish.jaxb <strong>Name:</strong> jaxb-runtime <strong>Version:</strong> 2.3.7 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://eclipse-ee4j.github.io/jaxb-ri/'>https://eclipse-ee4j.github.io/jaxb-ri/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jaxb-runtime-2.3.7.jar/META-INF/LICENSE.md'>jaxb-runtime-2.3.7.jar/META-INF/LICENSE.md</a><br><a href='jaxb-runtime-2.3.7.jar/META-INF/NOTICE.md'>jaxb-runtime-2.3.7.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 92.</strong> <strong>Group:</strong> org.glassfish.jaxb <strong>Name:</strong> txw2 <strong>Version:</strong> 2.3.7 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://eclipse-ee4j.github.io/jaxb-ri/'>https://eclipse-ee4j.github.io/jaxb-ri/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='txw2-2.3.7.jar/META-INF/LICENSE.md'>txw2-2.3.7.jar/META-INF/LICENSE.md</a><br><a href='txw2-2.3.7.jar/META-INF/NOTICE.md'>txw2-2.3.7.jar/META-INF/NOTICE.md</a></div>
</div>
<a id='project_Eclipse_Distribution_License_v._1.0'></a>
<h3>Eclipse Distribution License v. 1.0</h3>
<div class='dependency'>
<p><strong> 93.</strong> <strong>Group:</strong> jakarta.persistence <strong>Name:</strong> jakarta.persistence-api <strong>Version:</strong> 2.2.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j/jpa-api'>https://github.com/eclipse-ee4j/jpa-api</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License v. 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<a id='project_Eclipse_Public_License_-_v_1.0'></a>
<h3>Eclipse Public License - v 1.0</h3>
<div class='dependency'>
<p><strong> 94.</strong> <strong>Group:</strong> ch.qos.logback <strong>Name:</strong> logback-classic <strong>Version:</strong> 1.2.11 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://www.qos.ch'>http://www.qos.ch</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License - v 1.0 - <a href='http://www.eclipse.org/legal/epl-v10.html'>http://www.eclipse.org/legal/epl-v10.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU Lesser General Public License - <a href='http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html'>http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html</a></div>
</div>
<div class='dependency'>
<p><strong> 95.</strong> <strong>Group:</strong> ch.qos.logback <strong>Name:</strong> logback-core <strong>Version:</strong> 1.2.11 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://www.qos.ch'>http://www.qos.ch</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License - v 1.0 - <a href='http://www.eclipse.org/legal/epl-v10.html'>http://www.eclipse.org/legal/epl-v10.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU Lesser General Public License - <a href='http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html'>http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html</a></div>
</div>
<a id='project_Eclipse_Public_License_-_v_2.0'></a>
<h3>Eclipse Public License - v 2.0</h3>
<div class='dependency'>
<p><strong> 96.</strong> <strong>Group:</strong> org.aspectj <strong>Name:</strong> aspectjweaver <strong>Version:</strong> 1.9.7 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org/aspectj/'>https://www.eclipse.org/aspectj/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License - v 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
</div>
<a id='project_Eclipse_Public_License_v._2.0'></a>
<h3>Eclipse Public License v. 2.0</h3>
<div class='dependency'>
<p><strong> 97.</strong> <strong>Group:</strong> com.sun.activation <strong>Name:</strong> jakarta.activation <strong>Version:</strong> 1.2.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>EDL 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.activation-1.2.2.jar/META-INF/LICENSE.md'>jakarta.activation-1.2.2.jar/META-INF/LICENSE.md</a><br><a href='jakarta.activation-1.2.2.jar/META-INF/NOTICE.md'>jakarta.activation-1.2.2.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 98.</strong> <strong>Group:</strong> com.sun.istack <strong>Name:</strong> istack-commons-runtime <strong>Version:</strong> 3.0.12 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='istack-commons-runtime-3.0.12.jar/META-INF/LICENSE.md'>istack-commons-runtime-3.0.12.jar/META-INF/LICENSE.md</a><br><a href='istack-commons-runtime-3.0.12.jar/META-INF/NOTICE.md'>istack-commons-runtime-3.0.12.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 99.</strong> <strong>Group:</strong> jakarta.annotation <strong>Name:</strong> jakarta.annotation-api <strong>Version:</strong> 1.3.5 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.ca'>https://projects.eclipse.org/projects/ee4j.ca</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md</a><br><a href='jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 100.</strong> <strong>Group:</strong> jakarta.persistence <strong>Name:</strong> jakarta.persistence-api <strong>Version:</strong> 2.2.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j/jpa-api'>https://github.com/eclipse-ee4j/jpa-api</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License v. 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<div class='dependency'>
<p><strong> 101.</strong> <strong>Group:</strong> jakarta.transaction <strong>Name:</strong> jakarta.transaction-api <strong>Version:</strong> 1.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j'>https://github.com/eclipse-ee4j</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.jta'>https://projects.eclipse.org/projects/ee4j.jta</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<div class='dependency'>
<p><strong> 102.</strong> <strong>Group:</strong> jakarta.xml.bind <strong>Name:</strong> jakarta.xml.bind-api <strong>Version:</strong> 2.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.xml.bind-api-2.3.3.jar/META-INF/LICENSE.md'>jakarta.xml.bind-api-2.3.3.jar/META-INF/LICENSE.md</a><br><a href='jakarta.xml.bind-api-2.3.3.jar/META-INF/NOTICE.md'>jakarta.xml.bind-api-2.3.3.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 103.</strong> <strong>Group:</strong> org.glassfish.jaxb <strong>Name:</strong> jaxb-runtime <strong>Version:</strong> 2.3.7 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://eclipse-ee4j.github.io/jaxb-ri/'>https://eclipse-ee4j.github.io/jaxb-ri/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jaxb-runtime-2.3.7.jar/META-INF/LICENSE.md'>jaxb-runtime-2.3.7.jar/META-INF/LICENSE.md</a><br><a href='jaxb-runtime-2.3.7.jar/META-INF/NOTICE.md'>jaxb-runtime-2.3.7.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 104.</strong> <strong>Group:</strong> org.glassfish.jaxb <strong>Name:</strong> txw2 <strong>Version:</strong> 2.3.7 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://eclipse-ee4j.github.io/jaxb-ri/'>https://eclipse-ee4j.github.io/jaxb-ri/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='txw2-2.3.7.jar/META-INF/LICENSE.md'>txw2-2.3.7.jar/META-INF/LICENSE.md</a><br><a href='txw2-2.3.7.jar/META-INF/NOTICE.md'>txw2-2.3.7.jar/META-INF/NOTICE.md</a></div>
</div>
<a id='project_GNU_General_Public_License,_version_2_with_the_GNU_Classpath_Exception'></a>
<h3>GNU General Public License, version 2 with the GNU Classpath Exception</h3>
<div class='dependency'>
<p><strong> 105.</strong> <strong>Group:</strong> com.sun.activation <strong>Name:</strong> jakarta.activation <strong>Version:</strong> 1.2.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>EDL 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.activation-1.2.2.jar/META-INF/LICENSE.md'>jakarta.activation-1.2.2.jar/META-INF/LICENSE.md</a><br><a href='jakarta.activation-1.2.2.jar/META-INF/NOTICE.md'>jakarta.activation-1.2.2.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 106.</strong> <strong>Group:</strong> com.sun.istack <strong>Name:</strong> istack-commons-runtime <strong>Version:</strong> 3.0.12 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='istack-commons-runtime-3.0.12.jar/META-INF/LICENSE.md'>istack-commons-runtime-3.0.12.jar/META-INF/LICENSE.md</a><br><a href='istack-commons-runtime-3.0.12.jar/META-INF/NOTICE.md'>istack-commons-runtime-3.0.12.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 107.</strong> <strong>Group:</strong> jakarta.annotation <strong>Name:</strong> jakarta.annotation-api <strong>Version:</strong> 1.3.5 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.ca'>https://projects.eclipse.org/projects/ee4j.ca</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md</a><br><a href='jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 108.</strong> <strong>Group:</strong> jakarta.persistence <strong>Name:</strong> jakarta.persistence-api <strong>Version:</strong> 2.2.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j/jpa-api'>https://github.com/eclipse-ee4j/jpa-api</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License v. 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<div class='dependency'>
<p><strong> 109.</strong> <strong>Group:</strong> jakarta.transaction <strong>Name:</strong> jakarta.transaction-api <strong>Version:</strong> 1.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j'>https://github.com/eclipse-ee4j</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.jta'>https://projects.eclipse.org/projects/ee4j.jta</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<div class='dependency'>
<p><strong> 110.</strong> <strong>Group:</strong> jakarta.xml.bind <strong>Name:</strong> jakarta.xml.bind-api <strong>Version:</strong> 2.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.xml.bind-api-2.3.3.jar/META-INF/LICENSE.md'>jakarta.xml.bind-api-2.3.3.jar/META-INF/LICENSE.md</a><br><a href='jakarta.xml.bind-api-2.3.3.jar/META-INF/NOTICE.md'>jakarta.xml.bind-api-2.3.3.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 111.</strong> <strong>Group:</strong> org.glassfish.jaxb <strong>Name:</strong> jaxb-runtime <strong>Version:</strong> 2.3.7 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://eclipse-ee4j.github.io/jaxb-ri/'>https://eclipse-ee4j.github.io/jaxb-ri/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jaxb-runtime-2.3.7.jar/META-INF/LICENSE.md'>jaxb-runtime-2.3.7.jar/META-INF/LICENSE.md</a><br><a href='jaxb-runtime-2.3.7.jar/META-INF/NOTICE.md'>jaxb-runtime-2.3.7.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 112.</strong> <strong>Group:</strong> org.glassfish.jaxb <strong>Name:</strong> txw2 <strong>Version:</strong> 2.3.7 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://eclipse-ee4j.github.io/jaxb-ri/'>https://eclipse-ee4j.github.io/jaxb-ri/</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Distribution License - v 1.0 - <a href='http://www.eclipse.org/org/documents/edl-v10.php'>http://www.eclipse.org/org/documents/edl-v10.php</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='txw2-2.3.7.jar/META-INF/LICENSE.md'>txw2-2.3.7.jar/META-INF/LICENSE.md</a><br><a href='txw2-2.3.7.jar/META-INF/NOTICE.md'>txw2-2.3.7.jar/META-INF/NOTICE.md</a></div>
</div>
<a id='project_GNU_Lesser_General_Public_License'></a>
<h3>GNU Lesser General Public License</h3>
<div class='dependency'>
<p><strong> 113.</strong> <strong>Group:</strong> ch.qos.logback <strong>Name:</strong> logback-classic <strong>Version:</strong> 1.2.11 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://www.qos.ch'>http://www.qos.ch</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License - v 1.0 - <a href='http://www.eclipse.org/legal/epl-v10.html'>http://www.eclipse.org/legal/epl-v10.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU Lesser General Public License - <a href='http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html'>http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html</a></div>
</div>
<div class='dependency'>
<p><strong> 114.</strong> <strong>Group:</strong> ch.qos.logback <strong>Name:</strong> logback-core <strong>Version:</strong> 1.2.11 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://www.qos.ch'>http://www.qos.ch</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License - v 1.0 - <a href='http://www.eclipse.org/legal/epl-v10.html'>http://www.eclipse.org/legal/epl-v10.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU Lesser General Public License - <a href='http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html'>http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html</a></div>
</div>
<a id='project_GNU_Library_General_Public_License_v2.1_or_later'></a>
<h3>GNU Library General Public License v2.1 or later</h3>
<div class='dependency'>
<p><strong> 115.</strong> <strong>Group:</strong> org.hibernate <strong>Name:</strong> hibernate-core <strong>Version:</strong> 5.6.14.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://hibernate.org/orm/5.6'>https://hibernate.org/orm/5.6</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://hibernate.org/orm'>https://hibernate.org/orm</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU Library General Public License v2.1 or later - <a href='https://www.opensource.org/licenses/LGPL-2.1'>https://www.opensource.org/licenses/LGPL-2.1</a></div>
</div>
<div class='dependency'>
<p><strong> 116.</strong> <strong>Group:</strong> org.hibernate.common <strong>Name:</strong> hibernate-commons-annotations <strong>Version:</strong> 5.1.2.Final </p><label>POM Project URL</label>
<div class='dependency-value'><a href='http://hibernate.org'>http://hibernate.org</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU Library General Public License v2.1 or later - <a href='http://www.opensource.org/licenses/LGPL-2.1'>http://www.opensource.org/licenses/LGPL-2.1</a></div>
</div>
<a id='project_GPL2_w/_CPE'></a>
<h3>GPL2 w/ CPE</h3>
<div class='dependency'>
<p><strong> 117.</strong> <strong>Group:</strong> jakarta.annotation <strong>Name:</strong> jakarta.annotation-api <strong>Version:</strong> 1.3.5 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://www.eclipse.org'>https://www.eclipse.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.ca'>https://projects.eclipse.org/projects/ee4j.ca</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/LICENSE.md</a><br><a href='jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md'>jakarta.annotation-api-1.3.5.jar/META-INF/NOTICE.md</a></div>
</div>
<div class='dependency'>
<p><strong> 118.</strong> <strong>Group:</strong> jakarta.transaction <strong>Name:</strong> jakarta.transaction-api <strong>Version:</strong> 1.3.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/eclipse-ee4j'>https://github.com/eclipse-ee4j</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://projects.eclipse.org/projects/ee4j.jta'>https://projects.eclipse.org/projects/ee4j.jta</a></div>
<label>POM License</label>
<div class='dependency-value'>EPL 2.0 - <a href='http://www.eclipse.org/legal/epl-2.0'>http://www.eclipse.org/legal/epl-2.0</a></div>
<label>POM License</label>
<div class='dependency-value'>Eclipse Public License v. 2.0 - <a href='https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt'>https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>GNU General Public License, version 2 with the GNU Classpath Exception - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>GPL2 w/ CPE - <a href='https://www.gnu.org/software/classpath/license.html'>https://www.gnu.org/software/classpath/license.html</a></div>
</div>
<a id='project_MIT_License'></a>
<h3>MIT License</h3>
<div class='dependency'>
<p><strong> 119.</strong> <strong>Group:</strong> org.slf4j <strong>Name:</strong> jul-to-slf4j <strong>Version:</strong> 1.7.36 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='http://www.slf4j.org'>http://www.slf4j.org</a></div>
<label>POM License</label>
<div class='dependency-value'>MIT License - <a href='http://www.opensource.org/licenses/mit-license.php'>http://www.opensource.org/licenses/mit-license.php</a></div>
</div>
<div class='dependency'>
<p><strong> 120.</strong> <strong>Group:</strong> org.slf4j <strong>Name:</strong> slf4j-api <strong>Version:</strong> 1.7.36 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='http://www.slf4j.org'>http://www.slf4j.org</a></div>
<label>POM License</label>
<div class='dependency-value'>MIT License - <a href='http://www.opensource.org/licenses/mit-license.php'>http://www.opensource.org/licenses/mit-license.php</a></div>
</div>
<a id='project_MIT-0'></a>
<h3>MIT-0</h3>
<div class='dependency'>
<p><strong> 121.</strong> <strong>Group:</strong> org.reactivestreams <strong>Name:</strong> reactive-streams <strong>Version:</strong> 1.0.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://reactive-streams.org'>http://reactive-streams.org</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='http://www.reactive-streams.org/'>http://www.reactive-streams.org/</a></div>
<label>POM License</label>
<div class='dependency-value'>MIT-0 - <a href='https://spdx.org/licenses/MIT-0.html'>https://spdx.org/licenses/MIT-0.html</a></div>
</div>
<a id='project_Public_Domain'></a>
<h3>Public Domain</h3>
<div class='dependency'>
<p><strong> 122.</strong> <strong>Group:</strong> org.jboss <strong>Name:</strong> jandex <strong>Version:</strong> 2.4.2.Final </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://www.jboss.org'>http://www.jboss.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>Public Domain - <a href='http://repository.jboss.org/licenses/cc0-1.0.txt'>http://repository.jboss.org/licenses/cc0-1.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 123.</strong> <strong>Group:</strong> org.jboss.logging <strong>Name:</strong> jboss-logging <strong>Version:</strong> 3.4.3.Final </p><label>Project URL</label>
<div class='dependency-value'><a href='http://www.jboss.org'>http://www.jboss.org</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>Public Domain - <a href='http://repository.jboss.org/licenses/cc0-1.0.txt'>http://repository.jboss.org/licenses/cc0-1.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jboss-logging-3.4.3.Final.jar/META-INF/LICENSE.txt'>jboss-logging-3.4.3.Final.jar/META-INF/LICENSE.txt</a></div>
</div>
<a id='project_The_Apache_Software_License,_Version_2.0'></a>
<h3>The Apache Software License, Version 2.0</h3>
<div class='dependency'>
<p><strong> 124.</strong> <strong>Group:</strong> com.fasterxml <strong>Name:</strong> classmate <strong>Version:</strong> 1.5.1 </p><label>Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/java-classmate'>https://github.com/FasterXML/java-classmate</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='classmate-1.5.1.jar/META-INF/LICENSE'>classmate-1.5.1.jar/META-INF/LICENSE</a><br><a href='classmate-1.5.1.jar/META-INF/NOTICE'>classmate-1.5.1.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 125.</strong> <strong>Group:</strong> com.fasterxml.jackson.core <strong>Name:</strong> jackson-annotations <strong>Version:</strong> 2.13.4 </p><label>Project URL</label>
<div class='dependency-value'><a href='http://github.com/FasterXML/jackson'>http://github.com/FasterXML/jackson</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-annotations-2.13.4.jar/META-INF/LICENSE'>jackson-annotations-2.13.4.jar/META-INF/LICENSE</a></div>
</div>
<div class='dependency'>
<p><strong> 126.</strong> <strong>Group:</strong> com.fasterxml.jackson.core <strong>Name:</strong> jackson-core <strong>Version:</strong> 2.13.4 </p><label>Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-core'>https://github.com/FasterXML/jackson-core</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-core-2.13.4.jar/META-INF/LICENSE'>jackson-core-2.13.4.jar/META-INF/LICENSE</a><br><a href='jackson-core-2.13.4.jar/META-INF/NOTICE'>jackson-core-2.13.4.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 127.</strong> <strong>Group:</strong> com.fasterxml.jackson.core <strong>Name:</strong> jackson-databind <strong>Version:</strong> 2.13.4.2 </p><label>Project URL</label>
<div class='dependency-value'><a href='http://github.com/FasterXML/jackson'>http://github.com/FasterXML/jackson</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-databind-2.13.4.2.jar/META-INF/LICENSE'>jackson-databind-2.13.4.2.jar/META-INF/LICENSE</a><br><a href='jackson-databind-2.13.4.2.jar/META-INF/NOTICE'>jackson-databind-2.13.4.2.jar/META-INF/NOTICE</a></div>
</div>
<div class='dependency'>
<p><strong> 128.</strong> <strong>Group:</strong> com.fasterxml.jackson.datatype <strong>Name:</strong> jackson-datatype-jdk8 <strong>Version:</strong> 2.13.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jdk8'>https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jdk8</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 129.</strong> <strong>Group:</strong> com.fasterxml.jackson.datatype <strong>Name:</strong> jackson-datatype-jsr310 <strong>Version:</strong> 2.13.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jsr310'>https://github.com/FasterXML/jackson-modules-java8/jackson-datatype-jsr310</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='jackson-datatype-jsr310-2.13.4.jar/META-INF/LICENSE'>jackson-datatype-jsr310-2.13.4.jar/META-INF/LICENSE</a></div>
</div>
<div class='dependency'>
<p><strong> 130.</strong> <strong>Group:</strong> com.fasterxml.jackson.module <strong>Name:</strong> jackson-module-parameter-names <strong>Version:</strong> 2.13.4 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/FasterXML/jackson-modules-java8/jackson-module-parameter-names'>https://github.com/FasterXML/jackson-modules-java8/jackson-module-parameter-names</a></div>
<label>POM License</label>
<div class='dependency-value'>Apache License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 131.</strong> <strong>Group:</strong> com.mysema.commons <strong>Name:</strong> mysema-commons-lang <strong>Version:</strong> 0.2.4 </p><label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 132.</strong> <strong>Group:</strong> com.nimbusds <strong>Name:</strong> content-type <strong>Version:</strong> 2.2 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://connect2id.com'>https://connect2id.com</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://bitbucket.org/connect2id/nimbus-content-type'>https://bitbucket.org/connect2id/nimbus-content-type</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 133.</strong> <strong>Group:</strong> com.nimbusds <strong>Name:</strong> lang-tag <strong>Version:</strong> 1.6 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://connect2id.com/'>https://connect2id.com/</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://bitbucket.org/connect2id/nimbus-language-tags'>https://bitbucket.org/connect2id/nimbus-language-tags</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 134.</strong> <strong>Group:</strong> com.nimbusds <strong>Name:</strong> nimbus-jose-jwt <strong>Version:</strong> 9.22 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://connect2id.com'>https://connect2id.com</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://bitbucket.org/connect2id/nimbus-jose-jwt'>https://bitbucket.org/connect2id/nimbus-jose-jwt</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 135.</strong> <strong>Group:</strong> com.zaxxer <strong>Name:</strong> HikariCP <strong>Version:</strong> 4.0.3 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='https://github.com/brettwooldridge'>https://github.com/brettwooldridge</a></div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/brettwooldridge/HikariCP'>https://github.com/brettwooldridge/HikariCP</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 136.</strong> <strong>Group:</strong> io.projectreactor.netty <strong>Name:</strong> reactor-netty-core <strong>Version:</strong> 1.0.27 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/reactor/reactor-netty'>https://github.com/reactor/reactor-netty</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 137.</strong> <strong>Group:</strong> io.projectreactor.netty <strong>Name:</strong> reactor-netty-http <strong>Version:</strong> 1.0.27 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/reactor/reactor-netty'>https://github.com/reactor/reactor-netty</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='https://www.apache.org/licenses/LICENSE-2.0.txt'>https://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 138.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-bean-validators <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 139.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-boot-starter <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 140.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-core <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 141.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-data-rest <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 142.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-oas <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 143.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-schema <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 144.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-spi <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 145.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-spring-web <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 146.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-spring-webflux <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 147.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-spring-webmvc <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 148.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-swagger-common <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 149.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-swagger-ui <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 150.</strong> <strong>Group:</strong> io.springfox <strong>Name:</strong> springfox-swagger2 <strong>Version:</strong> 3.0.0 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/springfox/springfox'>https://github.com/springfox/springfox</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 151.</strong> <strong>Group:</strong> net.minidev <strong>Name:</strong> accessors-smart <strong>Version:</strong> 2.4.8 </p><label>Project URL</label>
<div class='dependency-value'><a href='https://urielch.github.io/'>https://urielch.github.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 152.</strong> <strong>Group:</strong> net.minidev <strong>Name:</strong> json-smart <strong>Version:</strong> 2.4.8 </p><label>Project URL</label>
<div class='dependency-value'><a href='https://urielch.github.io/'>https://urielch.github.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 153.</strong> <strong>Group:</strong> org.mapstruct <strong>Name:</strong> mapstruct <strong>Version:</strong> 1.3.1.Final </p><label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='mapstruct-1.3.1.Final.jar/META-INF/LICENSE.txt'>mapstruct-1.3.1.Final.jar/META-INF/LICENSE.txt</a></div>
</div>
<div class='dependency'>
<p><strong> 154.</strong> <strong>Group:</strong> org.ow2.asm <strong>Name:</strong> asm <strong>Version:</strong> 9.1 </p><label>Manifest Project URL</label>
<div class='dependency-value'><a href='http://asm.ow2.org'>http://asm.ow2.org</a></div>
<label>Manifest License</label>
<div class='dependency-value'>BSD-3-Clause;link=https://asm.ow2.io/LICENSE.txt (Not Packaged)</div>
<label>POM Project URL</label>
<div class='dependency-value'><a href='http://asm.ow2.io/'>http://asm.ow2.io/</a></div>
<label>POM License</label>
<div class='dependency-value'>BSD-3-Clause - <a href='https://asm.ow2.io/license.html'>https://asm.ow2.io/license.html</a></div>
<label>POM License</label>
<div class='dependency-value'>The Apache Software License, Version 2.0 - <a href='http://www.apache.org/licenses/LICENSE-2.0.txt'>http://www.apache.org/licenses/LICENSE-2.0.txt</a></div>
</div>
<a id='project_The_GNU_General_Public_License,_v2_with_Universal_FOSS_Exception,_v1.0'></a>
<h3>The GNU General Public License, v2 with Universal FOSS Exception, v1.0</h3>
<div class='dependency'>
<p><strong> 155.</strong> <strong>Group:</strong> com.mysql <strong>Name:</strong> mysql-connector-j <strong>Version:</strong> 8.0.32 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='http://dev.mysql.com/doc/connector-j/en/'>http://dev.mysql.com/doc/connector-j/en/</a></div>
<label>POM License</label>
<div class='dependency-value'>The GNU General Public License, v2 with Universal FOSS Exception, v1.0</div>
<label>Embedded license files</label>
<div class='dependency-value'><a href='mysql-connector-j-8.0.32.jar/LICENSE'>mysql-connector-j-8.0.32.jar/LICENSE</a><br><a href='mysql-connector-j-8.0.32.jar/README'>mysql-connector-j-8.0.32.jar/README</a></div>
</div>
<a id='project_The_MIT_License_(MIT)'></a>
<h3>The MIT License (MIT)</h3>
<div class='dependency'>
<p><strong> 156.</strong> <strong>Group:</strong> com.auth0 <strong>Name:</strong> java-jwt <strong>Version:</strong> 4.2.1 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/auth0/java-jwt'>https://github.com/auth0/java-jwt</a></div>
<label>POM License</label>
<div class='dependency-value'>The MIT License (MIT) - <a href='https://raw.githubusercontent.com/auth0/java-jwt/master/LICENSE'>https://raw.githubusercontent.com/auth0/java-jwt/master/LICENSE</a></div>
</div>
<div class='dependency'>
<p><strong> 157.</strong> <strong>Group:</strong> io.github.classgraph <strong>Name:</strong> classgraph <strong>Version:</strong> 4.8.83 </p><label>POM Project URL</label>
<div class='dependency-value'><a href='https://github.com/classgraph/classgraph'>https://github.com/classgraph/classgraph</a></div>
<label>POM License</label>
<div class='dependency-value'>The MIT License (MIT) - <a href='http://opensource.org/licenses/MIT'>http://opensource.org/licenses/MIT</a></div>
</div>
<a id='project_Unknown'></a>
<h3>Unknown</h3>
<div class='dependency'>
<p><strong> 158.</strong> <strong>Group:</strong> com.fasterxml.jackson <strong>Name:</strong> jackson-bom <strong>Version:</strong> 2.13.4 </p></div>
</div>
</article>
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
