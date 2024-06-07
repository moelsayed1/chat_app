import 'dart:developer';
import 'package:chat_app/cubits/login_cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      emit(LoginLoading());
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
      log(user.user!.displayName.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'Wrong password provided for that user'));
      } else if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'No user found for that email'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'there was an error, please try again!'));
    }
  }
}
