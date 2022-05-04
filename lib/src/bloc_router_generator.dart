import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_router_generator/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'model_visitor.dart';

const _classAnnotationChecker = TypeChecker.fromRuntime(BlocRouter);
const _fieldAnnotationBlocChecker = TypeChecker.fromRuntime(BlocRoute);
const _fieldAnnotationUnBlocChecker = TypeChecker.fromRuntime(UnBlocRoute);
const _fieldAnnotationMultiBlocChecker =
    TypeChecker.fromRuntime(MultiBlocRoute);

class BlocRouterGenerator extends GeneratorForAnnotation<BlocRouter> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final classBuffer = StringBuffer();

    _classAnnotationChecker.firstAnnotationOfExact(element,
        throwOnUnresolved: true);

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

      final hasMultiBlocAnnotations =
          _fieldAnnotationMultiBlocChecker.hasAnnotationOf(field);
      if (hasMultiBlocAnnotations) {
        _processMultiBlocRoute(className, field, classBuffer);
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

    classBuffer
        .writeln('$className.${field.name}: (context) => $screenType(),');
    classBuffer.writeln('\n');
  }

  void _processMultiBlocRoute(
      String? className, FieldElement field, StringBuffer classBuffer) {
    var blocTypes = _getBlocsListField(_fieldAnnotationMultiBlocChecker, field);
    var hasEmptyType = blocTypes.where((element) => element.isEmpty).isNotEmpty;
    if (blocTypes.isEmpty || hasEmptyType) {
      throw 'BlocTypes List not provided.';
    }
    var screenType = _getFieldScreen(_fieldAnnotationMultiBlocChecker, field);
    if (screenType.isEmpty) {
      throw 'ScreenType not provided.';
    }

    var fieldValue = field.computeConstantValue()?.toStringValue();
    if (fieldValue == null) {
      throw 'Field should be a constant with value.';
    }

    classBuffer
        .writeln('$className.${field.name}: (context) => MultiBlocProvider(');
    classBuffer.writeln('providers: [');
    for (String blocType in blocTypes) {
      classBuffer.writeln('BlocProvider(');
      classBuffer.writeln('create: (context) => $blocType(),');
      classBuffer.writeln('),');
    }
    classBuffer.writeln('],');
    classBuffer.writeln('child: $screenType(),');
    classBuffer.writeln('),');
    classBuffer.writeln('\n');
  }

  String _getFieldBloc(TypeChecker checker, FieldElement field) {
    return checker
            .firstAnnotationOfExact(field)
            ?.getField('bloc')
            ?.toTypeValue()
            ?.element
            ?.name ??
        '';
  }

  List<String> _getBlocsListField(TypeChecker checker, FieldElement field) {
    return checker
            .firstAnnotationOfExact(field)
            ?.getField('blocs')
            ?.toListValue()
            ?.map((e) => e.toTypeValue()?.element?.name ?? '')
            .toList() ??
        List.empty();
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
