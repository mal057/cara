// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExportDataModel _$ExportDataModelFromJson(Map<String, dynamic> json) =>
    _ExportDataModel(
      range: $enumDecode(_$ExportRangeEnumMap, json['range']),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      cycles: (json['cycles'] as List<dynamic>?)
              ?.map((e) => CycleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      dailyData: (json['dailyData'] as List<dynamic>?)
              ?.map((e) => DayDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      stats: json['stats'] == null
          ? null
          : CycleStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExportDataModelToJson(_ExportDataModel instance) =>
    <String, dynamic>{
      'range': _$ExportRangeEnumMap[instance.range]!,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'cycles': instance.cycles,
      'dailyData': instance.dailyData,
      'stats': instance.stats,
    };

const _$ExportRangeEnumMap = {
  ExportRange.threeMonths: 'threeMonths',
  ExportRange.sixMonths: 'sixMonths',
  ExportRange.oneYear: 'oneYear',
  ExportRange.allTime: 'allTime',
};
