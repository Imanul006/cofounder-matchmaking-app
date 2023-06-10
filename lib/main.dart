import 'package:flutter/material.dart';
import 'package:kiuqi/app.dart';
import 'package:kiuqi/providers/actions_provider.dart';
import 'package:kiuqi/providers/cofounder_provider.dart';
import 'package:kiuqi/providers/login_provider.dart';
import 'package:kiuqi/providers/user_details_provider.dart';
import 'package:provider/provider.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CofounderProvider()),
        ChangeNotifierProvider(create: (_) => ActionsProvider()),
      ],
      child: const App(),
    ),
  );
}
