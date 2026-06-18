// lib/presentation/pages/auth/register_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:tvkapp/src/feature/auth/bloc/auth_bloc.dart';
=======
import 'package:profilediscovery/src/feature/auth/bloc/auth_bloc.dart';
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
import '../../../core/theme/app_theme.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterContent();
  }
}

class _RegisterContent extends StatefulWidget {
  const _RegisterContent();

  @override
  State<_RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<_RegisterContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onRegister() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      if (values['password'] != values['confirm_password']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      context.read<AuthBloc>().add(
<<<<<<< HEAD
        AuthRegisterRequested(
          fullName: values['full_name'] as String,
          email: values['email'] as String,
          password: values['password'] as String,
          phone: values['phone'] as String?,
        ),
      );
=======
            AuthRegisterRequested(
              fullName: values['full_name'] as String,
              email: values['email'] as String,
              password: values['password'] as String,
              phone: values['phone'] as String?,
            ),
          );
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
<<<<<<< HEAD
          if (state.status == AuthStatus.registrationSuccess ||
              state.status == AuthStatus.authenticated) {
            context.go('/discovery');
          } else if (state.status == AuthStatus.failure) {
=======
          if (state.status==AuthStatus.registrationSuccess || state.status==AuthStatus.authenticated) {
            context.go('/discovery');
          } else if (state.status==AuthStatus.failure) {
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                backgroundColor: AppTheme.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    'Join ProfileHub',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
<<<<<<< HEAD
                      fontWeight: FontWeight.w700,
                    ),
=======
                          fontWeight: FontWeight.w700,
                        ),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Fill in your details to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
<<<<<<< HEAD
                      color: AppTheme.textSecondary,
                    ),
=======
                          color: AppTheme.textSecondary,
                        ),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                  ),
                  SizedBox(height: 32.h),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'full_name',
                          decoration: const InputDecoration(
                            labelText: 'Full Name *',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
<<<<<<< HEAD
                              errorText: 'Full name is required',
                            ),
                            FormBuilderValidators.minLength(
                              2,
                              errorText: 'Name is too short',
                            ),
=======
                                errorText: 'Full name is required'),
                            FormBuilderValidators.minLength(2,
                                errorText: 'Name is too short'),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                          ]),
                        ),
                        SizedBox(height: 16.h),
                        FormBuilderTextField(
                          name: 'email',
                          decoration: const InputDecoration(
                            labelText: 'Email Address *',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
<<<<<<< HEAD
                              errorText: 'Email is required',
                            ),
                            FormBuilderValidators.email(
                              errorText: 'Enter a valid email',
                            ),
=======
                                errorText: 'Email is required'),
                            FormBuilderValidators.email(
                                errorText: 'Enter a valid email'),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                          ]),
                        ),
                        SizedBox(height: 16.h),
                        FormBuilderTextField(
                          name: 'phone',
                          decoration: const InputDecoration(
                            labelText: 'Phone Number (Optional)',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose([
<<<<<<< HEAD
                            FormBuilderValidators.minLength(
                              10,
                              errorText: 'Enter a valid phone number',
                              checkNullOrEmpty: false,
                            ),
=======
                            FormBuilderValidators.minLength(10,
                                errorText: 'Enter a valid phone number',
                                checkNullOrEmpty: false),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                          ]),
                        ),
                        SizedBox(height: 16.h),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              previous.isPasswordVisible !=
                              current.isPasswordVisible,
                          builder: (context, authState) {
                            return FormBuilderTextField(
                              name: 'password',
                              decoration: InputDecoration(
                                labelText: 'Password *',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
<<<<<<< HEAD
                                  icon: Icon(
                                    authState.isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () => context.read<AuthBloc>().add(
                                    const AuthTogglePasswordVisibility(),
                                  ),
=======
                                  icon: Icon(authState.isPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: () => context
                                      .read<AuthBloc>()
                                      .add(
                                          const AuthTogglePasswordVisibility()),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                                ),
                              ),
                              obscureText: !authState.isPasswordVisible,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
<<<<<<< HEAD
                                  errorText: 'Password is required',
                                ),
                                FormBuilderValidators.minLength(
                                  6,
                                  errorText:
                                      'Password must be at least 6 characters',
                                ),
=======
                                    errorText: 'Password is required'),
                                FormBuilderValidators.minLength(6,
                                    errorText:
                                        'Password must be at least 6 characters'),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                              ]),
                            );
                          },
                        ),
                        SizedBox(height: 16.h),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              previous.isConfirmPasswordVisible !=
                              current.isConfirmPasswordVisible,
                          builder: (context, authState) {
                            return FormBuilderTextField(
                              name: 'confirm_password',
                              decoration: InputDecoration(
                                labelText: 'Confirm Password *',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
<<<<<<< HEAD
                                  icon: Icon(
                                    authState.isConfirmPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () => context.read<AuthBloc>().add(
                                    const AuthToggleConfirmPasswordVisibility(),
                                  ),
                                ),
                              ),
                              obscureText: !authState.isConfirmPasswordVisible,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _onRegister(),
                              validator: FormBuilderValidators.required(
                                errorText: 'Please confirm your password',
                              ),
=======
                                  icon: Icon(authState.isConfirmPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: () => context
                                      .read<AuthBloc>()
                                      .add(const AuthToggleConfirmPasswordVisibility()),
                                ),
                              ),
                              obscureText:
                                  !authState.isConfirmPasswordVisible,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _onRegister(),
                              validator: FormBuilderValidators.required(
                                  errorText:
                                      'Please confirm your password'),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
<<<<<<< HEAD
                    onPressed: state.status == AuthStatus.loading
                        ? null
                        : _onRegister,
                    child: state.status == AuthStatus.loading
=======
                    onPressed: state.status==AuthStatus.loading ? null : _onRegister,
                    child: state.status==AuthStatus.loading
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
                        : const Text('Create Account'),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Already have an account? Sign In'),
                    ),
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
<<<<<<< HEAD
}
=======
}
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
