import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/utilities/elevated_button.dart';

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
                onPressed: () async {
                  final user = AuthService.firebase().currentUser;
                  await AuthService.firebase().sendEmailVerification();
                },
                child: Text('Resend Verification')),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  reigsterRoute,
                  (_) => false,
                );
              },
              child: const Text("Go Back"),
            )
          ],
        ),
      ),
    );
  }
}
