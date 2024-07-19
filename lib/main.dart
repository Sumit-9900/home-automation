import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_automation/firebase_options.dart';
import 'package:home_automation/provider/auth_provider.dart' as authprovider;
import 'package:home_automation/provider/bottom_nav_provider.dart';
import 'package:home_automation/provider/theme_provider.dart';
import 'package:home_automation/screens/auth_page.dart';
import 'package:home_automation/screens/bottom_nav_page.dart';
import 'package:home_automation/services/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authprovider.AuthProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Home Automation',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeprovider.themeMode,
      home: FirebaseAuth.instance.currentUser != null
          ? const BottomNavPage()
          : const AuthPage(),
    );
  }
}
