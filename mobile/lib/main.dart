import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase.initializeApp() would be called here once the project is
  // configured with real Firebase config files, per 5.6 AD-MOB-006
  // (FCM used strictly as push-notification transport).

  runApp(const ProviderScope(child: PigPowerApp()));
}
