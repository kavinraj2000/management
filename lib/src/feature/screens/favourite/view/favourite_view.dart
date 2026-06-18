import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvkapp/src/core/services/service_locator.dart';
import 'package:tvkapp/src/feature/screens/favourite/bloc/favourite_bloc.dart';
import 'package:tvkapp/src/feature/screens/favourite/view/mobile/favorites_page.dart';
import 'package:tvkapp/src/feature/screens/profile/repo/profile_repo.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(sl<ProfileRepository>()),
      child: FavoritesPage(),
    );
  }
}
