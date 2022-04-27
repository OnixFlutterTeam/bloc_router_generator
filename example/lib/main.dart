import 'package:bloc_router_generator/annotations/bloc_route.dart';
import 'package:bloc_router_generator/annotations/bloc_router.dart';
import 'package:bloc_router_generator/annotations/unbloc_route.dart';
import 'package:bloc_router_generator_example/test.dart';
import 'package:bloc_router_generator_example/test_bloc/test_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bloc_router_generator/bloc_router_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TestBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }
}

part 'test.g.dart';

@blocRouter
abstract class _AppRoutes {
  @BlocRoute(blocType: TestBloc, screen: Container)
  static const String login = 'login';

  @UnBlocRoute(screen: Container)
  static const String signUp = 'signUp';
}


