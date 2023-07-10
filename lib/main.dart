import 'package:doc_tracker/Controllers/Firebase/StatusAuth.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/documents.dart';
import 'package:doc_tracker/Views/home.dart';
import 'package:doc_tracker/Views/home_screen.dart';
import 'package:doc_tracker/Views/theme_const.dart';
import 'package:doc_tracker/Views/theme_manager.dart';
import 'package:doc_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      ColorApp().init(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/Models/i18n'];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                LocalJsonLocalization.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('fr', 'FR'),
              ],
      title: 'Doc Tracker',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      
      home: DocumentsScreen(),
    );
  }
}
