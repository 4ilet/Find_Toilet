import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/intro_screen.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/settings_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['nativeAppKey']);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
          child: const Intro(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
          child: const Main(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
          child: const Settings(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
          child: const BookMarkFolderList(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      title: 'Find Toilet',
      theme: ThemeData(fontFamily: 'Noto Sans'),
      // home: const Intro(),
      home: const Intro(),
    );
  }
}
