// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// BlocRouterGenerator
// **************************************************************************

class AppRoutesBuilder extends _AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() => {
        _AppRoutes.login: (context) => BlocProvider(
              create: (context) => TestBloc(),
              child: LoginScreen(),
            ),
        _AppRoutes.home: (context) => HomeScreen(),
      };

  static String get loginRoute => _AppRoutes.login;

  static String get homeRoute => _AppRoutes.home;
}
