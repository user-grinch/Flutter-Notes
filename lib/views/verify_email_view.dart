import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/services/auth/auth_service.dart';

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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  final user = AuthService.firebase().currentUser;
                  await AuthService.firebase().sendEmailVerification();
                },
                child: const Text("Resend Verifciation")),
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
