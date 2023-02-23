import 'package:find_toilet/utilities/icondata.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  final List<String> selectList;
  final double width, height;
  const SelectBox(
      {super.key,
      required this.selectList,
      required this.width,
      required this.height});

  @override
  State<SelectBox> createState() => _SelectBox();
}

class _SelectBox extends State<SelectBox> {
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          elevation: 10,
          value: dropdownValue,
          icon: const CustomIcon(icon: toDownIcon, size: 20),
          // menuMaxHeight: widget.height * widget.selectList.length,
          // elevation: 16,
          style: const TextStyle(color: blackColor),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items:
              widget.selectList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                height: widget.height,
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
