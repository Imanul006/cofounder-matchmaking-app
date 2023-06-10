import 'package:flutter/material.dart';
import 'package:kiuqi/screens/dashboard.dart';
import 'package:kiuqi/screens/discover/components/discover_item.dart';
import 'package:kiuqi/screens/discover/view/discover_page.dart';
import 'package:kiuqi/screens/login/view/login_page.dart';
import 'package:kiuqi/screens/profile/view/profile_page.dart';
import 'package:kiuqi/screens/splash_screen.dart';
import 'package:kiuqi/screens/user_details/view/user_details_screen.dart';


var routes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/user-details': (context) => const UserDetailsScreen(),
  '/discover':(context) => const DiscoverPage(),
  '/profile':(context) => const ProfilePage(),
  '/dashboard':(context) => const Dashboard(),
};
