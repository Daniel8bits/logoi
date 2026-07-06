import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/core_providers.dart';
import 'features/project/widgets/home_screen.dart';
import 'shared/theme/app_theme.dart';

class LogoiApp extends ConsumerWidget {
  const LogoiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return MaterialApp(
      title: 'Logoi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.of(themeMode),
      home: const HomeScreen(),
    );
  }
}
