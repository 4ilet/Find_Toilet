import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:find_toilet/screens/settings_screen.dart';
import 'package:find_toilet/utilities/icon.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    void toBookMark() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BookMarkMain(folderCnt: 4)));
    }

    void toSettings() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Settings()));
    }

    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            height: 100,
          ),
          IconButton(onPressed: toSettings, icon: const Icon(hamburgerIcon)),
          const Text('여기는 메인'),
          IconButton(onPressed: toBookMark, icon: const Icon(starIcon))
        ],
      ),
    );
  }
}
