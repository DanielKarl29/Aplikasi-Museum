import 'package:flutter/material.dart';
import 'view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Museum Indonesia',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 9, 135, 207),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}
