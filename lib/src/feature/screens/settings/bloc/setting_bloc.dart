// lib/presentation/blocs/settings/settings_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:tvkapp/src/data/repo/prefernces_repo.dart';
=======
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

// part 'settings_event.dart';
// part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final PreferencesService _prefs;

  SettingsBloc(this._prefs) : super(SettingsInitial(_prefs.isDarkMode)) {
    on<SettingsLoadRequested>(_onLoad);
    on<SettingsToggleDarkMode>(_onToggleDarkMode);
  }

  Future<void> _onLoad(
    SettingsLoadRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoaded(isDarkMode: _prefs.isDarkMode));
  }

  Future<void> _onToggleDarkMode(
    SettingsToggleDarkMode event,
    Emitter<SettingsState> emit,
  ) async {
    final isDark = !_prefs.isDarkMode;
    await _prefs.setDarkMode(isDark);
    emit(SettingsLoaded(isDarkMode: isDark));
  }
}

// lib/presentation/blocs/settings/settings_event.dart

// part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {
  const SettingsLoadRequested();
}

class SettingsToggleDarkMode extends SettingsEvent {
  const SettingsToggleDarkMode();
}

// lib/presentation/blocs/settings/settings_state.dart

// part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final bool isDarkMode;

  const SettingsState(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(super.isDarkMode);
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required bool isDarkMode}) : super(isDarkMode);
}