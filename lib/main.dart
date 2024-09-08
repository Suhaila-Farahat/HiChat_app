import 'package:chat_app/Blocs/auth_bloc.dart';
import 'package:chat_app/Features/Auth_Cubit/auth_cubit.dart';
import 'package:chat_app/Features/Chat_Cubit/chat_cubit.dart';
import 'package:chat_app/Views/Chat_View.dart';
import 'package:chat_app/Views/Login_View.dart';
import 'package:chat_app/Views/Sign_View.dart';
import 'package:chat_app/Views/Splash.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
      providers: [
        // BlocProvider(create:(context) => LoginCubit()),
        // BlocProvider(create:(context) => RegisterCubit()),
        BlocProvider(create:(context) => ChatCubit()),
        BlocProvider(create:(context) => AuthCubit()),
        BlocProvider(create:(context) => AuthBloc()),
      ],
      child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.id: (context) => Splash(),
        LoginView.id: (context) => LoginView(),
        SignInView.id: (context) => SignInView(),
        ChatView.id: (context) => ChatView(),
      },
      initialRoute: Splash.id,
    );
  }
}
