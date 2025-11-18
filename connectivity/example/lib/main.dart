import 'dart:async';
import 'dart:developer';

import 'package:clover/clover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import 'view_models.dart';
import 'views.dart';

void main() {
  Logger.root.onRecord.listen(onLogRecord);
  runZonedGuarded(body, onError);
}

void onLogRecord(LogRecord record) {
  log(
    record.message,
    time: record.time,
    sequenceNumber: record.sequenceNumber,
    level: record.level.value,
    name: record.loggerName,
    zone: record.zone,
    error: record.error,
    stackTrace: record.stackTrace,
  );
}

void body() {
  runApp(const MyApp());
}

void onError(Object error, StackTrace stack) {
  Logger.root.shout('Unhandled error', error, stack);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter routerConfig;

  @override
  void initState() {
    super.initState();
    routerConfig = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ViewModelBinding(
            viewBuilder: () => const HomeView(),
            viewModelBuilder: () => HomeViewModel(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: routerConfig);
  }

  @override
  void dispose() {
    routerConfig.dispose();
    super.dispose();
  }
}
