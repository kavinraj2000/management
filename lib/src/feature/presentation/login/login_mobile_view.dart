// lib/presentation/pages/auth/login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profilediscovery/src/core/constants/constants.dart';
import 'package:profilediscovery/src/feature/auth/bloc/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginContent();
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent();

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onLogin() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: values['email'] as String,
          password: values['password'] as String,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
           
      
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                context.go('/discovery');
              } else if (state.status == AuthStatus.registrationSuccess) {
                context.go('/discovery');
              } else if (state.status == AuthStatus.failure) {
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
                      SizedBox(height: 60.h),
        
                      // Center(
                      //   child: Container(
                      //     width: 72.w,
                      //     height: 72.w,
                      //     decoration: BoxDecoration(
                      //       color: AppTheme.primaryColor,
                      //       borderRadius: BorderRadius.circular(18.r),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: AppTheme.primaryColor.withOpacity(0.3),
                      //           blurRadius: 16,
                      //           offset: const Offset(0, 6),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Icon(
                      //       Icons.people_alt_rounded,
                      //       size: 40,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 32.h),
        
                      Center(
                        child: Text(
                          'Profile Discovery',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Text(
                      //   '',
                      //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      //     color: AppTheme.textSecondary,
                      //   ),
                      // ),
                      SizedBox(height: 40.h),
        
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'email',
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Email is required',
                                ),
                                FormBuilderValidators.email(
                                  errorText: 'Enter a valid email',
                                ),
                              ]),
                            ),
                            SizedBox(height: 16.h),
                            BlocBuilder<AuthBloc, AuthState>(
                              buildWhen: (previous, current) =>
                                  previous.isPasswordVisible !=
                                  current.isPasswordVisible,
                              builder: (context, state) {
                                return FormBuilderTextField(
                                  name: 'password',
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        state.isPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
                                            const AuthTogglePasswordVisibility(),
                                          ),
                                    ),
                                  ),
                                  obscureText: !state.isPasswordVisible,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => _onLogin(),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: 'Password is required',
                                    ),
                                    FormBuilderValidators.minLength(
                                      6,
                                      errorText:
                                          'Password must be at least 6 characters',
                                    ),
                                  ]),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
        
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/auth/forgot-password'),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      SizedBox(height: 24.h),
        
                      ElevatedButton(
                        onPressed: state.status == AuthStatus.loading
                            ? null
                            : _onLogin,
                        child: state.status == AuthStatus.loading
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
                            : const Text('Sign In'),
                      ),
                      SizedBox(height: 24.h),
        
                      // Divider
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 24.h),
        
                      OutlinedButton(
                        onPressed: () => context.push('/auth/register'),
                        child: const Text('Create New Account'),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
