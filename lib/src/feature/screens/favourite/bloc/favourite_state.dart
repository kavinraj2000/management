part of 'favourite_bloc.dart';

enum FavoritesStatus {
  initial,
  loading,
  success,
  failure,
  refreshing,
  loadingMore,
}

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<ProfileEntity> profiles;
  final String? errorMessage;
  final bool hasReachedMax;
  final int page;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.profiles = const [],
    this.errorMessage,
    this.hasReachedMax = false,
    this.page = 1,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<ProfileEntity>? profiles,
    String? errorMessage,
    bool? hasReachedMax,
    int? page,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      profiles: profiles ?? this.profiles,
      errorMessage: errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profiles,
        errorMessage,
        hasReachedMax,
        page,
      ];
}