import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartparking/config/router/app_router.dart';
import 'package:smartparking/config/theme/app_theme.dart';
import 'package:smartparking/provider/theme_dark_or_light.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = ref.watch(isDarkmodeProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme(selectedColor: 3, isDarkMode: isDarkmode).getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
