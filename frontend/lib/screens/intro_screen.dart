import 'dart:async';

import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/screens/select_theme_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),
        routerPush(context, page: const SelectFontTheme()));
    UserProvider().autoLogin();
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
