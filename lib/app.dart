import 'package:flutter/material.dart';
import 'package:kiuqi/utils/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class App extends StatelessWidget {
  const App ({ Key? key }) : super(key: key);
  
  // This widget is the root of the application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Kiuqi',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      navigatorKey: navigatorKey,
      routes: routes,
    );
  }
}

