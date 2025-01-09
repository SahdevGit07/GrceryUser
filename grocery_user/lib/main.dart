import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_user/View/Splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAvyNw3_XifHvQXRQiQHv2cgwCPO_oSg5g",
          appId: "1:179091458983:android:f5f7b29a6be3b1a770c482",
          messagingSenderId: "179091458983",
          projectId: "groceryapp-c5861",
          storageBucket: "groceryapp-c5861.firebasestorage.app"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
