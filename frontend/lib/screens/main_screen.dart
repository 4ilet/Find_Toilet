import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/map_widget.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  final bool showReview;
  const Main({super.key, this.showReview = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const MapScreen(),
                ),
              ],
            ),
            Column(children: const [SearchBar(isMain: true), FilterBox()]),
            const ToiletBottomSheet(isMain: true, showReview: showReview)
          ],
        ),

      ),
    );
  }
}
