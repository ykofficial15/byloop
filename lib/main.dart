import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../Views/Login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAqQTQNYw5yO87YQpycxzeNK8bkdh-Ibus',
      appId: '1:930799316594:android:f79297510511ac14255ceb',
      messagingSenderId: 'YOUR_SENDER_ID', 
      projectId: 'practice-d62dd',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  AnimatedSplashScreen(
                duration: 3000,
                splash: Container(child: Image.asset('assets/logo.png')),
                splashIconSize: 300,
                nextScreen: Login(),
                backgroundColor: Colors.orange,
              ),
    );
  }
}