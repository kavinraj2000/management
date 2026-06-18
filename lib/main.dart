import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tvkapp/app/app.dart';
import 'package:tvkapp/src/core/services/service_locator.dart' as di;
import 'package:tvkapp/src/core/storage/data_base_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS||Platform.) {
  //   DatabaseHelper();
  //   databaseFactory = databaseFactoryFfi;
  // }
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => App(),
    ),
  );
}
