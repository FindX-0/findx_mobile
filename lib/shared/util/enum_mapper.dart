import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

abstract base class EnumMapper<DTO, ENUM> {
  @protected
  abstract Map<DTO, ENUM> values;

  DTO? enumToDto(ENUM? model) {
    return values.keys.firstWhereOrNull((DTO e) => values[e] == model);
  }

  ENUM? dtoToEnum(DTO? l) {
    return values[l];
  }
}
