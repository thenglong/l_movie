import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l_movie/blocs/auth_bloc/auth_bloc.dart';
import 'package:l_movie/blocs/auth_bloc/auth_event.dart';
import 'package:l_movie/blocs/auth_bloc/auth_state.dart';
import 'package:l_movie/blocs/main_bloc_observer.dart';
import 'package:l_movie/providers/firebase_auth_provider.dart';
import 'package:l_movie/screens/forgot_password_screen.dart';
import 'package:l_movie/screens/home_screen.dart';
import 'package:l_movie/screens/loading_screen.dart';
import 'package:l_movie/screens/login_screen.dart';
import 'package:l_movie/screens/register_screen.dart';
import 'package:l_movie/screens/verify_email_screen.dart';
import 'package:l_movie/theme/theme.dart';

import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () {
      runApp(const MainApp());
    },
    blocObserver: MainBlocObserver(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie App",
      theme: defaultTheme,
      locale: Locale("km"),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // home: const HomeScreen(),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          FirebaseAuthProvider(),
        ),
        child: const InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          // return const NotesView();
          return const HomeScreen();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailScreen();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordScreen();
        } else if (state is AuthStateRegistering) {
          return const RegisterScreen();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
