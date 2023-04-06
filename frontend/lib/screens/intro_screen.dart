import 'dart:async';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/providers/user_provider.dart';
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
    Future.delayed(
      const Duration(seconds: 5),
      routerPush(context, page: const SelectFontTheme()),
    );
    preparation();
  }

  @override
  Widget build(BuildContext context) {
    initWidthHeight(context);
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(child: Image.asset(logo)),
    );
  }
}
