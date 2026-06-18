import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilediscovery/src/core/services/service_locator.dart';
import 'package:profilediscovery/src/feature/auth/repo/auth_repo.dart';
import 'package:profilediscovery/src/feature/screens/profile/bloc/profile_bloc.dart';
import 'package:profilediscovery/src/feature/screens/profile/view/mobile/my_profile_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(sl<AuthRepository>()),
      child: MyProfilePage(),
    );
  }
}
