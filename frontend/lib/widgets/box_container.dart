import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

class ThemeBox extends StatelessWidget {
  const ThemeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: whiteColor),
        child: const SizedBox(
          height: 200,
          width: 150,
          child: Text('큰 글씨'),
        ),
      ),
    );
  }
}
