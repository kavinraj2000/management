part of 'favourite_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesLoadRequested extends FavoritesEvent {
  const FavoritesLoadRequested();
}

class FavoritesRefreshRequested extends FavoritesEvent {
  const FavoritesRefreshRequested();
}

class FavoritesRemoveProfile extends FavoritesEvent {
  final String profileId;

  const FavoritesRemoveProfile(this.profileId);

  @override
  List<Object?> get props => [profileId];
}