import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/password_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  onChanged: (data)
                  {
                    email = data;
                  },
                  hintText: 'Enter Your Email',
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 15.0,
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
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatView.id, arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          showSnackBar(
                              context, 'Wrong password provided for that user');
                        } else if (e.code == 'user-not-found') {
                          showSnackBar(context,
                              'No user found for that email');
                        }
                      } catch (e) {
                        showSnackBar(
                            context, 'there was an error, please try again!');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                    else{}
                  },
                  text: 'Sign In',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterView.id);
                      },
                      child: const Text(
                        'Sign Up',
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
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
