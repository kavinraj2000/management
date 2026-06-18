// lib/presentation/widgets/discovery/filter_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profilediscovery/src/core/theme/app_theme.dart';
import 'package:profilediscovery/src/core/bloc/filter/filter_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  final String? currentGender;
  final int? currentMinAge;
  final int? currentMaxAge;
  final Function(String? gender, int? minAge, int? maxAge) onApply;
  final VoidCallback onReset;

  const FilterBottomSheet({
    super.key,
    this.currentGender,
    this.currentMinAge,
    this.currentMaxAge,
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc()
        ..add(FilterInitialized(
          currentGender: currentGender,
          currentMinAge: currentMinAge,
          currentMaxAge: currentMaxAge,
        )),
      child: _FilterBottomSheetContent(
        onApply: onApply,
        onReset: onReset,
      ),
    );
  }
}

class _FilterBottomSheetContent extends StatelessWidget {
  final Function(String? gender, int? minAge, int? maxAge) onApply;
  final VoidCallback onReset;

  const _FilterBottomSheetContent({
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          // Handle
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
            child: Row(
              children: [
                Text(
                  'Filter Profiles',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.read<FilterBloc>().add(const FilterReset());
                    onReset();
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: ListView(
              controller: controller,
              padding: EdgeInsets.all(20.w),
              children: [
                // Gender filter
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 12.h),
                BlocBuilder<FilterBloc, FilterState>(
                  buildWhen: (previous, current) =>
                      previous.selectedGender != current.selectedGender,
                  builder: (context, state) {
                    return Wrap(
                      spacing: 10.w,
                      children: ['All', 'Male', 'Female'].map((gender) {
                        final isSelected = state.selectedGender == null
                            ? gender == 'All'
                            : state.selectedGender == gender;
                        return ChoiceChip(
                          label: Text(gender),
                          selected: isSelected,
                          onSelected: (_) {
                            context.read<FilterBloc>().add(
                                  FilterGenderChanged(
                                    gender == 'All' ? null : gender,
                                  ),
                                );
                          },
                          selectedColor: AppTheme.primaryColor,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : null,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                SizedBox(height: 24.h),

                // Age range
                BlocBuilder<FilterBloc, FilterState>(
                  buildWhen: (previous, current) =>
                      previous.ageRange != current.ageRange,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Age Range',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                '${state.ageRange.start.round()} – ${state.ageRange.end.round()}',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        RangeSlider(
                          values: state.ageRange,
                          min: 18,
                          max: 80,
                          divisions: 62,
                          activeColor: AppTheme.primaryColor,
                          inactiveColor: AppTheme.primaryColor.withOpacity(0.2),
                          onChanged: (values) {
                            context.read<FilterBloc>().add(
                                  FilterAgeRangeChanged(values),
                                );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('18',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppTheme.textSecondary)),
                            Text('80',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppTheme.textSecondary)),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),

          // Apply button
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            child: BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    onApply(
                      state.selectedGender,
                      state.ageRange.start.round(),
                      state.ageRange.end.round(),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}