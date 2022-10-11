import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/responsive_layout_screen/responsive.dart';
import 'package:instagram_clone/responsive_layout_screen/web_screen_layout.dart';

import 'package:instagram_clone/screen/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      home: const ResponsiveLayout(
        mobscreenlayout: SignUpScreen(),
        webscreenlayout: WebScreenLayout(),
      ),
    );
  }
}
