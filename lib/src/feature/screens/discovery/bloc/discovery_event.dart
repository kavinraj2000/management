part of 'dicovery_bloc.dart';

abstract class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();

  @override
  List<Object?> get props => [];
}

class DiscoveryLoadProfiles extends DiscoveryEvent {
  const DiscoveryLoadProfiles();
}

class DiscoveryLoadMore extends DiscoveryEvent {
  const DiscoveryLoadMore();
}

class DiscoverySearchProfiles extends DiscoveryEvent {
  final String query;

  const DiscoverySearchProfiles(this.query);

  @override
  List<Object?> get props => [query];
}

class DiscoveryFilterProfiles extends DiscoveryEvent {
  final String? gender;
  final int? minAge;
  final int? maxAge;

  const DiscoveryFilterProfiles({this.gender, this.minAge, this.maxAge});

  @override
  List<Object?> get props => [gender, minAge, maxAge];
}

class DiscoveryToggleFavorite extends DiscoveryEvent {
  final String profileId;

  const DiscoveryToggleFavorite(this.profileId);

  @override
  List<Object?> get props => [profileId];
}

class DiscoveryRefresh extends DiscoveryEvent {
  const DiscoveryRefresh();
}