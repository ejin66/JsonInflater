# JsonInflater
### 详细介绍： 
[Flutter中Json序列化之--支持泛型](https://ejin66.github.io/2019/02/25/flutter-json-serialize-generics.html)
<br/>

### 如何使用

1. 创建模型，添加注解`JsonFlater`以及`mixin`类。如：

   ```dart
   @JsonInflater()
   class TestNonGenerics with PartOfTestNonGenerics {
   
     String msg;
   
     TestNonGenerics(this.msg);
   
     @override
     String toString() {
       return 'TestNonGenerics{msg: $msg}';
     }
   }
   
   @JsonInflater()
   class TestGenerics1<K> with PartOfTestGenerics1 {
   
     String msg;
     K data;
   
     TestGenerics1(this.msg, this.data);
   
     @override
     String toString() {
       return 'TestGenerics1{msg: $msg, data: $data}';
     }
   }
   
   @JsonInflater()
   class TestGenerics2<K> with PartOfTestGenerics2 {
   
     String msg;
     K data;
   
     TestGenerics2(this.msg, this.data);
   
   
     @override
     String toString() {
       return 'TestGenerics2{msg: $msg, data: $data}';
     }
   }
   ```

   > `mixin`类是代码生成的，格式是：PartOf${className}。功能是提供`toJson()`、`parse()`方法。

2. 运行命令，生成代码：

   ```bash
   flutter packages pub run build_runner build
   ```

3. 使用：

   - `toJson`.

     ```dart
     var test = JsonTest("json test");
     print(test.toJson()); // -> {msg: json test}
     ```

   - `parse<T>()`。本框架提供的一个将Map转换成模型的方法。提供5种不同泛型数量的方法：

     - `parse<T>`
     - `parse2<T1, T2>`
     - `parse3<T1, T2, T3>`
     - `parse4<T1, T2, T3, T4>`
     - `parse5<T1, T2, T3, T4, T5>`

     比较特殊的是，泛型需要按照如下规则：后一个泛型必须是前面泛型的泛型。如：

     ```dart
     T1 : List<Model<String>>
     T2 : Model<String>
     T3 : String
     ```

     用这样的方式解决泛型嵌套的问题。

     例子：

     ```dart
     var genericsModel1 = TestGenerics1<TestNonGenerics>("generics model 1", nonGenericsModel);
       var genericsModel1Parse = parse2<TestGenerics1<TestNonGenerics>, TestNonGenerics>(genericsModel1.toJson());
       print("$genericsModel1Parse, ${genericsModel1Parse.runtimeType}"); // -> TestGenerics1{msg: generics model 1, data: TestNonGenerics{msg: non generics}}, TestGenerics1<TestNonGenerics>
     ```

   - `PartOf${className}<T>.parse()`。本框架提供的另外一个将Map转换成模型的方法。

     ```dart
     var parseTest4 = PartOfJsonTest.parse(test.toJson());
     print("$parseTest4"); // -> JsonTest{msg: json test}
     ```

   - `parse<T>()` 与 `PartOf${className}<T>.parse()`的差别：前者支持泛型嵌套，后者不支持。

<br/>
