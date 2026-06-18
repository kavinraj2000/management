import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilediscovery/src/core/services/service_locator.dart';
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
import 'package:profilediscovery/src/feature/screens/settings/bloc/setting_bloc.dart';
import 'package:profilediscovery/src/feature/screens/settings/view/mobile/settings_page.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(sl<PreferencesService>()),
      child: SettingsPage(),
    );
  }
}
