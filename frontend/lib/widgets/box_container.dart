import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/material.dart';

class ThemeBox extends StatelessWidget {
  final String text;
  const ThemeBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: CommonBox(
          height: 220,
          width: 170,
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CommonBox(
                color: Colors.grey,
                height: 130,
                width: 130,
              ),
              Text(
                text,
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
  const CommonBox({
    super.key,
    this.child,
    this.color,
    required this.height,
    required this.width,
  });

  @override
  State<CommonBox> createState() => _CommonBoxState();
}

class _CommonBoxState extends State<CommonBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: widget.color),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: widget.child,
      ),
    );
  }
}
