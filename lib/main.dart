import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resturent_book/dashboard_pages/home.dart';
import 'package:resturent_book/routes.dart';

import 'auth_pages/getting_started.dart';
import 'auth_pages/login.dart';
import 'auth_pages/signup.dart';
import 'pages/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Getting_Started(),
      onGenerateRoute: generateRoute,
    );
  }
}
