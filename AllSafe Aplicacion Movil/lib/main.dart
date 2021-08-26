import 'package:flutter/material.dart';
import 'package:allsafe_appmobile/src/pages/dashboard.dart';
import 'package:allsafe_appmobile/src/pages/login.dart';
import 'package:allsafe_appmobile/src/pages/check_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Allsafe',
      initialRoute: '/check',
      routes: {
        '/dashboard': (_) => Dashboard(),
        '/login': (_) => Login(),
        '/check': (_) => CheckStorage()
      },
    );
  }
}
