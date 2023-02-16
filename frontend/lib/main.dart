import 'package:find_toilet/screens/book_mark_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Toilet',
      theme: ThemeData(fontFamily: 'Kimm'),
      // home: const Intro(),
      home: const BookMarkMain(),
    );
  }
}
