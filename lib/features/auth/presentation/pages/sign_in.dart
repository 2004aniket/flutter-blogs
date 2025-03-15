// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog/core/color_pallete.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/sign_up.dart';
import 'package:blog/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/loader.dart';
import '../../../../core/common/showsnackbar.dart';
import '../widgets/auth_field.dart';

class SignIn extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignIn());

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showshackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In.",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthField(
                    HintText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthField(
                    HintText: "Password",
                    controller: passwordController,
                    isobscuretext: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButton(
                    buttonText: "Sign In",
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignIn(
                            emailController.text.trim(),
                            passwordController.text.trim()));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(text: TextSpan(text: "Don't have a account? ")),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, SignUp.route());
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Sign up",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: color_pallete.gradient1)),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
