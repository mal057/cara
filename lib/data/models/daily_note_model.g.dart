// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyNoteModel _$DailyNoteModelFromJson(Map<String, dynamic> json) =>
    _DailyNoteModel(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DailyNoteModelToJson(_DailyNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
