import 'dart:developer';
import 'package:chat_app/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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


  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      emit(RegisterLoading());
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
      log(user.user!.displayName.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errMessage: 'This account already exists for that email'));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: 'there was an error, please try again!'));
    }
  }
}
