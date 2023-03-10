import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['nativeAppKey']);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      title: 'Find Toilet',
      theme: ThemeData(fontFamily: 'Kimm'),
      // home: const Intro(),
      home: const Main(),
      // home: const Settings(),
    );
  }
}
