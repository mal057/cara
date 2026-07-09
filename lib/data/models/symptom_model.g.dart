// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SymptomModel _$SymptomModelFromJson(Map<String, dynamic> json) =>
    _SymptomModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: $enumDecode(_$SymptomCategoryEnumMap, json['category']),
      iconName: json['iconName'] as String,
      emoji: json['emoji'] as String?,
      displayOrder: (json['displayOrder'] as num).toInt(),
    );

Map<String, dynamic> _$SymptomModelToJson(_SymptomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$SymptomCategoryEnumMap[instance.category]!,
      'iconName': instance.iconName,
      'emoji': instance.emoji,
      'displayOrder': instance.displayOrder,
    };

const _$SymptomCategoryEnumMap = {
  SymptomCategory.mood: 'mood',
  SymptomCategory.pain: 'pain',
  SymptomCategory.energy: 'energy',
  SymptomCategory.skin: 'skin',
  SymptomCategory.digestion: 'digestion',
  SymptomCategory.sleep: 'sleep',
  SymptomCategory.other: 'other',
};
