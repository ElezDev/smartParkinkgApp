// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:smartparking/config/fonts_styles.dart';
import 'package:smartparking/controllers/perfil_controller.dart';
import 'package:smartparking/models/user_profile_model.dart';
import 'package:smartparking/screens/inicio/card_screen.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  UserData? userProfile;
  bool isLoading = true;
  final ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _profileController.fetchAndSetProfileData(getProfileData);
      },
    );
  }

  void getProfileData(UserData? profile, bool loading) {
    setState(() {
      userProfile = profile;
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.dashboard_rounded,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            '${userProfile?.userData.persona.nombre1} ${userProfile?.userData.persona.apellido1}',
                            style: kTitleStylew,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/avatar.png'),
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.repeat),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Categorieas(),
                  const SizedBox(
                    height: 20,
                  ),
                  const MinInfo(),
                  const SizedBox(
                    height: 40,
                  ),
                  CardContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MinInfo extends StatelessWidget {
  const MinInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'categorias',
          style: kTlightproMax,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            'Todo',
            style: kTlightproMax,
          ),
        ),
      ],
    );
  }
}

class Categorieas extends StatelessWidget {
  const Categorieas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Text(
            'Top',
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: const Text(
            'Otro',
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: const Text(
            'Otro',
          ),
        ),
        SizedBox(height: 20, child: Image.asset('assets/images/enviar.png'))
      ],
    );
  }
}
