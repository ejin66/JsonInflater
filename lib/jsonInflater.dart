import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:jsoninflater/cacheInfo.dart';
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

Builder jsonInflaterBuilder(BuilderOptions options) => SharedPartBuilder([JsonInflaterGenerator()], "json_inflater");

class JsonInflaterGenerator extends Generator {

  static List<CacheInfo> cacheInfoList = [];

  TypeChecker get typeChecker => TypeChecker.fromRuntime(JsonInflater);

  @override
  generate(LibraryReader library, BuildStep buildStep) {
    var values = List<String>();


    var allClassElements = library.annotatedWith(typeChecker).map((e) {
      return e.element as ClassElement;
    }).toList();

    if (allClassElements.length > 0) {
      cacheInfoList.add(CacheInfo(buildStep.inputId.package, buildStep.inputId.path));
    }

    values.addAll(generateParseFunctions());
    values.addAll(generateGetInstanceFunctions(allClassElements));

    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      var generatedValue = generateForAnnotatedElement(
          annotatedElement.element, annotatedElement.annotation, buildStep);
      values.addAll(generatedValue);

      var extendsClass = generateExtendsClass(annotatedElement.element);
      values.add(extendsClass);
    }

    var valuesStr =  values.join('\n\n');

    RegExp exp = RegExp(r'_\$(.+)FromJson<(.+?)>(\(Map<String, dynamic> json\))([\s\S]*?)(parseMap<.+>)([\s\S]*?)}');
    exp.allMatches(valuesStr).forEach((m) {
      valuesStr += _parseValue(m.group(1), m.group(2), m.group(3), m.group(4), m.group(6), 2);
      valuesStr += _parseValue(m.group(1), m.group(2), m.group(3), m.group(4), m.group(6), 3);
      valuesStr += _parseValue(m.group(1), m.group(2), m.group(3), m.group(4), m.group(6), 4);
    });

