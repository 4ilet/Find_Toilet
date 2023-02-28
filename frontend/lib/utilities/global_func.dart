import 'package:find_toilet/utilities/type_enum.dart';
import 'package:flutter/material.dart';

ReturnVoid routerPush({required BuildContext context, required Widget page}) {
  return () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

ReturnVoid routerPop({required BuildContext context}) {
  return () => Navigator.pop(context);
}

ReturnVoid showModal({required BuildContext context, required Widget page}) {
  return () {
    showDialog(context: context, builder: (context) => page);
  };
}
