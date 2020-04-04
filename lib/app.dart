import 'package:app_instagram/routes/router-constans.dart';
import 'package:app_instagram/routes/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeViewRoute,
      onGenerateRoute: generateRoute,
    );
  }
}

