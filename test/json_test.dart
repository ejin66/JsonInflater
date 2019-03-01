import 'package:jsoninflater/example/jsonUtil.internal.dart';
import 'package:jsoninflater/example/model_1.dart';
import 'package:jsoninflater/example/model_2.dart';


main() {
  var nonGenericsModel = TestNonGenerics("non generics");
  var nonGenericsParse = parse<TestNonGenerics>(nonGenericsModel.toJson());
  print("$nonGenericsParse, ${nonGenericsParse.runtimeType}"); // -> TestNonGenerics{msg: non generics}, TestNonGenerics


  var genericsModel1 = TestGenerics1<String>("generics model 1", "");
  var genericsModel1Parse = parse2<TestGenerics1<String>, String>(genericsModel1.toJson());
  print("$genericsModel1Parse, ${genericsModel1Parse.runtimeType}"); // -> TestGenerics1{msg: generics model 1, data: TestNonGenerics{msg: non generics}}, TestGenerics1<TestNonGenerics>


  var genericsModel2 = TestGenerics2<TestGenerics1<List<String>>>("generics model 2", TestGenerics1("generics model 1", ["list 1", "list 2"]));
  var genericsModel2Parse = parse4<TestGenerics2<TestGenerics1<List<String>>>, TestGenerics1<List<String>>, List<String>, String>(genericsModel2.toJson());
  print("$genericsModel2Parse, ${genericsModel2Parse.runtimeType}"); // -> TestGenerics2{msg: generics model 2, data: TestGenerics1{msg: generics model 1, data: [list 1, list 2]}}, TestGenerics2<TestGenerics1<List<String>>>

  var model3 = ModelGenerics1("generics model 3", "");
  var model3Parse = parse2<ModelGenerics1<String>, String>(model3.toJson());
  print("$model3Parse, ${model3Parse.runtimeType}");
}