// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DayDataModel _$DayDataModelFromJson(Map<String, dynamic> json) =>
    _DayDataModel(
      date: DateTime.parse(json['date'] as String),
      periodLog: json['periodLog'] == null
          ? null
          : PeriodLogModel.fromJson(json['periodLog'] as Map<String, dynamic>),
      symptomEntries: (json['symptomEntries'] as List<dynamic>?)
              ?.map(
                  (e) => SymptomEntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      dailyNote: json['dailyNote'] == null
          ? null
          : DailyNoteModel.fromJson(json['dailyNote'] as Map<String, dynamic>),
      phase: $enumDecodeNullable(_$CyclePhaseEnumMap, json['phase']),
      isPredicted: json['isPredicted'] as bool? ?? false,
      cycleDay: (json['cycleDay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DayDataModelToJson(_DayDataModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'periodLog': instance.periodLog,
      'symptomEntries': instance.symptomEntries,
      'dailyNote': instance.dailyNote,
      'phase': _$CyclePhaseEnumMap[instance.phase],
      'isPredicted': instance.isPredicted,
      'cycleDay': instance.cycleDay,
    };

const _$CyclePhaseEnumMap = {
  CyclePhase.menstrual: 'menstrual',
  CyclePhase.follicular: 'follicular',
  CyclePhase.ovulatory: 'ovulatory',
  CyclePhase.luteal: 'luteal',
};
