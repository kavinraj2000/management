import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:profilediscovery/src/data/domain/user_entity.dart';
import 'package:profilediscovery/src/feature/screens/profile/repo/profile_repo.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ProfileRepository _profileRepository;

  FavoritesBloc(this._profileRepository) : super(const FavoritesState()) {
    on<FavoritesLoadRequested>(_onLoad);
    on<FavoritesRefreshRequested>(_onRefresh);
    on<FavoritesRemoveProfile>(_onRemove);
  }

  Future<void> _onLoad(
    FavoritesLoadRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    try {
      final favorites = await _profileRepository.getFavoriteProfiles();

      emit(
        state.copyWith(
          status: FavoritesStatus.success,
          profiles: favorites,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoritesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefresh(
    FavoritesRefreshRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.refreshing));

    try {
      final favorites = await _profileRepository.getFavoriteProfiles();

      emit(
        state.copyWith(
          status: FavoritesStatus.success,
          profiles: favorites,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoritesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRemove(
    FavoritesRemoveProfile event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _profileRepository.toggleFavorite(event.profileId);

      final updated = state.profiles
          .where((profile) => profile?.id != event.profileId)
          .toList();

      emit(state.copyWith(status: FavoritesStatus.success, profiles: updated));
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoritesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
