import 'package:bloc_counter/counter/presentation/pages/main_counter_page.dart';
import 'package:bloc_counter/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number trivia',
      theme: ThemeData(
        primaryColor: Colors.grey.shade800,
        accentColor: Colors.grey.shade600,
      ),
      home: MainCounterPage(),
    );
  }
}
