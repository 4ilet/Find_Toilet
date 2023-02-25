import 'package:flutter/material.dart';

void routerPush({required BuildContext context, required Widget page}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void routerPop({required BuildContext context}) {
  Navigator.pop(context);
}
