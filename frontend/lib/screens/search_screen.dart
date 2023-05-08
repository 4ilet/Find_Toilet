import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/providers/toilet_provider.dart';
import 'package:find_toilet/screens/map_screen.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
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
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final Future<ToiletList> toiletList;
  @override
  void initState() {
    super.initState();
    if (!widget.showReview) {
      toiletList = ToiletProvider().searchToilet({
        'allDay': 1,
        'diaper': 1,
        'disabled': 1,
        'kids': 1,
        'lat': 37.537229,
        'lon': 127.005515,
        'page': 0,
        'size': 10,
      });
    }
  }

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
              SearchBar(isMain: false, query: widget.query),
              const FilterBox()
            ],
          ),
          Positioned.fill(
            child: ToiletBottomSheet(
              isMain: false,
              future: toiletList,
              showReview: widget.showReview,
              toiletModel: widget.toiletModel,
            ),
          ),
        ],
      ),
    );
  }
}
