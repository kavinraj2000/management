import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profilediscovery/src/data/domain/user_entity.dart';
import 'package:profilediscovery/src/feature/screens/profile/repo/profile_repo.dart';


part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final ProfileRepository _profileRepository;

  int _currentPage = 1;
  bool _hasMore = true;

  DiscoveryBloc(this._profileRepository)
      : super(const DiscoveryState()) {
    on<DiscoveryLoadProfiles>(_onLoad);
    on<DiscoveryLoadMore>(_onLoadMore);
    on<DiscoverySearchProfiles>(_onSearch);
    on<DiscoveryFilterProfiles>(_onFilter);
    on<DiscoveryToggleFavorite>(_onToggleFavorite);
    on<DiscoveryRefresh>(_onRefresh);
  }

  Future<void> _onLoad(
    DiscoveryLoadProfiles event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DiscoveryStatus.loading,
        errorMessage: null,
      ),
    );

    _currentPage = 1;
    _hasMore = true;

    try {
      final profiles = await _profileRepository.getProfiles(
        page: 1,
      );

      _hasMore = profiles.length >= 10;

      emit(
        state.copyWith(
          status: DiscoveryStatus.success,
          profiles: profiles,
          hasMore: _hasMore,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DiscoveryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    DiscoveryLoadMore event,
    Emitter<DiscoveryState> emit,
  ) async {
    if (!_hasMore) return;

    emit(
      state.copyWith(
        status: DiscoveryStatus.loadingMore,
      ),
    );

    try {
      _currentPage++;

      final profiles = await _profileRepository.getProfiles(
        page: _currentPage,
        query: state.query,
        gender: state.genderFilter,
        minAge: state.minAge,
        maxAge: state.maxAge,
      );

      _hasMore = profiles.length >= 10;

      emit(
        state.copyWith(
          status: DiscoveryStatus.success,
          profiles: [
            ...state.profiles,
            ...profiles,
          ],
          hasMore: _hasMore,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DiscoveryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSearch(
    DiscoverySearchProfiles event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DiscoveryStatus.loading,
        searchQuery: event.query,
      ),
    );

    _currentPage = 1;

    try {
      final profiles = await _profileRepository.getProfiles(
        page: 1,
        query: event.query,
        gender: state.genderFilter,
        minAge: state.minAge,
        maxAge: state.maxAge,
      );

      emit(
        state.copyWith(
          status: DiscoveryStatus.success,
          profiles: profiles,
          query: event.query,
          hasMore: profiles.length >= 10,
          searchQuery: event.query,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DiscoveryStatus.failure,
          errorMessage: e.toString(),
          searchQuery: event.query,
        ),
      );
    }
  }

  Future<void> _onFilter(
    DiscoveryFilterProfiles event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DiscoveryStatus.loading,
      ),
    );

    _currentPage = 1;

    try {
      final profiles = await _profileRepository.getProfiles(
        page: 1,
        query: state.query,
        gender: event.gender,
        minAge: event.minAge,
        maxAge: event.maxAge,
      );

      emit(
        state.copyWith(
          status: DiscoveryStatus.success,
          profiles: profiles,
          genderFilter: event.gender,
          minAge: event.minAge,
          maxAge: event.maxAge,
          hasMore: profiles.length >= 10,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DiscoveryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onToggleFavorite(
    DiscoveryToggleFavorite event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      await _profileRepository.toggleFavorite(
        event.profileId,
      );

      final updatedProfiles =
          state.profiles.map((profile) {
        if (profile.id == event.profileId) {
          return profile.copyWith(
            isFavorite: !profile.isFavorite,
          );
        }
        return profile;
      }).toList();

      emit(
        state.copyWith(
          profiles: updatedProfiles,
        ),
      );
    } catch (_) {}
  }

  Future<void> _onRefresh(
    DiscoveryRefresh event,
    Emitter<DiscoveryState> emit,
  ) async {
    add(
      const DiscoveryLoadProfiles(),
    );
  }
}