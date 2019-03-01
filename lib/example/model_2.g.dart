// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_2.dart';

// **************************************************************************
// JsonInflaterGenerator
// **************************************************************************

T parseMap<T>(dynamic data) {
  return _$getInstanceT<T>(data);
}

T2 parseMap2<T2, T1>(dynamic data) {
  return _$getInstanceT2<T2, T1>(data);
}

T3 parseMap3<T3, T2, T1>(dynamic data) {
  return _$getInstanceT3<T3, T2, T1>(data);
}

T4 parseMap4<T4, T3, T2, T1>(dynamic data) {
  return _$getInstanceT4<T4, T3, T2, T1>(data);
}

T5 parseMap5<T5, T4, T3, T2, T1>(dynamic data) {
  return _$getInstanceT5<T5, T4, T3, T2, T1>(data);
}

T _$getInstanceT<T>(dynamic data) {
  final typeName = T.toString();
  if (isBuiltInType(typeName) || isDynamicType(typeName)) {
    return data as T;
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

  if (typeName == "ModelGenerics1") {
    return _$ModelGenerics1FromJson<T2>(data) as T1;
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

  if (typeName == "ModelGenerics1") {
    return _$ModelGenerics1FromJson2<T2, T3>(data) as T1;
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

  if (typeName == "ModelGenerics1") {
    return _$ModelGenerics1FromJson3<T2, T3, T4>(data) as T1;
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

  if (typeName == "ModelGenerics1") {
    return _$ModelGenerics1FromJson4<T2, T3, T4, T5>(data) as T1;
  }

  return null;
}

ModelGenerics1<K> _$ModelGenerics1FromJson<K>(Map<String, dynamic> json) {
  return ModelGenerics1<K>(json['msg'] as String, parseMap<K>(json['data']));
}

Map<String, dynamic> _$ModelGenerics1ToJson<K>(ModelGenerics1<K> instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': toMap(instance.data)};

mixin PartOfModelGenerics1 {
  static ModelGenerics1<K> parse<K>(Map<String, dynamic> map) {
    return _$ModelGenerics1FromJson<K>(map);
  }

  Map<String, dynamic> toJson() => _$ModelGenerics1ToJson(this);
}
ModelGenerics1<K> _$ModelGenerics1FromJson2<K, T2>(Map<String, dynamic> json) {
  return ModelGenerics1<K>(
      json['msg'] as String, parseMap2<K, T2>(json['data']));
}

ModelGenerics1<K> _$ModelGenerics1FromJson3<K, T2, T3>(
    Map<String, dynamic> json) {
  return ModelGenerics1<K>(
      json['msg'] as String, parseMap3<K, T2, T3>(json['data']));
}

ModelGenerics1<K> _$ModelGenerics1FromJson4<K, T2, T3, T4>(
    Map<String, dynamic> json) {
  return ModelGenerics1<K>(
      json['msg'] as String, parseMap4<K, T2, T3, T4>(json['data']));
}
