import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvkapp/src/core/services/service_locator.dart';
import 'package:tvkapp/src/feature/auth/bloc/auth_bloc.dart';
import 'package:tvkapp/src/feature/auth/repo/auth_repo.dart';
import 'package:tvkapp/src/feature/presentation/forgot/forgot_mobile_view.dart';


class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl<AuthRepository>()),
      child: ForgotPasswordPage(),
    );
  }
}
