import 'package:flutter/material.dart';
import 'package:profilediscovery/app/routes.dart';
import 'package:profilediscovery/src/core/theme/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter().router,
    );
  }
}
