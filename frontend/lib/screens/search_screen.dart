import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/screens/map_screen.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final String query;
  final bool showReview;
  final ToiletModel? toiletModel;
  const Search({
    super.key,
    required this.query,
    this.showReview = false,
    this.toiletModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Column(
            children: [
              SearchBar(isMain: false, query: query),
              const FilterBox()
            ],
          ),
          Positioned.fill(
            child: ToiletBottomSheet(
              isMain: false,
              showReview: showReview,
              toiletModel: toiletModel,
            ),
          ),
        ],
      ),
    );
  }
}
