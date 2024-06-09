import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/login_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  BlocOverrides.runZoned(
    () => runApp(const ScholarChat()),
    blocObserver: SimpleBlocObserver(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginView.id: (context) => const LoginView(),
          RegisterView.id: (context) => const RegisterView(),
          ChatView.id: (context) => ChatView(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginView.id,
      ),
    );
  }
}
