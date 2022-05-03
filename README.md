# bloc_router_generator

Package for generation named routes with BLoC providers.

## Usage

Declare your app routes in abstract class (for example `_AppRoutes`):

* Use `BlocRoute` annotation for route with BLoC provider
* Use `UnBlocRoute` annotation to create route without BLoC;
* Use `MultiBlocRoute` annotation to create route with `MultiBlocProvider`;

 
Add generated class as part:

`part 'test.g.dart';` 

Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate routes with BLoC. 
 
Use generated class `*your_class_name*Builder` to access the routes.

Full Example:

```
@blocRouter
abstract class _AppRoutes {
  @BlocRoute(bloc: TestBloc, screen: Container)
  static const String login = 'login';

  @MultiBlocRoute(blocs: [Bloc1, Bloc2], screen: Container)
  static const multiBlocLogin = 'multi_bloc_login';

  @UnBlocRoute(screen: Container)
  static const String signUp = 'signUp';
}
```

Use generated routes in your `MaterialApp`:

```
 MaterialApp(
      routes: AppRoutesBuilder.getRoutes(),
      initialRoute: AppRoutesBuilder.loginScreenRoute,
    );
```
Use `Navigator` as usual:

```
 Navigator.pushNamed(context, AppRoutesBuilder.homeScreenRoute);
```

To avoid issues also add bloc import to your routes class.

`import 'package:flutter_bloc/flutter_bloc.dart';`

