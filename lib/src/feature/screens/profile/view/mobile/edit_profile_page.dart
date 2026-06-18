// lib/presentation/pages/profile/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tvkapp/src/core/theme/app_theme.dart';
import 'package:tvkapp/src/feature/screens/profile/bloc/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) => TextButton(
              onPressed: state.status == ProfileStatus.imageUploading
                  ? null
                  : _onSave,
              child: state.status == ProfileStatus.updating
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                    )
                  : Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).appBarTheme.foregroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.updateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: AppTheme.successColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pop();
          } else if (state.status == ProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppTheme.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
            // Reload profile
            context.read<ProfileBloc>().add(const ProfileLoadRequested());
          }
        },
        builder: (context, state) {
          if (state.user == null) {
            return const Center(child: Text('Load profile first'));
          }

          final user = state.status == ProfileStatus.success
              ? state.user
              : null;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: FormBuilder(
              key: _formKey,
              initialValue: user != null
                  ? {
                      'full_name': user.fullName,
                      'phone': user.phone ?? '',
                      'age': user.age?.toString() ?? '',
                      'occupation': user.occupation ?? '',
                      'location': user.location ?? '',
                      'about_me': user.aboutMe ?? '',
                    }
                  : {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(context, 'Basic Information'),
                  SizedBox(height: 12.h),
                  FormBuilderTextField(
                    name: 'full_name',
                    decoration: const InputDecoration(
                      labelText: 'Full Name *',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Full name is required',
                      ),
                      FormBuilderValidators.minLength(
                        2,
                        errorText: 'Name too short',
                      ),
                    ]),
                  ),
                  SizedBox(height: 16.h),
                  FormBuilderTextField(
                    name: 'phone',
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: FormBuilderValidators.minLength(
                      10,
                      errorText: 'Enter valid phone',
                      checkNullOrEmpty: false,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  FormBuilderTextField(
                    name: 'age',
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      prefixIcon: Icon(Icons.cake_outlined),
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.integer(
                        errorText: 'Enter a valid age',
                        checkNullOrEmpty: false,
                      ),
                      FormBuilderValidators.min(
                        13,
                        errorText: 'Must be at least 13',
                        checkNullOrEmpty: false,
                      ),
                      FormBuilderValidators.max(
                        120,
                        errorText: 'Invalid age',
                        checkNullOrEmpty: false,
                      ),
                    ]),
                  ),
                  SizedBox(height: 24.h),
                  _sectionLabel(context, 'Professional'),
                  SizedBox(height: 12.h),
                  FormBuilderTextField(
                    name: 'occupation',
                    decoration: const InputDecoration(
                      labelText: 'Occupation',
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: 16.h),
                  FormBuilderTextField(
                    name: 'location',
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: 24.h),
                  _sectionLabel(context, 'About'),
                  SizedBox(height: 12.h),
                  FormBuilderTextField(
                    name: 'about_me',
                    decoration: InputDecoration(
                      labelText: 'About Me',
                      alignLabelWithHint: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Icon(Icons.info_outline),
                      ),
                    ),
                    maxLines: 4,
                    maxLength: 300,
                    validator: FormBuilderValidators.maxLength(
                      300,
                      errorText: 'Max 300 characters',
                    ),
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: state.status == ProfileStatus.loading
                        ? null
                        : _onSave,
                    child: state.status == ProfileStatus.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Save Changes'),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTheme.primaryColor,
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      context.read<ProfileBloc>().add(
        ProfileUpdateRequested(
          fullName: values['full_name']?.toString().trim() ?? '',
          age: int.tryParse(values['age']?.toString() ?? '') ?? 0,
          phone: values['phone']?.toString().trim() ?? '',
          occupation: values['occupation']?.toString().trim() ?? '',
          location: values['location']?.toString().trim() ?? '',
          aboutMe: values['about_me']?.toString().trim() ?? '',
        ),
      );
    }
  }
}
