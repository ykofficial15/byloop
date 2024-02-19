import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice/Views/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Views/Login.dart';
import '../Models/authenticate.dart';

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

runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Authenticate>(
          create: (context) => Authenticate(false), //Pass initial value for _isLoggedIn
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data as SharedPreferences;
            final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

            return ChangeNotifierProvider(
              create: (context) => Authenticate(isLoggedIn), // Provide the initial login status
              child: AnimatedSplashScreen(
                duration: 3000,
                splash: Image.asset('assets/logo.png'),
                splashIconSize: 300,
                nextScreen: isLoggedIn ? Home() : Login(),
                backgroundColor: Colors.orange,
              ),
            );
          } else {
            return Center(child:CircularProgressIndicator(color:Colors.orange));
          }
        },
      ),
    );
  }
}