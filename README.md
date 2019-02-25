# JsonInflater
### 详细介绍： 
[Flutter中Json序列化之--支持泛型](https://ejin66.github.io/2019/02/25/flutter-json-serialize-generics.html)
<br/>

### 如何使用

1. 创建模型，添加注解`JsonFlater`以及`mixin`类。如：

   ```dart
   @JsonInflater()
   class JsonTest with PartOfJsonTest {
   
     String msg;
   
     JsonTest(this.msg);
   
     @override
     String toString() {
       return 'JsonTest{msg: $msg}';
     }
   }
   
   @JsonInflater()
   class JsonTest2<K> with PartOfJsonTest2 {

     String msg;
     K data;

     JsonTest2(this.msg, this.data);

     @override
     String toString() {
       return 'JsonTest2{msg: $msg, data: $data}';
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

   - `parse<T>()`。本框架提供的一个将Map转换成模型的方法。

     ```dart
     var test = JsonTest("json test");
     var parseTest = parse<JsonTest>(test.toJson());
     print("$parseTest"); // -> JsonTest{msg: json test}
     ```

   - `PartOf${className}<T>.parse()`。本框架提供的另外一个将Map转换成模型的方法。

     ```dart
     var parseTest4 = PartOfJsonTest.parse(test.toJson());
     print("$parseTest4"); // -> JsonTest{msg: json test}
     ```

   - `parse<T>()` 与 `PartOf${className}<T>.parse()`的差别：

     - 前置支持泛型嵌套，后者不支持。

     - `parse<T>()`虽然支持泛型嵌套，但最后返回的类型与实际泛型有差异：

       ```dart
       main() {
       
         var test = JsonTest("json test");
       
         var test2 = JsonTest2("json test 2", [test]);
       
         var parseTest2 = parse<JsonTest2<List<JsonTest>>>(test2.toJson());
       
         print("$parseTest2, ${parseTest2.runtimeType}");
         // -> JsonTest2{msg: json test 2, data: [JsonTest{msg: json test}]}, JsonTest2<dynamic>
           
         //不支持嵌套泛型，否则报错。
         var parseTest3 = PartOfJsonTest2.parse<List>(test2.toJson());
          // -> JsonTest2{msg: json test 2, data: [{msg: json test}]}, JsonTest2<List<dynamic>>
       
         print("$parseTest3, ${parseTest3.runtimeType}");
           
           
         print(parseTest2 is JsonTest2);  // -> true
         print((parseTest2 as JsonTest2).data is List); // -> true
         print(((parseTest2 as JsonTest2).data as List).first is JsonTest); // -> true
       }
       ```

       虽然`parse<JsonTest2<List<JsonTest>>>()`的结果是`JsonTest2<dynamic>`， 与泛型不一致，但本质是按照泛型解析的，其`runtimeType`是一致的。

<br/>
