import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              title: const Text("Sign out ?"),
              actions: [
                TextButton(
                  onPressed: () async => Navigator.of(context).pop(),
                  child: const Text('cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text('confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
