import 'package:flutter/material.dart';
import 'core/app.dart';
import 'di/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await initSingletons();
  provideDataSources();
  provideRepositories();
  provideUseCases();
  runApp(ProviderScope(child: const MyApp()));
}
