import 'dart:async';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/screens/search_screen.dart';
import 'package:find_toilet/screens/select_theme_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  void preparation() async {
    try {
      await context.read<UserInfoProvider>().initVar();
      final result = await UserProvider().autoLogin();
      if (!mounted) return;
      if (result.isNotEmpty) {
        changeToken(
          context,
          token: result['token'],
          refresh: result['refresh'],
        );
      }
    } catch (error) {
      if (!mounted) return;
      changeToken(
        context,
        token: null,
        refresh: null,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    preparation();
    context.read<SettingsProvider>().initSettings();
    Future.delayed(const Duration(seconds: 5), () {
      removedRouterPush(
        context,
        page: getFontSize(context) == null
            ? const SelectFontTheme()
            : const Search(query: '문흥동'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidth(context) == 0.0) {
      context.read<SizeProvider>().initWidthHeight(context);
    }
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(child: Image.asset(logo)),
    );
  }
}
