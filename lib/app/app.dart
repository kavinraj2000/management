import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:tvkapp/app/routes.dart';
import 'package:tvkapp/src/core/theme/app_theme.dart';
=======
import 'package:flutter/widgets.dart';
import 'package:profilediscovery/src/core/theme/app_theme.dart';
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
<<<<<<< HEAD
      routerConfig: AppRouter().router,
    );
  }
}
=======
      routerConfig:Routes. ,
    );
  }
}
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
