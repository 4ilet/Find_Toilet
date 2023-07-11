// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/providers/user_provider.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/select_theme_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
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
      await UserProvider().autoLogin();
    } catch (error) {
      changeToken(
        context,
        token: null,
        refresh: null,
      );
    }
  }

  Future<Position> userLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setLatLng(context, position.latitude, position.longitude);
      return position;
    } catch (error) {
      throw Error();
    }
  }

  @override
  void initState() {
    super.initState();
    preparation();
    context.read<SettingsProvider>().initSettings();
    userLocation().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        setRadius(context);
        removedRouterPush(
          context,
          page: getFontSize(context) == null
              ? const SelectFontTheme()
              : const Main(),
        );
      });
    }).catchError((_) {
      SystemNavigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (screenWidth(context) == 0.0) {
    //   context.read<SizeProvider>().initWidthHeight(context);
    // }
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(child: Image.asset(logo)),
    );
  }
}
