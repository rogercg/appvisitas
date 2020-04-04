import 'package:app_instagram/routes/router-constans.dart';
import 'package:app_instagram/views/home-view.dart';
import 'package:app_instagram/views/splash-view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) { 
  
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    default:
      return MaterialPageRoute(builder: (context) => SplashView(), maintainState: false);
  }
}
