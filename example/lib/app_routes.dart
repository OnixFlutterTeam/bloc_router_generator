import 'package:bloc_router_generator/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';
import 'test_bloc/test_bloc.dart';

part 'app_routes.g.dart';

@blocRouter
abstract class _AppRoutes {
  @BlocRoute(bloc: TestBloc, screen: LoginScreen)
  static const loginScreen = 'login_screen';

  @UnBlocRoute(screen: HomeScreen)
  static const homeScreen = 'home_screen';
}
