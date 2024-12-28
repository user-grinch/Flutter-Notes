import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/helpers/loading/loading_screen.dart';
import 'package:flutter1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter1/services/auth/bloc/auth_event.dart';
import 'package:flutter1/services/auth/bloc/auth_state.dart';
import 'package:flutter1/services/auth/firebase_auth_provider.dart';
import 'package:flutter1/views/login_view.dart';
import 'package:flutter1/views/notes/create_update_note_view.dart';
import 'package:flutter1/views/notes/notes_view.dart';
import 'package:flutter1/views/register_view.dart';
import 'package:flutter1/views/settings_view.dart';
import 'package:flutter1/views/verify_email_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Quick Notes',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          // Set the predictive back transitions for Android.
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        },
      ),
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    routes: {
      createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      settingsRoute: (context) => BlocProvider.value(
            value: context.read<AuthBloc>(),
            child: const SettingsView(),
          ),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitiate());
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
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
