import 'dart:developer';
import 'package:book_app/presentation/elements/processing_widget.dart';
import 'package:book_app/presentation/views/books/get_books.dart';
import 'package:string_validator/string_validator.dart';
import 'package:book_app/application/auth_bloc/auth_bloc.dart';
import 'package:book_app/presentation/elements/app_button.dart';
import 'package:book_app/presentation/elements/auth_field.dart';
import 'package:book_app/presentation/elements/custom_text.dart';
import 'package:book_app/presentation/elements/flush_bar.dart';
import 'package:book_app/presentation/views/auth/forgot_pwd.dart';
import 'package:book_app/presentation/views/auth/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../injection_container.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f8fa),
      body: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoggedIn) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetBooksView()));
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
                            text: "Welcome Back!",
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
                                      "Enter your information and Login to your account",
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
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Password",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: pwdController,
                                  text: 'Password',
                                  onTap: () {},
                                  keyBoardType: TextInputType.emailAddress,
                                  icon: 'assets/images/lock.svg',
                                  isPasswordField: true,
                                  isSecure: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordView()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CustomText(
                                        text: "Forgot Password?",
                                        fontSize: 15,
                                        color: Colors.red.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
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
                              if (pwdController.text.isEmpty) {
                                getFlushBar(context,
                                    title: "Password cannot be empty.");
                                return;
                              }
                              BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                                  email: emailController.text,
                                  pwd: pwdController.text));
                            },
                            btnLabel: 'Login'),
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: 'Dont have an account? ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'SignUp',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterView()));
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
