// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/views/cubits/chat_cubit/chat_cubit.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_bottom.dart';
import '../widgets/custom_text_field.dart';
import 'chat_view.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  static String id = '/LoginView';

  String? email, password, errorMassege = '';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading=false;
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushReplacementNamed(context, ChatView.id, arguments: email);
        } else if (state is LoginFailure) {
          isLoading=false;
          showSnackBar(context, state.errorMassege);
        }
      },
      builder:(context,state)=> ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kMainColor,
          body: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 100,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(kLogo),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      title: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      title: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomBotton(
                        title: 'Login',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .loginUser(email: email!, password: password!);
                          }
                        }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account? ',
                          style: TextStyle(color: Colors.white70),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, RegisterView.id);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.50)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
