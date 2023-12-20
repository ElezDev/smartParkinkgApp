// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartparking/config/fonts_styles.dart';
import 'package:smartparking/models/api_response_model.dart';
import 'package:smartparking/models/auth_user_model.dart';
import 'package:smartparking/services/auth_service.dart';
import 'package:smartparking/widgets/alert.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  bool _passwordVisible = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);

    if (response.error == null) {
      Alert.snacbarSuccess(
          context: context, title: '¡Bienvenido!', message: '');
      setState(() {
        loading = true;
      });
      _saveAndRedirectToHome(response.data as User);
    } else {
      Alert.snacbarError(
          context: context,
          title: 'Error',
          message: 'Correo o contraseña incorrectos');
      setState(() {
        loading = false;
      });
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token);
    await pref.setString('email', txtEmail.text);
    await pref.setString('contrasena', txtPassword.text);

    context.go('/home');
  }

  void _loadSavedCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? savedEmail = pref.getString('email');
    String? savedPassword = pref.getString('contrasena');
    if (savedEmail != null && savedPassword != null) {
      txtEmail.text = savedEmail;
      txtPassword.text = savedPassword;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    "assets/images/taxi_login.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 130.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: const Text(
                    "INICIAR SESIÓN",
                    style: kTitleStyle,
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.7),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 100.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: txtEmail,
                            validator: (val) =>
                                val!.isEmpty ? 'Correo invalido' : null,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.white)),
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: txtPassword,
                            obscureText: !_passwordVisible,
                            validator: (val) => val!.length < 6
                                ? 'La contraseña debe tener al menos 6 caracteres'
                                : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.white)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loading
                              ? AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: Center(
                                          child: Image.asset(
                                              "assets/animations/logo-3.gif"),
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                      const Text(
                                        'Iniciando sesión...',
                                        style: kTlightpromin,
                                      ),
                                    ],
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      _loginUser();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 90.0, vertical: 15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    side: const BorderSide(
                                      color: Colors
                                          .grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: const Text('Login',
                                      style: kTitleStyleDark),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                context.push('/register');
                              },
                              child: const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Don\'t have an account?',
                                    style: kTlight,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Averta_Light',
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
