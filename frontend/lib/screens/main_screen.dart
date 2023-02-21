import 'package:find_toilet/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SearchBar(),
        ],
      ),
    );
  }
}
