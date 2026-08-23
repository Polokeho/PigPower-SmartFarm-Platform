import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';

class PigPowerApp extends ConsumerWidget {
  const PigPowerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'PigPower Lesotho',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1F3B57), // matches the brand navy used in the BEDCO proposal
        useMaterial3: true,
      ),
      // 5.6 AD-MOB-008 — English and Sesotho, per SACM FR-SACM-022.
      // Sesotho ARB strings are added incrementally as screens are
      // localized; English is the default/fallback.
      supportedLocales: const [Locale('en'), Locale('st')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
