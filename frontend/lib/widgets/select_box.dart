import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/icon.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  final List<String> selectList;
  final double width, height;
  final ReturnVoid onTap;
  final bool showList;
  const SelectBox({
    super.key,
    required this.selectList,
    required this.width,
    required this.height,
    required this.onTap,
    required this.showList,
  });

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
    return CustomBox(
      onTap: widget.onTap,
      width: widget.width,
      height: widget.height,
      color: whiteColor,
      radius: 5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: dropdownValue,
                  font: notoSans,
                  fontSize: FontSize.smallSize,
                ),
                const CustomIcon(icon: toDownIcon)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class SelectBox extends StatefulWidget {
//   final List<String> selectList;
//   final double width, height;
//   const SelectBox(
//       {super.key,
//       required this.selectList,
//       required this.width,
//       required this.height});

//   @override
//   State<SelectBox> createState() => _SelectBox();
// }

// class _SelectBox extends State<SelectBox> {
//   late String dropdownValue;
//   @override
//   void initState() {
//     super.initState();
//     dropdownValue = widget.selectList.first;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomBox(
//       width: widget.width,
//       height: widget.height,
//       color: whiteColor,
//       radius: 5,
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           elevation: 10,
//           value: dropdownValue,
//           icon: const CustomIcon(icon: toDownIcon, size: 20),
//           // menuMaxHeight: widget.height * widget.selectList.length,
//           // elevation: 16,
//           style: const TextStyle(color: blackColor),
//           onChanged: (String? value) {
//             setState(() {
//               dropdownValue = value!;
//             });
//           },
//           items:
//               widget.selectList.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: SizedBox(
//                 height: widget.height,
//                 child: Text(value),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

