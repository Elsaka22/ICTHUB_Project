import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icthub_2/Screens/Login_Screen.dart';
import 'package:icthub_2/firebase_options.dart';
import 'package:icthub_2/Screens/home_layout.dart';
import 'package:icthub_2/Screens/list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


User? user = FirebaseAuth.instance.currentUser;  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null? const HomeLayout() : const LoginScreen()
    );

  }
}