    return valuesStr;
  }


  Iterable<String> generateParseFunctions() {
    const parse = """
      T parseMap<T>(dynamic data) {
        return _\$getInstanceT<T>(data);
      }
    """;
    const parse2 = """
      T2 parseMap2<T2, T1>(dynamic data) {
        return _\$getInstanceT2<T2, T1>(data);
      }
    """;
    const parse3 = """
      T3 parseMap3<T3, T2, T1>(dynamic data) {
        return _\$getInstanceT3<T3, T2, T1>(data);
      }
    """;
    const parse4 = """
      T4 parseMap4<T4, T3, T2, T1>(dynamic data) {
        return _\$getInstanceT4<T4, T3, T2, T1>(data);
      }
    """;
    const parse5 = """
      T5 parseMap5<T5, T4, T3, T2, T1>(dynamic data) {
        return _\$getInstanceT5<T5, T4, T3, T2, T1>(data);
      }
    """;
    return [parse, parse2, parse3, parse4, parse5];
  }

  Iterable<String> generateGetInstanceFunctions(List<ClassElement> elements) {
    var output = <String>[];
    output
      ..addAll(_getInstanceFunc(elements))
      ..addAll(_getInstanceFuncMulti(elements, 2))
      ..addAll(_getInstanceFuncMulti(elements, 3))
      ..addAll(_getInstanceFuncMulti(elements, 4))
      ..addAll(_getInstanceFuncMulti(elements, 5));
    return output;
  }

  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return JsonSerializableGenerator.withDefaultHelpers([GenericsHelper(), JsonInflaterModelHelper()]).generateForAnnotatedElement(element, annotation, buildStep);
  }

  String generateExtendsClass(Element element) {
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

class GenericsHelper extends TypeHelper {
  @override
  Object deserialize(DartType targetType, String expression, TypeHelperContext context) {
    if (targetType.element is TypeParameterElement) {
      return "parseMap<${targetType.name}>($expression)";
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

class JsonInflaterModelHelper extends TypeHelper {
  @override
  Object deserialize(DartType targetType, String expression, TypeHelperContext context) {
    if (targetType.element is ClassElement) {
      var clsElement = targetType.element as ClassElement;
      var isJsonInflater = clsElement.metadata.any((e) => e.element.enclosingElement.name == "JsonInflater");
      if (isJsonInflater) {
        return "parseMap<${clsElement.name}>($expression)";
      }
    }
    return null;
  }

  @override
  Object serialize(DartType targetType, String expression, TypeHelperContext context) {
    if (targetType.element is ClassElement) {
      var clsElement = targetType.element as ClassElement;
      var isJsonInflater = clsElement.metadata.any((e) => e.element.enclosingElement.name == "JsonInflater");
      if (isJsonInflater) {
        return "$expression.toJson()";
      }
    }
    return null;
  }

}

bool _elementHasGenerics(ClassElement e) {
  return e.typeParameters.length > 0;
}

getMainType(String typeName) {
  final index = typeName.indexOf("<");

  if (index == -1) {
    return typeName;
  } else {
    return typeName.substring(0, index);
  }
}

isBuiltInType(String typeName) {
  final mainType = getMainType(typeName);
  if (mainType == "String"
      || mainType == "int"
      || mainType == "double"
      || mainType == "bool"
      || mainType == "List"
      || mainType == "Map"
      || mainType == "_InternalLinkedHashMap") {
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

    if (getMainType(typeName) == "Map" || getMainType(typeName) == "_InternalLinkedHashMap") {
      return (instance as Map<String, dynamic>).map((k, v) {
        return MapEntry(k, toMap(v));
      });
    }

    return instance;
  }
  return (instance as dynamic).toJson();
}

Iterable<String> _getInstanceFunc(List<ClassElement> elements) {
  var output = <String>[];
  const part1 = """
      T _\$getInstanceT<T>(dynamic data) {
          final typeName = T.toString();
          if (isBuiltInType(typeName) || isDynamicType(typeName)) {
            return data as T;
          }
     """;
  output.add(part1);

  elements.where((e) => !_elementHasGenerics(e)).forEach((e) {
    var part12 = """
        if (typeName == "${e.name}") {
          return _\$${e.name}FromJson(data) as T;
        }
      """;
    output.add(part12);
  });
  output.add("return null;");
  output.add("}");
  return output;
}

Iterable<String> _getInstanceFuncMulti(List<ClassElement> elements, int count) {

  var genericsName = "T1, T2";
  if (count == 3) {
    genericsName = "T1, T2, T3";
  } else if (count == 4) {
    genericsName = "T1, T2, T3, T4";
  } else if (count == 5) {
    genericsName = "T1, T2, T3, T4, T5";
  }


  var output = <String>[];
  var part2 = """
      T1 _\$getInstanceT$count<$genericsName>(dynamic data) {
        final typeName = getMainType(T1.toString());
    """;

  var builtInPart = """
      if (typeName == "List") {
          return (data as List).map((t) {
            return _\$getInstanceT${count - 1 == 1 ? "" : count - 1}<${genericsName.substring(3)}>(t);
          }).toList() as T1;
        }
    
        if (typeName == "Map") {
          return (data as Map).map((k, v) {
            return MapEntry<String, T2>(
                k as String, _\$getInstanceT${count - 1 == 1 ? "" : count - 1}<${genericsName.substring(3)}>(v));
          }) as T1;
        }
  """;

  output.add(part2);
  output.add(builtInPart);

  elements.where((e) => _elementHasGenerics(e)).forEach((e) {
    var part22 = """
        if (typeName == "${e.name}") {
          return _\$${e.name}FromJson${count - 1 == 1 ? "" : count - 1}<${genericsName.substring(3)}>(data) as T1;
        }
      """;
    output.add(part22);
  });
  output.add("return null;");
  output.add("}");
  return output;
}

String _parseValue(String p1, String p2, String p3, String p4, String p6, int count) {
  var genericsName = "";
  if (count == 2) {
    genericsName = "$p2, T2";
  } else if (count == 3) {
    genericsName = "$p2, T2, T3";
  } else if (count == 4) {
    genericsName = "$p2, T2, T3, T4";
  }

  return "$p1<$p2> _\$${p1}FromJson$count<$genericsName>$p3${p4}parseMap$count<$genericsName>$p6}";
}
