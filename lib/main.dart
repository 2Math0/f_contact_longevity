import 'package:f_contact_longevity/presentation/resources/theme_manager.dart';
import 'package:f_contact_longevity/presentation/view/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: Routes.splashRoute,
      title: 'F-Contact',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: const ChatScreen(),
    );
  }
}
