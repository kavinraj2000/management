// lib/presentation/pages/auth/forgot_password_page.dart

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

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgotPasswordContent();
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  const _ForgotPasswordContent();

  @override
  State<_ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status==AuthStatus.forgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset link sent to your email'),
                backgroundColor: AppTheme.successColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.status==AuthStatus.failure) {
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
          final isEmailSent = state.status == AuthStatus.forgotPasswordSuccess;
          
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: isEmailSent ? _buildSuccess(context) : _buildForm(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.lock_reset_rounded,
<<<<<<< HEAD
            size: 32,
=======
            size: 32.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
            color: AppTheme.primaryColor,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Forgot Password?',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter your registered email and we\'ll send you a reset link.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.textSecondary),
        ),
        SizedBox(height: 40.h),
        FormBuilder(
          key: _formKey,
          child: FormBuilderTextField(
            name: 'email',
            decoration: const InputDecoration(
              labelText: 'Email Address',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Email is required'),
              FormBuilderValidators.email(errorText: 'Enter a valid email'),
            ]),
          ),
        ),
        SizedBox(height: 32.h),
        ElevatedButton(
          onPressed: state.status==AuthStatus.loading
              ? null
              : () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final email =
                        _formKey.currentState!.value['email'] as String;
                    context.read<AuthBloc>().add(
                          AuthForgotPasswordRequested(email: email),
                        );
                  }
                },
          child: state.status==AuthStatus.loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : const Text('Send Reset Link'),
        ),
      ],
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.mark_email_read_rounded,
<<<<<<< HEAD
          size: 80,
=======
          size: 80.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
          color: AppTheme.successColor,
        ),
        SizedBox(height: 24.h),
        Text(
          'Email Sent!',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'We\'ve sent a password reset link to your email. Please check your inbox.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.textSecondary),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.h),
        ElevatedButton(
          onPressed: () => context.go('/auth/login'),
          child: const Text('Back to Sign In'),
        ),
      ],
    );
  }
}