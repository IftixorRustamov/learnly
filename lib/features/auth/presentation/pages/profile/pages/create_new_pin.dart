import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:kursol/core/routes/route_paths.dart';
import 'package:kursol/features/auth/domain/entities/otp_response_user_entity.dart';
import 'package:kursol/features/auth/presentation/bloc/otp_verify/otp_verify_bloc.dart';

import '../../../../../../core/common/constants/constants_export.dart';
import '../../../../../../core/common/textstyles/urbanist_textstyles.dart';
import '../../../../../../core/common/widgets/widgets_export.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../../../core/utils/responsiveness/app_responsive.dart';

class CreateNewPin extends StatefulWidget {
  const CreateNewPin({super.key});

  @override
  State<CreateNewPin> createState() => _CreateNewPinState();
}

class _CreateNewPinState extends State<CreateNewPin> {
  OtpResponseUserEntity? user;
  String? _otpCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (user == null) {
      final extra = GoRouterState.of(context).extra;
      if (extra == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: No userId provided")),
        );
        context.go(RoutePaths.signup);
        return;
      }
      if (extra is! String) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Error: Expected String, got ${extra.runtimeType}")),
        );
        context.go(RoutePaths.signup);
        return;
      }
      user = OtpResponseUserEntity(userId: extra);
    }
  }

  void _verifyOtp(BuildContext context) {
    if (_otpCode == null || _otpCode!.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter the 6-digit OTP code")),
      );
      return;
    }

    context.read<OtpVerifyBloc>().add(
          OtpVerifyRequested(
            otpCode: _otpCode!,
            userId: user!.userId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpVerifyBloc>(
      create: (_) => sl<OtpVerifyBloc>(),
      child: Builder(
          builder: (context) => Scaffold(
                backgroundColor: AppColors.white,
                appBar: ActionAppBarWg(
                  onBackPressed: () {
                    context.go(RoutePaths.signup);
                  },
                  titleText: AppStrings.createNewPin,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: appW(24)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: appH(80),
                      children: [
                        Text(
                          AppStrings.addPinNumber,
                          textAlign: TextAlign.center,
                          style: sl<UrbanistTextStyles>().regular(
                              color: AppColors.greyScale.grey900, fontSize: 18),
                        ),
                        OtpTextField(
                          onSubmit: (String code) {
                            setState(() {
                              _otpCode = code;
                            });
                          },
                          numberOfFields: 6,
                          obscureText: false,
                          showFieldAsBox: true,
                        ),
                        BlocConsumer<OtpVerifyBloc, OtpVerifyState>(
                            builder: (context, state) {
                          if (state is OtpVerifyLoading) {
                            return const CircularProgressIndicator();
                          }
                          return DefaultButtonWg(
                              title: AppStrings.profileContinue,
                              onPressed: () => _verifyOtp(context));
                        }, listener: (context, state) {
                          if (state is OtpVerifySuccess) {
                            context.go(RoutePaths.home);
                          } else if (state is OtpVerifyFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
