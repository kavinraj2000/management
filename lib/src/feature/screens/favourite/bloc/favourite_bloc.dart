// lib/presentation/blocs/favorites/favorites_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profilediscovery/src/data/domain/user_entity.dart';
import 'package:profilediscovery/src/feature/screens/profile/repo/profile_repo.dart';


class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ProfileRepository _profileRepository;

  FavoritesBloc(this._profileRepository) : super(const FavoritesInitial()) {
    on<FavoritesLoadRequested>(_onLoad);
    on<FavoritesRemoveProfile>(_onRemove);
  }

  Future<void> _onLoad(
    FavoritesLoadRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    try {
      final favorites = await _profileRepository.getFavoriteProfiles();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemove(
    FavoritesRemoveProfile event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesLoaded) return;
    final currentState = state as FavoritesLoaded;

    try {
      await _profileRepository.toggleFavorite(event.profileId);
      final updated = currentState.profiles
          .where((p) => p?.id != event.profileId)
          .toList();
      emit(FavoritesLoaded(updated));
    } catch (e) {
      // Silent fail
    }
  }
}

// lib/presentation/blocs/favorites/favorites_event.dart

// part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesLoadRequested extends FavoritesEvent {
  const FavoritesLoadRequested();
}

class FavoritesRemoveProfile extends FavoritesEvent {
  final String profileId;

  const FavoritesRemoveProfile(this.profileId);

  @override
  List<Object?> get props => [profileId];
}

// lib/presentation/blocs/favorites/favorites_state.dart

// part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<ProfileEntity> profiles;

  const FavoritesLoaded(this.profiles);

  @override
  List<Object?> get props => [profiles];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}