import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilediscovery/src/core/services/service_locator.dart';
import 'package:profilediscovery/src/feature/auth/bloc/auth_bloc.dart';
import 'package:profilediscovery/src/feature/auth/repo/auth_repo.dart';
import 'package:profilediscovery/src/feature/presentation/login/login_mobile_view.dart';
import 'package:profilediscovery/src/feature/presentation/register/register_mobile_view.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl<AuthRepository>()),
      child: LoginPage(),
    );
  }
}
