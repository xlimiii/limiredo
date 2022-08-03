import 'dart:io';

import 'package:flutter/material.dart';
import 'package:limiredo/models/sound_model';
import 'package:limiredo/datasources/limiredo_api.dart';

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
      home: const MyHomePage(title: 'Limiredo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SoundModel? _soundModel;
  bool _isSound = false;

  void _playPauseMusic() {
    _getData();
    setState(() {
      _isSound = !_isSound;
    });
  }

  void _getData() async {
    _soundModel = await LimiredoApi().getSound(1);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Can you hear the music? ',
            ),
            _isSound
                ? Text(
                    _soundModel == null
                        ? 'YES'
                        : _soundModel!.height.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  )
                : Text('NO', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _playPauseMusic,
        tooltip: 'play/pause',
        child: Icon(_isSound ? Icons.pause : Icons.play_arrow),
      ),
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
