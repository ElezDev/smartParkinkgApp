// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../api/constant.dart';
import '../../models/api_response_model.dart';
import '../../services/auth_service.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () {
      _initializeScreen();
    });
  }

  void _initializeScreen() async {
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      context.push('/starting');
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        context.go('/home');
      } else if (response.error == unauthorized) {
        context.push('/login');
      } else {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/animations/logo-3.gif',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
