import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/skill_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'services/crash_reporting_service.dart';
import 'services/analytics_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(LoadingApp());

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'your-api-key',
        appId: 'your-app-id',
        messagingSenderId: 'your-sender-id',
        projectId: 'your-project-id',
      ),
    );

    // Initialize crash reporting
    await CrashReportingService.initialize();

    // Run the app
    runApp(MyApp());
  } catch (e, stackTrace) {
    await CrashReportingService.recordError(
      error: e,
      stackTrace: stackTrace,
      reason: 'Error initializing app',
    );
    runApp(ErrorApp(error: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SkillProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'SkillBridge Community',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routes: AppRoutes.routes,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            onUnknownRoute: AppRoutes.onUnknownRoute,
            initialRoute: '/admin/login',
            navigatorObservers: [
              FirebaseAnalyticsObserver(
                analytics: FirebaseAnalytics.instance,
              ),
            ],
          );
        },
      ),
    );
  }
}

// LoadingApp and ErrorApp components remain the same...
