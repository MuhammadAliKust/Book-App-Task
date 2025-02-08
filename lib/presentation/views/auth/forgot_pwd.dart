import 'dart:developer';

import 'package:book_app/application/auth_bloc/auth_bloc.dart';
import 'package:book_app/presentation/elements/app_button.dart';
import 'package:book_app/presentation/elements/navigation_dialog.dart';
import 'package:book_app/presentation/views/auth/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../injection_container.dart';
import '../../elements/auth_field.dart';
import '../../elements/custom_text.dart';
import '../../elements/flush_bar.dart';
import '../../elements/processing_widget.dart';
import 'package:string_validator/string_validator.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f8fa),
      body: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ResetPwdEmailSent) {
              showNavigationDialog(context,
                  message:
                      "An email with password reset email has been sent to your mail box. ",
                  buttonText: "Okay", navigation: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }, secondButtonText: "secondButtonText", showSecondButton: false);
            } else if (state is AuthFailed) {
              getFlushBar(context, title: state.message.toString());
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return LoadingOverlay(
                isLoading: state is AuthLoading,
                progressIndicator: const ProcessingWidget(),
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        CustomText(
                            text: "Reset Password!",
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:
                                      "Enter your email to get password reset link.",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Email",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: emailController,
                                  text: 'Email',
                                  onTap: () {},
                                  keyBoardType: TextInputType.emailAddress,
                                  icon: 'assets/images/email.svg',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppButton(
                            onPressed: () {
                              if (emailController.text.isEmpty) {
                                getFlushBar(context,
                                    title: "Email cannot be empty.");
                                return;
                              }
                              if (!emailController.text.isEmail) {
                                getFlushBar(context,
                                    title: "Kindly enter valid email.");
                                return;
                              }
                              BlocProvider.of<AuthBloc>(context)
                                  .add(ForgotPasswordEvent(
                                email: emailController.text,
                              ));
                            },
                            btnLabel: 'Reset Password'),
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: 'Remember Password? ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView()));
                                      },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
