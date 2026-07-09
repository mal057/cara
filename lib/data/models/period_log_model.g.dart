// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PeriodLogModel _$PeriodLogModelFromJson(Map<String, dynamic> json) =>
    _PeriodLogModel(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      cycleId: (json['cycleId'] as num?)?.toInt(),
      flowIntensity: $enumDecode(_$FlowIntensityEnumMap, json['flowIntensity']),
      flowColor: $enumDecodeNullable(_$FlowColorEnumMap, json['flowColor']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PeriodLogModelToJson(_PeriodLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'cycleId': instance.cycleId,
      'flowIntensity': _$FlowIntensityEnumMap[instance.flowIntensity]!,
      'flowColor': _$FlowColorEnumMap[instance.flowColor],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$FlowIntensityEnumMap = {
  FlowIntensity.light: 'light',
  FlowIntensity.medium: 'medium',
  FlowIntensity.heavy: 'heavy',
};

const _$FlowColorEnumMap = {
  FlowColor.red: 'red',
  FlowColor.darkRed: 'darkRed',
  FlowColor.brown: 'brown',
  FlowColor.pink: 'pink',
};
