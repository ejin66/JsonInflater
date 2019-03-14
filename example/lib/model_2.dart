import 'package:jsoninflater/jsonInflater.dart';

part 'model_2.g.dart';


@JsonInflater()
class ModelGenerics1<K> with PartOfModelGenerics1 {

  String msg;
  K data;

  ModelGenerics1(this.msg, this.data);

  @override
  String toString() {
    return 'ModelGenerics1{msg: $msg, data: $data}';
  }
}