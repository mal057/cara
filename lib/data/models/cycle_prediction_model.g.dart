// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CyclePredictionModel _$CyclePredictionModelFromJson(
        Map<String, dynamic> json) =>
    _CyclePredictionModel(
      predictedStart: DateTime.parse(json['predictedStart'] as String),
      predictedEnd: DateTime.parse(json['predictedEnd'] as String),
      fertileWindowStart: DateTime.parse(json['fertileWindowStart'] as String),
      fertileWindowEnd: DateTime.parse(json['fertileWindowEnd'] as String),
      confidence: (json['confidence'] as num).toDouble(),
      isIrregular: json['isIrregular'] as bool? ?? false,
    );

Map<String, dynamic> _$CyclePredictionModelToJson(
        _CyclePredictionModel instance) =>
    <String, dynamic>{
      'predictedStart': instance.predictedStart.toIso8601String(),
      'predictedEnd': instance.predictedEnd.toIso8601String(),
      'fertileWindowStart': instance.fertileWindowStart.toIso8601String(),
      'fertileWindowEnd': instance.fertileWindowEnd.toIso8601String(),
      'confidence': instance.confidence,
      'isIrregular': instance.isIrregular,
    };
