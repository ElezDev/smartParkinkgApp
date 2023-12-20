// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartparking/config/fonts_styles.dart';
import 'package:smartparking/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logoutApp(BuildContext context) async {
  logout();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/animations/logo-3.gif",
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            const Text(
              "Cerrando sesión...",
              style: kTlightpro,
            ),
          ],
        ),
      );
    },
  );

  await Future.delayed(const Duration(seconds: 1));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');

  context.pop();
  context.go('/login');
}
