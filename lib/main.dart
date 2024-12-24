import 'package:flutter/material.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/firebase_options.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/views/login_view.dart';
import 'package:flutter1/views/notes_view.dart';
import 'package:flutter1/views/register_view.dart';
import 'package:flutter1/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => LoginView(),
      reigsterRoute: (context) => RegisterView(),
      notesRoute: (context) => NotesView(),
      verifyEmailRoute: (context) => VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;

              if (user != null) {
                if (user.isEmailVerified) {
                  return NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return CircularProgressIndicator();
          }
        });
  }
}
