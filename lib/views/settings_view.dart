import 'package:flutter/material.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter1/services/auth/bloc/auth_event.dart';
import 'package:flutter1/utilities/dialogs/logout_dialog.dart';
import 'package:flutter1/utilities/elevated_button.dart';
import 'package:flutter1/utilities/toggle_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings", style: TextStyle(fontSize: 32)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchMD3(
                      label: 'Material You Theming',
                      onChanged: (value) {},
                    ),
                    SwitchMD3(
                      label: 'Sync with cloud',
                      onChanged: (value) {},
                    ),
                  ],
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButtonMD3(
                        onPressed: () {},
                        child: Text('Privacy Policy'),
                      ),
                      ElevatedButtonMD3(
                        onPressed: () async {
                          final shouldLogout = await showLogOutDialog(context);
                          if (shouldLogout) {
                            context.read<AuthBloc>().add(
                                  const AuthEventLogout(),
                                );
                          }
                        },
                        child: Text('Log Out'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Version: 1.0.0\nCopyright © 2024 Enan Ahammad',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
              ]),
        ));
  }
}
