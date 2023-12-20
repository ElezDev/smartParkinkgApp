// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartparking/controllers/perfil_controller.dart';
import 'package:smartparking/models/user_profile_model.dart';
import 'package:smartparking/provider/theme_dark_or_light.dart';
import 'package:smartparking/screens/profile/logout_screen.dart';
import 'package:smartparking/widgets/custom_loading_screen.dart';
import 'package:smartparking/config/fonts_styles.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  UserData? userProfile;
  bool isLoading = true;
  final ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    _profileController.fetchAndSetProfileData(getProfileData);
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 231, 71),
        elevation: 0,
        title: const Center(
          child: Text(
            "Mi Perfil",
            style: kTitleStylew,
          ),
        ),
      ),
      endDrawer: Drawer(
        width: 230,
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                padding: const EdgeInsets.only(top: 90, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 234, 231, 71),
                ),
                child: const Row(
                  children: [
                    Text('Ajustes', style: kTitleStylew),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.settings)
                  ],
                )),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const IconThemoMode(),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.pop();
                        context.push('/update_profile');
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Actualizar Perfil'),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                      logoutApp(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Cerrar sesión'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: isLoading
            ? const Center(
                child: CustomLoadingScreen(),
              )
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 234, 231, 71),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                          backgroundImage: isLoading
                              ? null
                              : NetworkImage(
                                  '${userProfile?.userData.persona.rutaFotoUrl}',
                                ),
                          child: const Stack(
                            alignment: Alignment.bottomRight,
                            children: [],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${userProfile?.userData.persona.nombre1} ${userProfile?.userData.persona.apellido1}',
                              style: kTitleStylew,
                            ),
                            Text(
                              '${userProfile?.userData.persona.email}',
                              style: kTlight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Información Personal",
                        style: kTitleStyleDark,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextFieldWithIcon(
                          "Telefono",
                          Icons.phone,
                          '${userProfile?.userData.persona.celular}',
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          "Documento",
                          Icons.badge_outlined,
                          '${userProfile?.userData.persona.identificacion}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildTextFieldWithIcon(String label, IconData icon, String value) {
    return Container(
      width: 900,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 234, 231, 71),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: kTlightproSmall,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: kTlightpro,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconThemoMode extends ConsumerWidget {
  const IconThemoMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkmode = ref.watch(isDarkmodeProvider);
    return ElevatedButton(
      onPressed: () {
        ref
            .read(isDarkmodeProvider.notifier)
            .update((isDarkmode) => !isDarkmode);
      },
      child: Row(
        children: [
          Icon(isDarkmode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          const SizedBox(
            width: 5,
          ),
          const Text('Tema'),
        ],
      ),
    );
  }
}
