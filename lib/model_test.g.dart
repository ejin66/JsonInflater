// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_test.dart';

// **************************************************************************
// JsonInflaterGenerator
// **************************************************************************

T parse<T>(dynamic data) {
  return _$getInstanceT<T>(data);
}

T2 parse2<T2, T1>(dynamic data) {
  return _$getInstanceT2<T2, T1>(data);
}

T3 parse3<T3, T2, T1>(dynamic data) {
  return _$getInstanceT3<T3, T2, T1>(data);
}

T4 parse4<T4, T3, T2, T1>(dynamic data) {
  return _$getInstanceT4<T4, T3, T2, T1>(data);
}

T5 parse5<T5, T4, T3, T2, T1>(dynamic data) {
  return _$getInstanceT5<T5, T4, T3, T2, T1>(data);
}

T _$getInstanceT<T>(dynamic data) {
  final typeName = T.toString();
  if (isBuiltInType(typeName) || isDynamicType(typeName)) {
    return data as T;
  }

  if (typeName == "TestNonGenerics") {
    return _$TestNonGenericsFromJson(data) as T;
  }

  return null;
}

T1 _$getInstanceT2<T1, T2>(dynamic data) {
  final typeName = getMainType(T1.toString());

  if (typeName == "List") {
    return (data as List).map((t) {
      return _$getInstanceT<T2>(t);
    }).toList() as T1;
  }

  if (typeName == "Map") {
    return (data as Map).map((k, v) {
      return MapEntry<String, T2>(k as String, _$getInstanceT<T2>(v));
    }) as T1;
  }

  if (typeName == "TestGenerics1") {
    return _$TestGenerics1FromJson<T2>(data) as T1;
  }

  if (typeName == "TestGenerics2") {
    return _$TestGenerics2FromJson<T2>(data) as T1;
  }

  return null;
}

T1 _$getInstanceT3<T1, T2, T3>(dynamic data) {
  final typeName = getMainType(T1.toString());

  if (typeName == "List") {
    return (data as List).map((t) {
      return _$getInstanceT2<T2, T3>(t);
    }).toList() as T1;
  }

  if (typeName == "Map") {
    return (data as Map).map((k, v) {
      return MapEntry<String, T2>(k as String, _$getInstanceT2<T2, T3>(v));
    }) as T1;
  }

  if (typeName == "TestGenerics1") {
    return _$TestGenerics1FromJson2<T2, T3>(data) as T1;
  }

  if (typeName == "TestGenerics2") {
    return _$TestGenerics2FromJson2<T2, T3>(data) as T1;
  }

  return null;
}

T1 _$getInstanceT4<T1, T2, T3, T4>(dynamic data) {
  final typeName = getMainType(T1.toString());

  if (typeName == "List") {
    return (data as List).map((t) {
      return _$getInstanceT3<T2, T3, T4>(t);
    }).toList() as T1;
  }

  if (typeName == "Map") {
    return (data as Map).map((k, v) {
      return MapEntry<String, T2>(k as String, _$getInstanceT3<T2, T3, T4>(v));
    }) as T1;
  }

  if (typeName == "TestGenerics1") {
    return _$TestGenerics1FromJson3<T2, T3, T4>(data) as T1;
  }

  if (typeName == "TestGenerics2") {
    return _$TestGenerics2FromJson3<T2, T3, T4>(data) as T1;
  }

  return null;
}

T1 _$getInstanceT5<T1, T2, T3, T4, T5>(dynamic data) {
  final typeName = getMainType(T1.toString());

  if (typeName == "List") {
    return (data as List).map((t) {
      return _$getInstanceT4<T2, T3, T4, T5>(t);
    }).toList() as T1;
  }

  if (typeName == "Map") {
    return (data as Map).map((k, v) {
      return MapEntry<String, T2>(
          k as String, _$getInstanceT4<T2, T3, T4, T5>(v));
    }) as T1;
  }

  if (typeName == "TestGenerics1") {
    return _$TestGenerics1FromJson4<T2, T3, T4, T5>(data) as T1;
  }

  if (typeName == "TestGenerics2") {
    return _$TestGenerics2FromJson4<T2, T3, T4, T5>(data) as T1;
  }

  return null;
}

TestNonGenerics _$TestNonGenericsFromJson(Map<String, dynamic> json) {
  return TestNonGenerics(json['msg'] as String);
}

Map<String, dynamic> _$TestNonGenericsToJson(TestNonGenerics instance) =>
    <String, dynamic>{'msg': instance.msg};

mixin PartOfTestNonGenerics {
  static TestNonGenerics parse(Map<String, dynamic> map) {
    return _$TestNonGenericsFromJson(map);
  }

  Map<String, dynamic> toJson() => _$TestNonGenericsToJson(this);
}

TestGenerics1<K> _$TestGenerics1FromJson<K>(Map<String, dynamic> json) {
  return TestGenerics1<K>(json['msg'] as String, parse<K>(json['data']));
}

Map<String, dynamic> _$TestGenerics1ToJson<K>(TestGenerics1<K> instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': toMap(instance.data)};

mixin PartOfTestGenerics1 {
  static TestGenerics1<K> parse<K>(Map<String, dynamic> map) {
    return _$TestGenerics1FromJson<K>(map);
  }

  Map<String, dynamic> toJson() => _$TestGenerics1ToJson(this);
}

TestGenerics2<K> _$TestGenerics2FromJson<K>(Map<String, dynamic> json) {
  return TestGenerics2<K>(json['msg'] as String, parse<K>(json['data']));
}

Map<String, dynamic> _$TestGenerics2ToJson<K>(TestGenerics2<K> instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': toMap(instance.data)};

mixin PartOfTestGenerics2 {
  static TestGenerics2<K> parse<K>(Map<String, dynamic> map) {
    return _$TestGenerics2FromJson<K>(map);
  }

  Map<String, dynamic> toJson() => _$TestGenerics2ToJson(this);
}
TestGenerics1<K> _$TestGenerics1FromJson2<K, T2>(Map<String, dynamic> json) {
  return TestGenerics1<K>(json['msg'] as String, parse2<K, T2>(json['data']));
}

TestGenerics1<K> _$TestGenerics1FromJson3<K, T2, T3>(
    Map<String, dynamic> json) {
  return TestGenerics1<K>(
      json['msg'] as String, parse3<K, T2, T3>(json['data']));
}

TestGenerics1<K> _$TestGenerics1FromJson4<K, T2, T3, T4>(
    Map<String, dynamic> json) {
  return TestGenerics1<K>(
      json['msg'] as String, parse4<K, T2, T3, T4>(json['data']));
}

TestGenerics2<K> _$TestGenerics2FromJson2<K, T2>(Map<String, dynamic> json) {
  return TestGenerics2<K>(json['msg'] as String, parse2<K, T2>(json['data']));
}

TestGenerics2<K> _$TestGenerics2FromJson3<K, T2, T3>(
    Map<String, dynamic> json) {
  return TestGenerics2<K>(
      json['msg'] as String, parse3<K, T2, T3>(json['data']));
}

TestGenerics2<K> _$TestGenerics2FromJson4<K, T2, T3, T4>(
    Map<String, dynamic> json) {
  return TestGenerics2<K>(
      json['msg'] as String, parse4<K, T2, T3, T4>(json['data']));
}
