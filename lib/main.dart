import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/helpers/loading/loading_screen.dart';
import 'package:flutter1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter1/services/auth/bloc/auth_event.dart';
import 'package:flutter1/services/auth/bloc/auth_state.dart';
import 'package:flutter1/services/auth/firebase_auth_provider.dart';
import 'package:flutter1/views/forgot_password_view.dart';
import 'package:flutter1/views/login_view.dart';
import 'package:flutter1/views/notes/create_update_note_view.dart';
import 'package:flutter1/views/notes/notes_view.dart';
import 'package:flutter1/views/register_view.dart';
import 'package:flutter1/views/settings_view.dart';
import 'package:flutter1/views/verify_email_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));

  runApp(BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(FirebaseAuthProvider()),
    child: DynamicColorBuilder(builder: (
      ColorScheme? lightDynamic,
      ColorScheme? darkDynamic,
    ) {
      final lightColorScheme =
          lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.blue);
      final darkColorScheme = darkDynamic ??
          ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark);
      return MaterialApp(
        title: 'Quick Notes',
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        home: const HomePage(),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        routes: {
          createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
          settingsRoute: (context) => const SettingsView(),
        },
      );
    }),
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
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
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
