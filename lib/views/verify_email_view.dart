import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter1/services/auth/bloc/auth_event.dart';
import 'package:flutter1/utilities/elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "We've send you an email verification. Please verify your email to continue.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButtonMD3(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventSendEmailVerification());
                  },
                  child: Text('Resend Verification')),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogout());
                },
                child: const Text("Go Back"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
