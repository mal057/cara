// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SymptomModel {
  /// Database row ID from symptoms table. Stable identifier.
  int get id;

  /// Human-readable symptom name (e.g. 'headache'). Unique.
  String get name;

  /// Category group for this symptom.
  SymptomCategory get category;

  /// Flutter icon identifier string (e.g. 'Icons.mood').
  String get iconName;

  /// Optional emoji string for mood symptoms. Null for non-mood symptoms.
  String? get emoji;

  /// Sort order for display in the symptom grid.
  int get displayOrder;

  /// Create a copy of SymptomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SymptomModelCopyWith<SymptomModel> get copyWith =>
      _$SymptomModelCopyWithImpl<SymptomModel>(
          this as SymptomModel, _$identity);

  /// Serializes this SymptomModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SymptomModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, category, iconName, emoji, displayOrder);

  @override
  String toString() {
    return 'SymptomModel(id: $id, name: $name, category: $category, iconName: $iconName, emoji: $emoji, displayOrder: $displayOrder)';
  }
}

/// @nodoc
abstract mixin class $SymptomModelCopyWith<$Res> {
  factory $SymptomModelCopyWith(
          SymptomModel value, $Res Function(SymptomModel) _then) =
      _$SymptomModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      SymptomCategory category,
      String iconName,
      String? emoji,
      int displayOrder});
}

/// @nodoc
class _$SymptomModelCopyWithImpl<$Res> implements $SymptomModelCopyWith<$Res> {
  _$SymptomModelCopyWithImpl(this._self, this._then);

  final SymptomModel _self;
  final $Res Function(SymptomModel) _then;

  /// Create a copy of SymptomModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? iconName = null,
    Object? emoji = freezed,
    Object? displayOrder = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as SymptomCategory,
      iconName: null == iconName
          ? _self.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: freezed == emoji
          ? _self.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      displayOrder: null == displayOrder
          ? _self.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SymptomModel].
extension SymptomModelPatterns on SymptomModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SymptomModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SymptomModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SymptomModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SymptomModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String name, SymptomCategory category,
            String iconName, String? emoji, int displayOrder)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SymptomModel() when $default != null:
        return $default(_that.id, _that.name, _that.category, _that.iconName,
            _that.emoji, _that.displayOrder);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String name, SymptomCategory category,
            String iconName, String? emoji, int displayOrder)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomModel():
        return $default(_that.id, _that.name, _that.category, _that.iconName,
            _that.emoji, _that.displayOrder);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String name, SymptomCategory category,
            String iconName, String? emoji, int displayOrder)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomModel() when $default != null:
        return $default(_that.id, _that.name, _that.category, _that.iconName,
            _that.emoji, _that.displayOrder);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SymptomModel implements SymptomModel {
  const _SymptomModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.iconName,
      this.emoji,
      required this.displayOrder});
  factory _SymptomModel.fromJson(Map<String, dynamic> json) =>
      _$SymptomModelFromJson(json);

  /// Database row ID from symptoms table. Stable identifier.
  @override
  final int id;

  /// Human-readable symptom name (e.g. 'headache'). Unique.
  @override
  final String name;

  /// Category group for this symptom.
  @override
  final SymptomCategory category;

  /// Flutter icon identifier string (e.g. 'Icons.mood').
  @override
  final String iconName;

  /// Optional emoji string for mood symptoms. Null for non-mood symptoms.
  @override
  final String? emoji;

  /// Sort order for display in the symptom grid.
  @override
  final int displayOrder;

  /// Create a copy of SymptomModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SymptomModelCopyWith<_SymptomModel> get copyWith =>
      __$SymptomModelCopyWithImpl<_SymptomModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SymptomModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SymptomModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, category, iconName, emoji, displayOrder);

  @override
  String toString() {
    return 'SymptomModel(id: $id, name: $name, category: $category, iconName: $iconName, emoji: $emoji, displayOrder: $displayOrder)';
  }
}

/// @nodoc
abstract mixin class _$SymptomModelCopyWith<$Res>
    implements $SymptomModelCopyWith<$Res> {
  factory _$SymptomModelCopyWith(
          _SymptomModel value, $Res Function(_SymptomModel) _then) =
      __$SymptomModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      SymptomCategory category,
      String iconName,
      String? emoji,
      int displayOrder});
}

/// @nodoc
class __$SymptomModelCopyWithImpl<$Res>
    implements _$SymptomModelCopyWith<$Res> {
  __$SymptomModelCopyWithImpl(this._self, this._then);

  final _SymptomModel _self;
  final $Res Function(_SymptomModel) _then;

  /// Create a copy of SymptomModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? iconName = null,
    Object? emoji = freezed,
    Object? displayOrder = null,
  }) {
    return _then(_SymptomModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as SymptomCategory,
      iconName: null == iconName
          ? _self.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: freezed == emoji
          ? _self.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      displayOrder: null == displayOrder
          ? _self.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
