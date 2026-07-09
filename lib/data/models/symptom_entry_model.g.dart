// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SymptomEntryModel _$SymptomEntryModelFromJson(Map<String, dynamic> json) =>
    _SymptomEntryModel(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      symptomId: (json['symptomId'] as num).toInt(),
      symptom: json['symptom'] == null
          ? null
          : SymptomModel.fromJson(json['symptom'] as Map<String, dynamic>),
      severity: $enumDecode(_$SymptomSeverityEnumMap, json['severity']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SymptomEntryModelToJson(_SymptomEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'symptomId': instance.symptomId,
      'symptom': instance.symptom,
      'severity': _$SymptomSeverityEnumMap[instance.severity]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$SymptomSeverityEnumMap = {
  SymptomSeverity.mild: 'mild',
  SymptomSeverity.moderate: 'moderate',
  SymptomSeverity.severe: 'severe',
};
