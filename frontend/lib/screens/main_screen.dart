import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    void toBookMark() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BookMarkMain()));
    }

    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text('여기는 메인'),
          IconButton(
              onPressed: toBookMark,
              icon: const Icon(Icons.star_border_rounded))
        ],
      ),
    );
  }
}
