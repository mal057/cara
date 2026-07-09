// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SymptomEntryModel {
  /// Database row ID from symptom_entries table.
  int get id;

  /// The calendar date this entry covers.
  DateTime get date;

  /// Foreign key to the symptom definition.
  int get symptomId;

  /// Resolved symptom definition. Null if not yet joined (bare DB row).
  SymptomModel? get symptom;

  /// Severity of this symptom on this date.
  SymptomSeverity get severity;

  /// When this row was first inserted.
  DateTime get createdAt;

  /// Create a copy of SymptomEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SymptomEntryModelCopyWith<SymptomEntryModel> get copyWith =>
      _$SymptomEntryModelCopyWithImpl<SymptomEntryModel>(
          this as SymptomEntryModel, _$identity);

  /// Serializes this SymptomEntryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SymptomEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId) &&
            (identical(other.symptom, symptom) || other.symptom == symptom) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, symptomId, symptom, severity, createdAt);

  @override
  String toString() {
    return 'SymptomEntryModel(id: $id, date: $date, symptomId: $symptomId, symptom: $symptom, severity: $severity, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $SymptomEntryModelCopyWith<$Res> {
  factory $SymptomEntryModelCopyWith(
          SymptomEntryModel value, $Res Function(SymptomEntryModel) _then) =
      _$SymptomEntryModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime date,
      int symptomId,
      SymptomModel? symptom,
      SymptomSeverity severity,
      DateTime createdAt});

  $SymptomModelCopyWith<$Res>? get symptom;
}

/// @nodoc
class _$SymptomEntryModelCopyWithImpl<$Res>
    implements $SymptomEntryModelCopyWith<$Res> {
  _$SymptomEntryModelCopyWithImpl(this._self, this._then);

  final SymptomEntryModel _self;
  final $Res Function(SymptomEntryModel) _then;

  /// Create a copy of SymptomEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? symptomId = null,
    Object? symptom = freezed,
    Object? severity = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      symptomId: null == symptomId
          ? _self.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as int,
      symptom: freezed == symptom
          ? _self.symptom
          : symptom // ignore: cast_nullable_to_non_nullable
              as SymptomModel?,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as SymptomSeverity,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of SymptomEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SymptomModelCopyWith<$Res>? get symptom {
    if (_self.symptom == null) {
      return null;
    }

    return $SymptomModelCopyWith<$Res>(_self.symptom!, (value) {
      return _then(_self.copyWith(symptom: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SymptomEntryModel].
extension SymptomEntryModelPatterns on SymptomEntryModel {
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
    TResult Function(_SymptomEntryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SymptomEntryModel() when $default != null:
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
    TResult Function(_SymptomEntryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomEntryModel():
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
    TResult? Function(_SymptomEntryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomEntryModel() when $default != null:
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
    TResult Function(
            int id,
            DateTime date,
            int symptomId,
            SymptomModel? symptom,
            SymptomSeverity severity,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SymptomEntryModel() when $default != null:
        return $default(_that.id, _that.date, _that.symptomId, _that.symptom,
            _that.severity, _that.createdAt);
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
    TResult Function(int id, DateTime date, int symptomId,
            SymptomModel? symptom, SymptomSeverity severity, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomEntryModel():
        return $default(_that.id, _that.date, _that.symptomId, _that.symptom,
            _that.severity, _that.createdAt);
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
    TResult? Function(
            int id,
            DateTime date,
            int symptomId,
            SymptomModel? symptom,
            SymptomSeverity severity,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomEntryModel() when $default != null:
        return $default(_that.id, _that.date, _that.symptomId, _that.symptom,
            _that.severity, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SymptomEntryModel implements SymptomEntryModel {
  const _SymptomEntryModel(
      {required this.id,
      required this.date,
      required this.symptomId,
      this.symptom,
      required this.severity,
      required this.createdAt});
  factory _SymptomEntryModel.fromJson(Map<String, dynamic> json) =>
      _$SymptomEntryModelFromJson(json);

  /// Database row ID from symptom_entries table.
  @override
  final int id;

  /// The calendar date this entry covers.
  @override
  final DateTime date;

  /// Foreign key to the symptom definition.
  @override
  final int symptomId;

  /// Resolved symptom definition. Null if not yet joined (bare DB row).
  @override
  final SymptomModel? symptom;

  /// Severity of this symptom on this date.
  @override
  final SymptomSeverity severity;

  /// When this row was first inserted.
  @override
  final DateTime createdAt;

  /// Create a copy of SymptomEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SymptomEntryModelCopyWith<_SymptomEntryModel> get copyWith =>
      __$SymptomEntryModelCopyWithImpl<_SymptomEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SymptomEntryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SymptomEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId) &&
            (identical(other.symptom, symptom) || other.symptom == symptom) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, symptomId, symptom, severity, createdAt);

  @override
  String toString() {
    return 'SymptomEntryModel(id: $id, date: $date, symptomId: $symptomId, symptom: $symptom, severity: $severity, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$SymptomEntryModelCopyWith<$Res>
    implements $SymptomEntryModelCopyWith<$Res> {
  factory _$SymptomEntryModelCopyWith(
          _SymptomEntryModel value, $Res Function(_SymptomEntryModel) _then) =
      __$SymptomEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime date,
      int symptomId,
      SymptomModel? symptom,
      SymptomSeverity severity,
      DateTime createdAt});

  @override
  $SymptomModelCopyWith<$Res>? get symptom;
}

/// @nodoc
class __$SymptomEntryModelCopyWithImpl<$Res>
    implements _$SymptomEntryModelCopyWith<$Res> {
  __$SymptomEntryModelCopyWithImpl(this._self, this._then);

  final _SymptomEntryModel _self;
  final $Res Function(_SymptomEntryModel) _then;

  /// Create a copy of SymptomEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? symptomId = null,
    Object? symptom = freezed,
    Object? severity = null,
    Object? createdAt = null,
  }) {
    return _then(_SymptomEntryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      symptomId: null == symptomId
          ? _self.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as int,
      symptom: freezed == symptom
          ? _self.symptom
          : symptom // ignore: cast_nullable_to_non_nullable
              as SymptomModel?,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as SymptomSeverity,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of SymptomEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SymptomModelCopyWith<$Res>? get symptom {
    if (_self.symptom == null) {
      return null;
    }

    return $SymptomModelCopyWith<$Res>(_self.symptom!, (value) {
      return _then(_self.copyWith(symptom: value));
    });
  }
}

// dart format on
