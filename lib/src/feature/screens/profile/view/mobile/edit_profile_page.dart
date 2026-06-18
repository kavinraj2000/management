// lib/presentation/pages/profile/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import 'package:tvkapp/src/core/theme/app_theme.dart';
import 'package:tvkapp/src/feature/screens/profile/bloc/profile_bloc.dart';
=======
import 'package:profilediscovery/src/core/theme/app_theme.dart';
import 'package:profilediscovery/src/feature/screens/profile/bloc/profile_bloc.dart';

>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

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
<<<<<<< HEAD
              onPressed: state.status == ProfileStatus.imageUploading
                  ? null
                  : _onSave,
              child: state.status == ProfileStatus.updating
=======
              onPressed: state.status==ProfileStatus.imageUploading ? null : _onSave,
              child: state.status==ProfileStatus.loading
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
<<<<<<< HEAD
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
=======
                          strokeWidth: 2,
                          color: Theme.of(context).appBarTheme.foregroundColor),
                    )
                  : Text('Save',
                      style: TextStyle(
                          color:
                              Theme.of(context).appBarTheme.foregroundColor,
                          fontWeight: FontWeight.w600)),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
<<<<<<< HEAD
          if (state.status == ProfileStatus.updateSuccess) {
=======
          if (state.status==ProfileStatus.updateSuccess) {
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: AppTheme.successColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pop();
<<<<<<< HEAD
          } else if (state.status == ProfileStatus.failure) {
=======
          } else if (state.status==ProfileStatus.failure) {
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
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
<<<<<<< HEAD
          if (state.user == null) {
            return const Center(child: Text('Load profile first'));
          }

          final user = state.status == ProfileStatus.success
              ? state.user
              : null;
=======
          if (state.status==ProfileStatus.success && state.status==ProfileStatus.loading &&
              state.status==ProfileStatus.updateSuccess) {
            return const Center(child: Text('Load profile first'));
          }

          // Get the current user from any loaded state
          final user = state.status==ProfileStatus.success ? state.user : null;
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

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
<<<<<<< HEAD
                        errorText: 'Full name is required',
                      ),
                      FormBuilderValidators.minLength(
                        2,
                        errorText: 'Name too short',
                      ),
=======
                          errorText: 'Full name is required'),
                      FormBuilderValidators.minLength(2,
                          errorText: 'Name too short'),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
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
<<<<<<< HEAD
                    validator: FormBuilderValidators.minLength(
                      10,
                      errorText: 'Enter valid phone',
                      checkNullOrEmpty: false,
                    ),
=======
                    validator: FormBuilderValidators.minLength(10,
                        errorText: 'Enter valid phone',
                        checkNullOrEmpty: false),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
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
<<<<<<< HEAD
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
=======
                          errorText: 'Enter a valid age',
                          checkNullOrEmpty: false),
                      FormBuilderValidators.min(13,
                          errorText: 'Must be at least 13',
                          checkNullOrEmpty: false),
                      FormBuilderValidators.max(120,
                          errorText: 'Invalid age',
                          checkNullOrEmpty: false),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
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
<<<<<<< HEAD
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
=======
                    validator: FormBuilderValidators.maxLength(300,
                        errorText: 'Max 300 characters'),
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: state.status==ProfileStatus.loading ? null : _onSave,
                    child: state.status==ProfileStatus.loading
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
<<<<<<< HEAD
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
=======
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
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
<<<<<<< HEAD
        fontWeight: FontWeight.w700,
        color: AppTheme.primaryColor,
      ),
=======
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
          ),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    );
  }

  void _onSave() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
<<<<<<< HEAD

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
=======
 context.read<ProfileBloc>().add(
  ProfileUpdateRequested(
    fullName: values['full_name'],
    phone: values['phone'],
    age: int.tryParse(values['age'] ?? '')!,
    occupation: values['occupation'],
    location: values['location'],
    aboutMe: values['about_me'],
  ),
);
    //  data));
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    }
  }
}
