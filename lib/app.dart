import 'package:flutter/material.dart';
import 'ChatApp/page/home_page.dart';
import 'ChatApp/services/auth/auth_gate.dart';
import 'ChatApp/services/login_or_register.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // brightness: Brightness.dark,
        // primaryColor: Colors.blue,
        // primarySwatch: Colors.blue,
        // scaffoldBackgroundColor: Colors.grey,

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 18),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 18),
          labelStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

      home: AuthGate(),
    );
  }
}
