// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/views/login_view.dart';
import '../widgets/custom_bottom.dart';
import '../widgets/custom_text_field.dart';
import 'cubits/chat_cubit/chat_cubit.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  static String id = '/RegisterView';

  String? email, password;

  String errorMessage = '';

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushReplacementNamed(context, ChatView.id,
              arguments: email);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMassege);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                            'Register',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                        title: 'Register',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .registerUser(
                                    email: email!, password: password!);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginView.id);
                              },
                              child: Text(
                                'Login',
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
        );
      },
    );
  }
}
