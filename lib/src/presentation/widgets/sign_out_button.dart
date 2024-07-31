import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout_outlined),
      onPressed: () async {
        return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S.of(context).signOutDialogTitle),
              actions: [
                TextButton(
                  onPressed: () async => Navigator.of(context).pop(),
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text(S.of(context).confirm),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
