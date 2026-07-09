// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CycleStatsModel _$CycleStatsModelFromJson(Map<String, dynamic> json) =>
    _CycleStatsModel(
      avgCycleLength: (json['avgCycleLength'] as num).toDouble(),
      avgPeriodLength: (json['avgPeriodLength'] as num).toDouble(),
      minCycleLength: (json['minCycleLength'] as num).toInt(),
      maxCycleLength: (json['maxCycleLength'] as num).toInt(),
      totalCycles: (json['totalCycles'] as num).toInt(),
      isIrregular: json['isIrregular'] as bool? ?? false,
    );

Map<String, dynamic> _$CycleStatsModelToJson(_CycleStatsModel instance) =>
    <String, dynamic>{
      'avgCycleLength': instance.avgCycleLength,
      'avgPeriodLength': instance.avgPeriodLength,
      'minCycleLength': instance.minCycleLength,
      'maxCycleLength': instance.maxCycleLength,
      'totalCycles': instance.totalCycles,
      'isIrregular': instance.isIrregular,
    };
