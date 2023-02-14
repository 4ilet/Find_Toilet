import 'dart:async';

import 'package:find_toilet/screens/select_theme_screen.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    void toNext() {
      if (isLoading) {
        setState(() => isLoading = false);
        Timer(const Duration(seconds: 5), () {
          if (isLoading) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelectFontTheme()));
          }
        });
      }
    }

    toNext();

    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Image.asset('assets/logos/logo_2.png'),
      ),
    );
  }
}
