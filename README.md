# bloc_router_generator

Package for generation named routes with BLoC providers.

## Installing

Add package to `dependencies` and `dev_dependencies`

## Usage

Add generated class as part:

`part 'test.g.dart';`

Add annotation for a class with routes.

Use `BlocRoute` annotation for route with BLoC provider or `UnBlocRoute` without.

Dealare your routes:

`@BlocRoute(blocType: MyBloC, screen: MyScreen)`
`static const String login = 'login';`
 
  
Use generated class `AppRoutesBuilder` to access the routes.

Full Example:

```
@blocRouter
abstract class _AppRoutes {
  @BlocRoute(blocType: TestBloc, screen: Container)
  static const String login = 'login';

  @UnBlocRoute(screen: Container)
  static const String signUp = 'signUp';
}
```
To avoid issues also add bloc import to your routes class.

`import 'package:flutter_bloc/flutter_bloc.dart';`

