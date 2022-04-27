// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// BlocRouterGenerator
// **************************************************************************

class AppRoutesBuilder extends _AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() => {
        _AppRoutes.loginScreen: (context) => BlocProvider(
              create: (context) => TestBloc(),
              child: const LoginScreen(),
            ),
        _AppRoutes.homeScreen: (context) => const HomeScreen(),
      };

  static String get loginScreenRoute => _AppRoutes.loginScreen;

  static String get homeScreenRoute => _AppRoutes.homeScreen;
}
