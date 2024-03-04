import 'package:flutter/material.dart';
import 'package:task_ai/pages/home_page.dart';

void main()=> runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.grey.shade900,
        
      ),
    );
  }
}