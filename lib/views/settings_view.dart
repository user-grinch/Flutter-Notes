import 'package:flutter/material.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/utilities/elevated_button.dart';
import 'package:flutter1/utilities/outlined_button.dart';
import 'package:flutter1/utilities/toggle_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void logOutHandler() async {
    final shouldLogout = await showLogOutDialog(context);
    if (shouldLogout) {
      await AuthService.firebase().logOut();
      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
    }
  }

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
                        onPressed: logOutHandler,
                        text: 'Privacy Policy',
                      ),
                      ElevatedButtonMD3(
                        onPressed: logOutHandler,
                        text: 'Log Out',
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

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to Logout?"),
            actions: [
              OutlinedButtonMD3(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                text: "Cancel",
              ),
              ElevatedButtonMD3(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                text: 'Yes',
              )
            ]);
      }).then((value) => value ?? false);
}
