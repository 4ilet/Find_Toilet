import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

class ThemeBox extends StatefulWidget {
  final String text;
  late bool selected;
  ThemeBox({super.key, required this.text, required this.selected});

  @override
  State<ThemeBox> createState() => _ThemeBoxState();
}

class _ThemeBoxState extends State<ThemeBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: CommonBox(
          height: 220,
          width: 170,
          color: whiteColor,
          selected: widget.selected,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonBox(
                color: Colors.grey,
                height: 130,
                width: 130,
              ),
              Text(
                widget.text,
                style: const TextStyle(fontSize: defaultSize),
              ),
            ],
          )),
    );
  }
}

class CommonBox extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final double height;
  final double width;
  late bool selected;
  CommonBox({
    super.key,
    this.child,
    this.color,
    required this.height,
    required this.width,
    this.selected = false,
  });

  @override
  State<CommonBox> createState() => _CommonBoxState();
}

class _CommonBoxState extends State<CommonBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
        boxShadow: widget.selected
            ? const [
                BoxShadow(blurRadius: 10, spreadRadius: 5, color: Colors.red),
              ]
            : null,
      ),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: widget.child,
      ),
    );
  }
}
