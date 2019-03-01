import 'package:build/build.dart';
import 'package:jsoninflater/jsonInflater.dart';
import 'package:source_gen/source_gen.dart';

class JsonGather {
  const JsonGather();
}

Builder jsonGatherBuilder(BuilderOptions options) =>
    LibraryBuilder(JsonGatherGenerator(), generatedExtension: ".internal.dart");

class JsonGatherGenerator extends Generator {
  TypeChecker jsonGatherChecker = TypeChecker.fromRuntime(JsonGather);

  @override
  generate(LibraryReader library, BuildStep buildStep) {
    print("JsonGatherGenerator generate");

    var elementList = library.annotatedWith(jsonGatherChecker);

    if (elementList.length == 0) {
      return null;
    }



    var output = <String>[];

    int index = 0;
    JsonInflaterGenerator.cacheInfoList.forEach((e) {
      output.add(e.getImportString(++index));
    });

    output.addAll(generateParseFunctions());

    return output.join("\n");
  }

  List<String> generateParseFunctions() {
    var output = <String>[];
    var output1 = <String>["T parse<T>(dynamic data) { return "];
    var output2 = <String>["T1 parse2<T1, T2>(dynamic data) { return "];
    var output3 = <String>["T1 parse3<T1, T2, T3>(dynamic data) { return "];
    var output4 = <String>["T1 parse4<T1, T2, T3, T4>(dynamic data) { return "];
    var output5 = <String>["T1 parse5<T1, T2, T3, T4, T5>(dynamic data) { return "];

    for (int i = 1; i <= JsonInflaterGenerator.cacheInfoList.length; i++) {
      output1.add("part$i.parseMap<T>(data)");
      if (i == JsonInflaterGenerator.cacheInfoList.length) {
        output1.add(";");
      } else {
        output1.add(" ?? ");
      }

      output2.add("part$i.parseMap2<T1, T2>(data)");
      if (i == JsonInflaterGenerator.cacheInfoList.length) {
        output2.add(";");
      } else {
        output2.add(" ?? ");
      }

      output3.add("part$i.parseMap3<T1, T2, T3>(data)");
      if (i == JsonInflaterGenerator.cacheInfoList.length) {
        output3.add(";");
      } else {
        output3.add(" ?? ");
      }

      output4.add("part$i.parseMap4<T1, T2, T3, T4>(data)");
      if (i == JsonInflaterGenerator.cacheInfoList.length) {
        output4.add(";");
      } else {
        output4.add(" ?? ");
      }

      output5.add("part$i.parseMap5<T1, T2, T3, T4, T5>(data)");
      if (i == JsonInflaterGenerator.cacheInfoList.length) {
        output5.add(";");
      } else {
        output5.add(" ?? ");
      }
    }
    output1.add("}");
    output2.add("}");
    output3.add("}");
    output4.add("}");
    output5.add("}");

    return output
      ..addAll(output1)
      ..addAll(output2)
      ..addAll(output3)
      ..addAll(output4)
      ..addAll(output5);

  }
}
