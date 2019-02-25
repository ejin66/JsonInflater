// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_test.dart';

// **************************************************************************
// JsonInflaterGenerator
// **************************************************************************

dynamic parse<T>(dynamic data, [String typeName]) {
  Type t = T;
  return _$getInstanceT(data, typeName ?? t.toString());
}

_$getInstanceT(dynamic data, String typeName) {
  if (isDynamicType(typeName)) {
    return data;
  }

  if (isBuiltInType(typeName)) {
    if (getMainType(typeName) == "List") {
      return (data as List).map((t) {
        return _$getInstanceT(t, getGenericsType(typeName));
      }).toList();
    }

    if (getMainType(typeName) == "Map") {
      return (data as Map<String, dynamic>).map((k, v) {
        return MapEntry<String, dynamic>(
            k, _$getInstanceT(v, getGenericsType(typeName)));
      });
    }
    return data;
  }

  if (getMainType(typeName) == "JsonTest") {
    return _$JsonTestFromJson(data, getGenericsType(typeName));
  }

  if (getMainType(typeName) == "JsonTest2") {
    return _$JsonTest2FromJson(data, getGenericsType(typeName));
  }

  return null;
}

JsonTest _$JsonTestFromJson(Map<String, dynamic> json, [String typeName]) {
  return JsonTest(json['msg'] as String);
}

Map<String, dynamic> _$JsonTestToJson(JsonTest instance) =>
    <String, dynamic>{'msg': instance.msg};

mixin PartOfJsonTest {
  static JsonTest parse(Map<String, dynamic> map) {
    return _$JsonTestFromJson(map);
  }

  Map<String, dynamic> toJson() => _$JsonTestToJson(this);
}

JsonTest2<K> _$JsonTest2FromJson<K>(Map<String, dynamic> json,
    [String typeName]) {
  return JsonTest2<K>(
      json['msg'] as String, parse<K>(json['data'], typeName ?? K.toString()));
}

Map<String, dynamic> _$JsonTest2ToJson<K>(JsonTest2<K> instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': toMap(instance.data)};

mixin PartOfJsonTest2 {
  static JsonTest2<K> parse<K>(Map<String, dynamic> map) {
    return _$JsonTest2FromJson<K>(map);
  }

  Map<String, dynamic> toJson() => _$JsonTest2ToJson(this);
}
