const blocRouter = BlocRouter();

class BlocRouter {
  const BlocRouter();
}

class BlocRoute {
  final Type bloc;
  final Type screen;

  const BlocRoute({
    required this.bloc,
    required this.screen,
  });
}

class MultiBlocRoute {
  final List<Type> blocs;
  final Type screen;

  const MultiBlocRoute({
    required this.blocs,
    required this.screen,
  });
}

class UnBlocRoute {
  final Type screen;

  const UnBlocRoute({
    required this.screen,
  });
}
