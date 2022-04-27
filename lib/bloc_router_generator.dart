
import 'package:bloc_router_generator/src/bloc_router_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder generateRouter(BuilderOptions options) =>
    SharedPartBuilder([BlocRouterGenerator()], 'subclass_generator');
