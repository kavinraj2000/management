import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvkapp/src/core/services/service_locator.dart';
import 'package:tvkapp/src/feature/screens/discovery/bloc/dicovery_bloc.dart';
import 'package:tvkapp/src/feature/screens/discovery/view/mobile/discovery_mobile_view.dart';
import 'package:tvkapp/src/feature/screens/profile/repo/profile_repo.dart';


class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoveryBloc(sl<ProfileRepository>()),
      child: DiscoveryPage(),
    );
  }
}
