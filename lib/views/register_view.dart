import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/auth_cubit/auth_state.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/password_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is RegisterLoading) {
          isLoading = true;
        }else if(state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatView.id, arguments: email);
          isLoading = false;
        }else if(state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 175.0,
                    ),
                    Image.asset(
                      kLogo,
                      height: 120.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Enter Your Email',
                      labelText: 'Email',
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    PasswordTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {} else {}
                        BlocProvider.of<AuthCubit>(context).registerUser(email: email!, password: password!);
                      },
                      text: 'Sign Up',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    log(user.user!.displayName.toString());
  }
}
