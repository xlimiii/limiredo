import 'dart:io';
import 'package:flutter/material.dart';
import 'package:limiredo/pages/welcome_page.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Limiredo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const WelcomePage(),
    );
  }
}

//TODO - for developing only
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
