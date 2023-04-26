import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final Widget? Function(BuildContext, int) itemBuilder;
  const CustomListView({super.key, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: itemBuilder,
    );
  }
}
