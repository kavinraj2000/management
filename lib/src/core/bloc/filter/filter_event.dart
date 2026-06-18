part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class FilterInitialized extends FilterEvent {
  final String? currentGender;
  final int? currentMinAge;
  final int? currentMaxAge;

  const FilterInitialized({
    this.currentGender,
    this.currentMinAge,
    this.currentMaxAge,
  });

  @override
  List<Object?> get props => [currentGender, currentMinAge, currentMaxAge];
}

class FilterGenderChanged extends FilterEvent {
  final String? gender;

  const FilterGenderChanged(this.gender);

  @override
  List<Object?> get props => [gender];
}

class FilterAgeRangeChanged extends FilterEvent {
  final RangeValues ageRange;

  const FilterAgeRangeChanged(this.ageRange);

  @override
  List<Object?> get props => [ageRange];
}

class FilterReset extends FilterEvent {
  const FilterReset();
}
