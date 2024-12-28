import 'package:flutter/material.dart';
import 'package:flutter1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter1/services/auth/bloc/auth_event.dart';
import 'package:flutter1/services/auth/bloc/auth_state.dart';
import 'package:flutter1/utilities/dialogs/error_dialog.dart';
import 'package:flutter1/utilities/dialogs/password_reset_email_sent_dialog.dart';
import 'package:flutter1/utilities/elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetEmailSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
                context, "We couldn't send the email. Please try again.");
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/icon/icon.png",
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Pasword Reset",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controller,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButtonMD3(
                onPressed: () async {
                  final email = _controller.text;
                  context.read<AuthBloc>().add(AuthEventForgotPassword(email));
                },
                child: Text('Send Email'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventLogout());
                },
                child: const Text("Login"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
