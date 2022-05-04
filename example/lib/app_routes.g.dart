// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// BlocRouterGenerator
// **************************************************************************

class AppRoutesBuilder extends _AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() => {
        _AppRoutes.loginScreen: (context) => BlocProvider(
              create: (context) => TestBloc(),
              child: LoginScreen(),
            ),
        _AppRoutes.multiBlocLogin: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => TestBloc(),
                ),
                BlocProvider(
                  create: (context) => TestBloc(),
                ),
              ],
              child: LoginScreen(),
            ),
        _AppRoutes.homeScreen: (context) => HomeScreen(),
      };

  static String get loginScreenRoute => _AppRoutes.loginScreen;

  static String get multiBlocLoginRoute => _AppRoutes.multiBlocLogin;

  static String get homeScreenRoute => _AppRoutes.homeScreen;
}
