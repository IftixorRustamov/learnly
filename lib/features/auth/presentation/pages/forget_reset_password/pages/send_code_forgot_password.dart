import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:kursol/core/routes/route_paths.dart';
import 'package:kursol/features/auth/presentation/bloc/reset_password_otp/reset_password_otp_bloc.dart';
import 'package:kursol/features/auth/presentation/bloc/reset_password_otp/reset_password_otp_event.dart';
import 'package:kursol/features/auth/presentation/bloc/reset_password_otp/reset_password_otp_state.dart';

import '../../../../../../core/common/constants/constants_export.dart';
import '../../../../../../core/common/textstyles/urbanist_textstyles.dart';
import '../../../../../../core/common/widgets/widgets_export.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../../../core/utils/responsiveness/app_responsive.dart';

class SendCodeForgotPassword extends StatefulWidget {
  const SendCodeForgotPassword({super.key});

  @override
  State<SendCodeForgotPassword> createState() => _SendCodeForgotPasswordState();
}

class _SendCodeForgotPasswordState extends State<SendCodeForgotPassword> {
  String? userId;
  String? otp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      if (extra is String && extra.isNotEmpty) {
        setState(() {
          userId = extra;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: User ID is missing'),
            backgroundColor: AppColors.red,
          ),
        );
        context.go(RoutePaths.forgotPassword);
      }
    });
  }

  void _verifyOtp(BuildContext context) {
    context
        .read<ResetPasswordOtpBloc>()
        .add(ResetPasswordOtpRequested(userId: userId!, otp: otp!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordOtpBloc>(
      create: (_) => sl<ResetPasswordOtpBloc>(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.white,
          appBar: ActionAppBarWg(
            onBackPressed: () {
              context.go(RoutePaths.forgotPassword);
            },
            titleText: AppStrings.forgotPassword,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: appH(80),
              children: [
                Text(
                  'Code has been send to +1 111 ******99',
                  textAlign: TextAlign.center,
                  style: sl<UrbanistTextStyles>().regular(
                      color: AppColors.greyScale.grey900, fontSize: 18),
                ),
                OtpTextField(
                  onSubmit: (String code) {
                    setState(() {
                      otp = code;
                    });
                  },
                  numberOfFields: 6,
                  obscureText: false,
                  showFieldAsBox: true,
                ),
                Text(
                  'Resend code in 55 s',
                  textAlign: TextAlign.center,
                  style: sl<UrbanistTextStyles>().regular(
                      color: AppColors.greyScale.grey900, fontSize: 18),
                ),
                BlocConsumer<ResetPasswordOtpBloc, ResetPasswordOtpState>(
                  builder: (context, state) {
                    if (state is ResetPasswordOtpLoading) {
                      return CircularProgressIndicator();
                    }
                    return DefaultButtonWg(
                        title: 'Verify', onPressed: () => _verifyOtp(context));
                  },
                  listener: (context, state) {
                    if (state is ResetPasswordOtpSuccess) {
                      context.go(RoutePaths.createNewPassword);
                    } else if (state is ResetPasswordOtpFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
