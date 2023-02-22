import 'package:find_toilet/utilities/style.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            itemHeight: 50,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            // elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items:
                widget.selectList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
