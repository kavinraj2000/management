import 'package:flutter/material.dart';

part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final String? selectedGender;
  final RangeValues ageRange;

  const FilterState({
    this.selectedGender,
    this.ageRange = const RangeValues(18, 60),
  });

  FilterState copyWith({
    String? selectedGender,
    RangeValues? ageRange,
  }) {
    return FilterState(
      selectedGender: selectedGender ?? this.selectedGender,
      ageRange: ageRange ?? this.ageRange,
    );
  }

  @override
  List<Object?> get props => [
        selectedGender,
        ageRange,
      ];
}
