import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiuqi/app.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:kiuqi/constants/strings.dart';
import 'package:kiuqi/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: 
          Image.asset(
            ImageLinks.LOGO,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    bool authStatus;
    if (userData.containsKey('status')) {
      authStatus = userData.getBool('status')!;
    } else {
      authStatus = false;
    }
    List responses = [];
    bool _userHasDetails = false;

    try {
      responses = await Future.wait([
        // List of all futures which are required to load on splash screen
        context.read<LoginProvider>().checkUserHasData(),
        Future.delayed(const Duration(milliseconds: 1500)),
      ]);
    } catch (e) {
      if (kDebugMode) print("Exception : $e");
    }

    if (responses.isNotEmpty) {
      _userHasDetails = responses[0];
    }

    if (authStatus) {
      context.read<LoginProvider>().disposeValues();
      print("User Has Details ::::::" + _userHasDetails.toString());
      if (_userHasDetails) {
        Navigator.of(navigatorKey.currentContext!)
            .pushReplacementNamed('/dashboard');
      } else {
        Navigator.of(navigatorKey.currentContext!)
            .pushReplacementNamed('/user-details');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }

    // Uncomment below line to debug a specific page
    // Navigator.of(context).pushReplacementNamed('/login');
    // Navigator.of(context).pushReplacementNamed('/user-details');
  }
}
