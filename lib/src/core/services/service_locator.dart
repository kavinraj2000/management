// lib/di/injection_container.dart

import 'package:get_it/get_it.dart';
<<<<<<< HEAD
import 'package:tvkapp/src/core/bloc/filter/filter_bloc.dart';
import 'package:tvkapp/src/core/network/dio_network.dart';
import 'package:tvkapp/src/core/storage/data_base_helper.dart';
import 'package:tvkapp/src/data/datasource/remote/profile_data_source.dart';
import 'package:tvkapp/src/data/repo/prefernces_repo.dart';
import 'package:tvkapp/src/feature/auth/bloc/auth_bloc.dart';
import 'package:tvkapp/src/feature/auth/repo/auth_repo.dart';
import 'package:tvkapp/src/feature/screens/auth/bloc/splash_bloc.dart';
import 'package:tvkapp/src/feature/screens/discovery/bloc/dicovery_bloc.dart';
import 'package:tvkapp/src/feature/screens/favourite/bloc/favourite_bloc.dart';
import 'package:tvkapp/src/feature/screens/profile/bloc/profile_bloc.dart';
import 'package:tvkapp/src/feature/screens/profile/repo/profile_repo.dart';
import 'package:tvkapp/src/feature/screens/settings/bloc/setting_bloc.dart';
=======
import 'package:profilediscovery/src/core/bloc/filter/filter_bloc.dart';
import 'package:profilediscovery/src/core/network/dio_network.dart';
import 'package:profilediscovery/src/core/storage/data_base_helper.dart';
import 'package:profilediscovery/src/data/datasource/remote/profile_data_source.dart';
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
import 'package:profilediscovery/src/feature/auth/bloc/auth_bloc.dart';
import 'package:profilediscovery/src/feature/auth/repo/auth_repo.dart';
import 'package:profilediscovery/src/feature/screens/auth/bloc/splash_bloc.dart';
import 'package:profilediscovery/src/feature/screens/discovery/bloc/dicovery_bloc.dart';
import 'package:profilediscovery/src/feature/screens/favourite/bloc/favourite_bloc.dart';
import 'package:profilediscovery/src/feature/screens/profile/bloc/profile_bloc.dart';
import 'package:profilediscovery/src/feature/screens/profile/repo/profile_repo.dart';
import 'package:profilediscovery/src/feature/screens/settings/bloc/setting_bloc.dart';


>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
final sl = GetIt.instance;

Future<void> init() async {
  final prefs = PreferencesService();
  await prefs.init();
  sl.registerSingleton<PreferencesService>(prefs);

<<<<<<< HEAD
  // Register Database
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());

  // Register Dio
  sl.registerSingleton<DioClient>(DioClient());

  // Register Data Source
=======
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  sl.registerSingleton<DioClient>(DioClient());

>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
  sl.registerSingleton<ProfileRemoteDataSource>(
    ProfileRemoteDataSourceImpl(sl<DioClient>()),
  );

<<<<<<< HEAD
  // Register Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepository(
      sl<DatabaseHelper>(),
      sl<PreferencesService>(),
    ),
=======
  sl.registerSingleton<AuthRepository>(
    AuthRepository(sl<DatabaseHelper>(), sl<PreferencesService>()),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
  );

  sl.registerSingleton<ProfileRepository>(
    ProfileRepository(
      sl<ProfileRemoteDataSource>(),
      sl<DatabaseHelper>(),
      sl<PreferencesService>(),
    ),
  );

<<<<<<< HEAD
  // Register Blocs
  sl.registerFactory(() => AuthBloc(sl<AuthRepository>()));
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => FilterBloc());
  sl.registerFactory(() => ProfileBloc(sl<AuthRepository>()));
  sl.registerFactory(() => DiscoveryBloc(sl<ProfileRepository>()));
  sl.registerFactory(() => SettingsBloc(sl<PreferencesService>()));
  sl.registerFactory(() => FavoritesBloc(sl<ProfileRepository>()));
=======
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));
  sl.registerFactory<SplashBloc>(() => SplashBloc());
  sl.registerFactory<FilterBloc>(() => FilterBloc());
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl<AuthRepository>()));
  sl.registerFactory<DiscoveryBloc>(() => DiscoveryBloc(sl<ProfileRepository>()));
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(sl<PreferencesService>()));
  sl.registerFactory<FavoritesBloc>(() => FavoritesBloc(sl<ProfileRepository>()));
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
}