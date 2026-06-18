import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(const FilterState()) {
    on<FilterInitialized>(_onInitialized);
    on<FilterGenderChanged>(_onGenderChanged);
    on<FilterAgeRangeChanged>(_onAgeRangeChanged);
    on<FilterReset>(_onReset);
  }

  Future<void> _onInitialized(
    FilterInitialized event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      FilterState(
        selectedGender: event.currentGender,
        ageRange: RangeValues(
          (event.currentMinAge ?? 18).toDouble(),
          (event.currentMaxAge ?? 60).toDouble(),
        ),
      ),
    );
  }

  Future<void> _onGenderChanged(
    FilterGenderChanged event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedGender: event.gender,
      ),
    );
  }

  Future<void> _onAgeRangeChanged(
    FilterAgeRangeChanged event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        ageRange: event.ageRange,
      ),
    );
  }

  Future<void> _onReset(
    FilterReset event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedGender: null,
        ageRange: const RangeValues(18, 60),
      ),
    );
  }
}
