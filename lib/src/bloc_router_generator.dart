import 'package:bloc_router_generator/annotations/bloc_route.dart';
import 'package:bloc_router_generator/annotations/bloc_router.dart';
import 'package:bloc_router_generator/annotations/unbloc_route.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

const _classAnnotationChecker = TypeChecker.fromRuntime(BlocRouter);
const _fieldAnnotationBlocChecker = TypeChecker.fromRuntime(BlocRoute);
const _fieldAnnotationUnBlocChecker = TypeChecker.fromRuntime(UnBlocRoute);

class BlocRouterGenerator extends GeneratorForAnnotation<BlocRouter> {
  // 1
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // 2
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();

    var clearClassName = visitor.className?.replaceFirst('_', '');
    classBuffer.writeln(
        'class ${clearClassName}Builder extends ${visitor.className} {');

    classBuffer.writeln('\n');
    _generateParams(visitor.className, element as ClassElement, classBuffer);
    classBuffer.writeln('\n');
    classBuffer.writeln('}');

    return classBuffer.toString();
  }

  void _generateParams(
      String? className, ClassElement visitor, StringBuffer classBuffer) {
    //Create Routes Map
    classBuffer.writeln('static Map<String, WidgetBuilder> getRoutes() => {');
    for (final field in visitor.fields) {
      final hasBlocAnnotations =
          _fieldAnnotationBlocChecker.hasAnnotationOf(field);
      if (hasBlocAnnotations) {
        _processBlocRoute(className, field, classBuffer);
      }
      final hasUnBlocAnnotations =
          _fieldAnnotationUnBlocChecker.hasAnnotationOf(field);
      if (hasUnBlocAnnotations) {
        _processUnBlocRoute(className, field, classBuffer);
      }
    }
    classBuffer.writeln('};');
    classBuffer.writeln('\n');
    //Create Getters
    for (final field in visitor.fields) {
      classBuffer.writeln(
          'static String get ${field.name}Route => $className.${field.name};');
      classBuffer.writeln('\n');
    }
  }

  void _processBlocRoute(
      String? className, FieldElement field, StringBuffer classBuffer) {
    var blocType = _getFieldBloc(_fieldAnnotationBlocChecker, field);
    if (blocType.isEmpty) {
      throw 'BlocType not provided.';
    }
    var screenType = _getFieldScreen(_fieldAnnotationBlocChecker, field);
    if (screenType.isEmpty) {
      throw 'ScreenType not provided.';
    }

    var fieldValue = field.computeConstantValue()?.toStringValue();
    if (fieldValue == null) {
      throw 'Field should be a constant with value.';
    }

    classBuffer.writeln('$className.${field.name}: (context) => BlocProvider(');
    classBuffer.writeln('create: (context) => $blocType(),');
    classBuffer.writeln('child: $screenType(),');
    classBuffer.writeln('),');
    classBuffer.writeln('\n');
  }

  void _processUnBlocRoute(
      String? className, FieldElement field, StringBuffer classBuffer) {
    var screenType = _getFieldScreen(_fieldAnnotationUnBlocChecker, field);
    if (screenType.isEmpty) {
      throw 'ScreenType not provided.';
    }
    var fieldValue = field.computeConstantValue()?.toStringValue();
    if (fieldValue == null) {
      throw 'Field should be a constant with value.';
    }

    classBuffer.writeln('$className.$fieldValue: (context) => $screenType(),');
    classBuffer.writeln('\n');
  }

  String _getFieldBloc(TypeChecker checker, FieldElement field) {
    return checker
            .firstAnnotationOfExact(field)
            ?.getField('blocType')
            ?.toTypeValue()
            ?.element
            ?.name ??
        '';
  }

  String _getFieldScreen(TypeChecker checker, FieldElement field) {
    return checker
            .firstAnnotationOfExact(field)
            ?.getField('screen')
            ?.toTypeValue()
            ?.element
            ?.name ??
        '';
  }
}
