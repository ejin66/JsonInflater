import 'package:jsoninflater/jsonInflater.dart';

part 'model_1.g.dart';

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