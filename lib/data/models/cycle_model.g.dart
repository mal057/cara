// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CycleModel _$CycleModelFromJson(Map<String, dynamic> json) => _CycleModel(
      id: (json['id'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      cycleLength: (json['cycleLength'] as num?)?.toInt(),
      periodLength: (json['periodLength'] as num?)?.toInt(),
      isPredicted: json['isPredicted'] as bool? ?? false,
      periodLogs: (json['periodLogs'] as List<dynamic>?)
              ?.map((e) => PeriodLogModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPhase:
          $enumDecodeNullable(_$CyclePhaseEnumMap, json['currentPhase']),
      cycleDay: (json['cycleDay'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CycleModelToJson(_CycleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'cycleLength': instance.cycleLength,
      'periodLength': instance.periodLength,
      'isPredicted': instance.isPredicted,
      'periodLogs': instance.periodLogs,
      'currentPhase': _$CyclePhaseEnumMap[instance.currentPhase],
      'cycleDay': instance.cycleDay,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$CyclePhaseEnumMap = {
  CyclePhase.menstrual: 'menstrual',
  CyclePhase.follicular: 'follicular',
  CyclePhase.ovulatory: 'ovulatory',
  CyclePhase.luteal: 'luteal',
};
