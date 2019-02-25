import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:json_serializable/type_helper.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';


class JsonInflater {

  final bool anyMap;

  final bool checked;

  final bool createFactory;

  final bool createToJson;

  final bool disallowUnrecognizedKeys;

  final bool explicitToJson;

  final FieldRename fieldRename;

  final bool generateToJsonFunction;

  final bool includeIfNull;

  final bool nullable;

  final bool useWrappers;

  const JsonInflater({
    this.anyMap,
    this.checked,
    this.createFactory,
    this.createToJson,
    this.disallowUnrecognizedKeys,
    this.explicitToJson,
    this.fieldRename,
    this.generateToJsonFunction,
    this.includeIfNull,
    this.nullable,
    this.useWrappers,
  });

}


class JsonInflaterGenerator extends Generator {

  TypeChecker get typeChecker => TypeChecker.fromRuntime(JsonInflater);

  @override
  generate(LibraryReader library, BuildStep buildStep) {
    var values = List<String>();

    values.add("""
      dynamic parse<T>(dynamic data, [String typeName]) {
        Type t = T;
        return _\$getInstanceT(data, typeName ?? t.toString());
      }
    """);

    values.add("""
      _\$getInstanceT(dynamic data, String typeName) {
      
          if (isDynamicType(typeName)) {
            return data;
          }
        
          if (isBuiltInType(typeName)) {
            if (getMainType(typeName) == "List") {
              return (data as List).map((t) {
                return _\$getInstanceT(t, getGenericsType(typeName));
              }).toList();
            }
        
          if (getMainType(typeName) == "Map") {
            return (data as Map<String, dynamic>).map((k, v) {
              return MapEntry<String, dynamic>(k, _\$getInstanceT(v, getGenericsType(typeName)));
            });
          }
            return data;
          }
        
     """);

    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      print(annotatedElement.element.name);
      var generatedValue = generateInstance(annotatedElement.element);
      values.add(generatedValue);
    }
    values.add("return null;");
    values.add("}");

    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      var generatedValue = generateForAnnotatedElement(
          annotatedElement.element, annotatedElement.annotation, buildStep);
      values.addAll(generatedValue);

      var extendsClass = generateExtendsClass(annotatedElement.element);
      values.add(extendsClass);
    }

    final valuesStr =  values.join('\n\n');

    RegExp exp = RegExp(r'_\$(.+)FromJson(<.+>)?\(Map<String, dynamic> json\)');

    final result = valuesStr.replaceAllMapped(exp, (m) {
      String str = m.group(0);
      return str.substring(0, str.length - 27) + "(Map<String, dynamic> json, [String typeName])";
    });

    return result;
  }

  String generateInstance(Element element) {
    if (element is!  ClassElement) {
      throw InvalidGenerationSourceError('Generator cannot target `${element.name}`.',
          todo: 'Remove the JsonInflater annotation from `${element.name}`.',
          element: element);
    }

    ClassElement classElement = element as ClassElement;

    String output = """
    
      if (getMainType(typeName) == \"${classElement.name}\") {
          return _\$${classElement.name}FromJson(data, getGenericsType(typeName));
      }
      
    """;
    return output;
  }

  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return JsonSerializableGenerator.withDefaultHelpers([GenericsHelper()]).generateForAnnotatedElement(element, annotation, buildStep);
  }

  String generateExtendsClass(Element element) {
    if (element is!  ClassElement) {
      throw InvalidGenerationSourceError('Generator cannot target `${element.name}`.',
          todo: 'Remove the JsonInflater annotation from `${element.name}`.',
          element: element);
    }

    final classElement = element as ClassElement;

    String genericsName = "";
    if (classElement.typeParameters.length > 0) {
      genericsName = "<${classElement.typeParameters.first.name}>";
    }

    var output = """
      mixin PartOf${element.name} {

        static ${element.name}$genericsName parse$genericsName(Map<String, dynamic> map) {
          return _\$${element.name}FromJson$genericsName(map);
        }
        
        Map<String, dynamic> toJson() => _\$${element.name}ToJson(this);
      
      }
    
    """;

    return output;
  }

}

Builder jsonInflaterBuilder(BuilderOptions options) => SharedPartBuilder([JsonInflaterGenerator()], "json_inflater");


class GenericsHelper extends TypeHelper {
  @override
  Object deserialize(DartType targetType, String expression, TypeHelperContext context) {
    if (targetType.element is TypeParameterElement) {
      return "parse<${targetType.name}>($expression, typeName ?? ${targetType.name}.toString())";
    }
    return null;
  }

  @override
  Object serialize(DartType targetType, String expression, TypeHelperContext context) {
    if (targetType.element is TypeParameterElement) {
      return "toMap($expression)";
    }
    return null;
  }

}

isGenerics(String typeName) {
  return typeName.contains("<");
}

getMainType(String typeName) {
  final index = typeName.indexOf("<");

  if (index == -1) {
    return typeName;
  } else {
    return typeName.substring(0, index);
  }
}

getGenericsType(String typeName) {
  final index = typeName.indexOf("<");

  if (index == -1) {
    return null;
  } else {
    return typeName.substring(index + 1, typeName.length - 1);
  }
}

isBuiltInType(String typeName) {
  final mainType = getMainType(typeName);
  if (mainType == "String"
      || mainType == "int"
      || mainType == "double"
      || mainType == "bool"
      || mainType == "List"
      || mainType == "Map") {
    return true;
  }
  return false;
}

isDynamicType(String typeName) {
  return typeName == "dynamic";
}

toMap(dynamic instance) {
  final typeName = instance.runtimeType.toString();

  if (isBuiltInType(typeName)) {

    if (getMainType(typeName) == "List") {
      return (instance as List).map((t) {
        return toMap(t);
      }).toList();
    }

    if (getMainType(typeName) == "Map") {
      return (instance as Map<String, dynamic>).map((k, v) {
        return MapEntry(k, toMap(v));
      });
    }

    return instance;
  }
  return (instance as dynamic).toJson();
}
