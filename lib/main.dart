import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'core/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Hive pour le stockage local
  await Hive.initFlutter();
  await LocalStorageService.init();
  
  // Initialiser les notifications
  await NotificationService.init();
  
  runApp(
    const ProviderScope(
      child: CommerceProxiIaApp(),
    ),
  );
}

class CommerceProxiIaApp extends StatelessWidget {
  const CommerceProxiIaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commerce Proxi-IA',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const App(),
      debugShowCheckedModeBanner: false,
    );
  }
}







