import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:kursol/features/auth/presentation/bloc/reset_password_phone/reset_password_phone_bloc.dart';

import '../../../../../../core/common/constants/constants_export.dart';
import '../../../../../../core/common/textstyles/urbanist_textstyles.dart';
import '../../../../../../core/common/widgets/widgets_export.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../../../core/routes/route_paths.dart';
import '../../../../../../core/utils/responsiveness/app_responsive.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isFocusedPhone = false;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      setState(() {
        _isFocusedPhone = _phoneFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _resetPassword(BuildContext context) {
    final phone = _phoneController.text.trim();
    context
        .read<ResetPasswordPhoneBloc>()
        .add(ResetPasswordSubmitted(phone: phone));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ResetPasswordPhoneBloc>(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.white,
          appBar: ActionAppBarWg(
            onBackPressed: () {
              context.go(RoutePaths.signin);
            },
            titleText: AppStrings.forgotPassword,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 33),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: appH(24),
                children: [
                  Image.asset(
                    "assets/images/forgot_password.png",
                    height: appH(250),
                    width: appW(276),
                  ),
                  Text(
                    AppStrings.selectWhichContact,
                    textAlign: TextAlign.left,
                    style: sl<UrbanistTextStyles>().medium(
                        color: AppColors.greyScale.grey900, fontSize: 18),
                  ),
                  CustomTextFieldWg(
                      isFocused: _isFocusedPhone,
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      prefixIcon: IconlyBold.call,
                      hintText: AppStrings.phoneNumber,
                      onTap: () {
                        setState(() {
                          _isFocusedPhone = true;
                        });
                      }),
                  BlocConsumer<ResetPasswordPhoneBloc, ResetPasswordPhoneState>(
                    builder: (context, state) {
                      if (state is ResetPasswordPhoneLoading) {
                        return CircularProgressIndicator();
                      }
                      return DefaultButtonWg(
                          title: AppStrings.profileContinue,
                          onPressed: () => _resetPassword(context));
                    },
                    listener: (context, state) {
                      if (state is ResetPasswordPhoneSuccess) {
                        print(
                            'Navigating with userId: ${state.userEntity?.id}');
                        context.go(
                          RoutePaths.sendCodeForgotPassword,
                          extra: state.userEntity?.id,
                        );
                      } else if (state is ResetPasswordPhoneFailure) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
