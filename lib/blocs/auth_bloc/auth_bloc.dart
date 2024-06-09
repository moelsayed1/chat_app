import 'dart:developer';
import 'package:chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
      try {
        emit(LoginLoading());
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: event.email, password: event.password);
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
    });
  }
}
