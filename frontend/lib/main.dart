import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['nativeAppKey']);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInfoProvider()),
        ChangeNotifierProvider(create: (context) => ApplyChangeProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => SizeProvider()),
        ChangeNotifierProvider(create: (context) => GlobalProvider()),
      ],
      child: MaterialApp(
        title: 'Find Toilet',
        theme: ThemeData(fontFamily: 'Noto Sans'),
        home: const Intro(),
      ),
    );
  }
}
