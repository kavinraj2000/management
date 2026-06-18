part of 'dicovery_bloc.dart';

enum DiscoveryStatus {
  initial,
  loading,
  success,
  loadingMore,
  failure,
}

class DiscoveryState extends Equatable {
  final DiscoveryStatus status;
  final List<ProfileEntity> profiles;

  final bool hasMore;
  final String? errorMessage;

  final String? query;
  final String? genderFilter;
  final int? minAge;
  final int? maxAge;
  final String searchQuery;

  const DiscoveryState({
    this.status = DiscoveryStatus.initial,
    this.profiles = const [],
    this.hasMore = true,
    this.errorMessage,
    this.query,
    this.genderFilter,
    this.minAge,
    this.maxAge,
    this.searchQuery = '',
  });

  DiscoveryState copyWith({
    DiscoveryStatus? status,
    List<ProfileEntity>? profiles,
    bool? hasMore,
    String? errorMessage,
    String? query,
    String? genderFilter,
    int? minAge,
    int? maxAge,
    String? searchQuery,
  }) {
    return DiscoveryState(
      status: status ?? this.status,
      profiles: profiles ?? this.profiles,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      query: query ?? this.query,
      genderFilter: genderFilter ?? this.genderFilter,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profiles,
        hasMore,
        errorMessage,
        query,
        genderFilter,
        minAge,
        maxAge,
        searchQuery,
      ];
}