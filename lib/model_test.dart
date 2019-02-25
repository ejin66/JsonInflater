import 'package:jsoninflater/jsonInflater.dart';

part 'model_test.g.dart';

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