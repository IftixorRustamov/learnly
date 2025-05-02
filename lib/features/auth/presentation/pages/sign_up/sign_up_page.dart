import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:kursol/core/common/constants/constants_export.dart';
import 'package:kursol/core/common/sizes/sizes.dart';
import 'package:kursol/core/common/textstyles/urbanist_textstyles.dart';
import 'package:kursol/core/common/widgets/widgets_export.dart';
import 'package:kursol/core/di/service_locator.dart';
import 'package:kursol/core/routes/route_paths.dart';
import 'package:kursol/core/utils/responsiveness/app_responsive.dart';
import 'package:kursol/features/auth/presentation/widgets/auth_checkbox_wg.dart';
import 'package:kursol/features/auth/presentation/widgets/auth_or_continue_with_wg.dart';
import 'package:kursol/features/auth/presentation/widgets/auth_sign_in_up_choice_wg.dart';

import '../../bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailOrPhoneFocusNode = FocusNode();
  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() => setState(() {}));
    _emailOrPhoneFocusNode.addListener(() => setState(() {}));
    _firstNameFocusNode.addListener(() => setState(() {}));
    _lastNameFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    context.read<SignupBloc>().close();
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    _emailOrPhoneFocusNode.dispose();
    _emailOrPhoneController.dispose();
    _lastNameFocusNode.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  String? _validateForm() {
    if (_firstNameController.text.trim().isEmpty) {
      return 'First name is required';
    }
    if (_lastNameController.text.trim().isEmpty) {
      return 'Last name is required';
    }
    if (_emailOrPhoneController.text.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (_passwordController.text.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _submitSignup(BuildContext context) {
    final errorMessage = _validateForm();

    if (errorMessage == null) {
      context.read<SignupBloc>().add(SignupSubmitted(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            phoneNumber: _emailOrPhoneController.text.trim(),
            password: _passwordController.text.trim(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ActionAppBarWg(onBackPressed: () {
        context.go(RoutePaths.auth);
      }),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: scaffoldPadding24,
          child: Column(
            spacing: appH(20),
            children: [
              Text(
                AppStrings.createYourAccount,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: sl<UrbanistTextStyles>().bold(
                  color: AppColors.greyScale.grey900,
                  fontSize: 48,
                ),
              ),
              Column(
                spacing: appH(16),
                children: [
                  CustomTextFieldWg(
                    isFocused: _firstNameFocusNode.hasFocus,
                    controller: _firstNameController,
                    focusNode: _firstNameFocusNode,
                    prefixIcon: IconlyBold.profile,
                    hintText: AppStrings.firstName,
                  ),
                  CustomTextFieldWg(
                    isFocused: _lastNameFocusNode.hasFocus,
                    controller: _lastNameController,
                    focusNode: _lastNameFocusNode,
                    prefixIcon: IconlyBold.profile,
                    hintText: AppStrings.lastName,
                  ),
                  CustomTextFieldWg(
                    isFocused: _emailOrPhoneFocusNode.hasFocus,
                    controller: _emailOrPhoneController,
                    focusNode: _emailOrPhoneFocusNode,
                    prefixIcon: IconlyBold.call,
                    hintText: AppStrings.phoneNumber,
                  ),
                  CustomTextFieldWg(
                    isFocused: _passwordFocusNode.hasFocus,
                    obscureText: _obscureText,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    prefixIcon: IconlyBold.lock,
                    hintText: AppStrings.password,
                    trailingWidget: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? IconlyBold.hide : IconlyBold.show,
                        size: appH(20),
                        color: _passwordFocusNode.hasFocus
                            ? AppColors.primary()
                            : AppColors.greyScale.grey500,
                      ),
                    ),
                  ),
                  AuthCheckboxWg(
                    rememberMe: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  BlocConsumer<SignupBloc, SignupState>(
                      listener: (context, state) {
                    if (state is SignupSuccess) {
                      context.go(RoutePaths.createNewPin, extra: state.user.id);
                    } else if (state is SignupFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    }
                  }, builder: (context, state) {
                    if (state is SignupLoading) {
                      return CircularProgressIndicator();
                    }
                    return DefaultButtonWg(
                      title: AppStrings.signUp,
                      onPressed: () => _submitSignup(context),
                    );
                  }),
                ],
              ),
              AuthOrContinueWithWg(
                onTapFacebook: () {},
                onTapGoogle: () {},
                onTapApple: () {},
              ),
              AuthSignInUpChoiceWg(
                text: AppStrings.alreadyHaveAccount,
                onPressed: () {
                  context.go(RoutePaths.signin);
                },
                buttonText: AppStrings.signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
