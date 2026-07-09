// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_stat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SymptomStat {
  /// Foreign key to symptoms.id — the symptom being aggregated.
  int get symptomId;

  /// Human-readable symptom name (from joined symptoms row).
  String get symptomName;

  /// Symptom category (from joined symptoms row).
  SymptomCategory get category;

  /// Flutter icon identifier string (from joined symptoms row).
  String get iconName;

  /// Optional emoji string for mood symptoms (from joined symptoms row).
  String? get emoji;

  /// Number of times this symptom was logged in the requested date range.
  int get occurrenceCount;

  /// Mean severity across all entries in the date range (1.0–3.0).
  double get averageSeverity;

  /// Create a copy of SymptomStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SymptomStatCopyWith<SymptomStat> get copyWith =>
      _$SymptomStatCopyWithImpl<SymptomStat>(this as SymptomStat, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SymptomStat &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId) &&
            (identical(other.symptomName, symptomName) ||
                other.symptomName == symptomName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.occurrenceCount, occurrenceCount) ||
                other.occurrenceCount == occurrenceCount) &&
            (identical(other.averageSeverity, averageSeverity) ||
                other.averageSeverity == averageSeverity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, symptomId, symptomName, category,
      iconName, emoji, occurrenceCount, averageSeverity);

  @override
  String toString() {
    return 'SymptomStat(symptomId: $symptomId, symptomName: $symptomName, category: $category, iconName: $iconName, emoji: $emoji, occurrenceCount: $occurrenceCount, averageSeverity: $averageSeverity)';
  }
}

/// @nodoc
abstract mixin class $SymptomStatCopyWith<$Res> {
  factory $SymptomStatCopyWith(
          SymptomStat value, $Res Function(SymptomStat) _then) =
      _$SymptomStatCopyWithImpl;
  @useResult
  $Res call(
      {int symptomId,
      String symptomName,
      SymptomCategory category,
      String iconName,
      String? emoji,
      int occurrenceCount,
      double averageSeverity});
}

/// @nodoc
class _$SymptomStatCopyWithImpl<$Res> implements $SymptomStatCopyWith<$Res> {
  _$SymptomStatCopyWithImpl(this._self, this._then);

  final SymptomStat _self;
  final $Res Function(SymptomStat) _then;

  /// Create a copy of SymptomStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomId = null,
    Object? symptomName = null,
    Object? category = null,
    Object? iconName = null,
    Object? emoji = freezed,
    Object? occurrenceCount = null,
    Object? averageSeverity = null,
  }) {
    return _then(_self.copyWith(
      symptomId: null == symptomId
          ? _self.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as int,
      symptomName: null == symptomName
          ? _self.symptomName
          : symptomName // ignore: cast_nullable_to_non_nullable
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
      occurrenceCount: null == occurrenceCount
          ? _self.occurrenceCount
          : occurrenceCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageSeverity: null == averageSeverity
          ? _self.averageSeverity
          : averageSeverity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [SymptomStat].
extension SymptomStatPatterns on SymptomStat {
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
    TResult Function(_SymptomStat value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SymptomStat() when $default != null:
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
    TResult Function(_SymptomStat value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomStat():
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
    TResult? Function(_SymptomStat value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomStat() when $default != null:
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
            int symptomId,
            String symptomName,
            SymptomCategory category,
            String iconName,
            String? emoji,
            int occurrenceCount,
            double averageSeverity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SymptomStat() when $default != null:
        return $default(
            _that.symptomId,
            _that.symptomName,
            _that.category,
            _that.iconName,
            _that.emoji,
            _that.occurrenceCount,
            _that.averageSeverity);
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
    TResult Function(
            int symptomId,
            String symptomName,
            SymptomCategory category,
            String iconName,
            String? emoji,
            int occurrenceCount,
            double averageSeverity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomStat():
        return $default(
            _that.symptomId,
            _that.symptomName,
            _that.category,
            _that.iconName,
            _that.emoji,
            _that.occurrenceCount,
            _that.averageSeverity);
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
            int symptomId,
            String symptomName,
            SymptomCategory category,
            String iconName,
            String? emoji,
            int occurrenceCount,
            double averageSeverity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SymptomStat() when $default != null:
        return $default(
            _that.symptomId,
            _that.symptomName,
            _that.category,
            _that.iconName,
            _that.emoji,
            _that.occurrenceCount,
            _that.averageSeverity);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SymptomStat implements SymptomStat {
  const _SymptomStat(
      {required this.symptomId,
      required this.symptomName,
      required this.category,
      required this.iconName,
      this.emoji,
      required this.occurrenceCount,
      required this.averageSeverity});

  /// Foreign key to symptoms.id — the symptom being aggregated.
  @override
  final int symptomId;

  /// Human-readable symptom name (from joined symptoms row).
  @override
  final String symptomName;

  /// Symptom category (from joined symptoms row).
  @override
  final SymptomCategory category;

  /// Flutter icon identifier string (from joined symptoms row).
  @override
  final String iconName;

  /// Optional emoji string for mood symptoms (from joined symptoms row).
  @override
  final String? emoji;

  /// Number of times this symptom was logged in the requested date range.
  @override
  final int occurrenceCount;

  /// Mean severity across all entries in the date range (1.0–3.0).
  @override
  final double averageSeverity;

  /// Create a copy of SymptomStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SymptomStatCopyWith<_SymptomStat> get copyWith =>
      __$SymptomStatCopyWithImpl<_SymptomStat>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SymptomStat &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId) &&
            (identical(other.symptomName, symptomName) ||
                other.symptomName == symptomName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.occurrenceCount, occurrenceCount) ||
                other.occurrenceCount == occurrenceCount) &&
            (identical(other.averageSeverity, averageSeverity) ||
                other.averageSeverity == averageSeverity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, symptomId, symptomName, category,
      iconName, emoji, occurrenceCount, averageSeverity);

  @override
  String toString() {
    return 'SymptomStat(symptomId: $symptomId, symptomName: $symptomName, category: $category, iconName: $iconName, emoji: $emoji, occurrenceCount: $occurrenceCount, averageSeverity: $averageSeverity)';
  }
}

/// @nodoc
abstract mixin class _$SymptomStatCopyWith<$Res>
    implements $SymptomStatCopyWith<$Res> {
  factory _$SymptomStatCopyWith(
          _SymptomStat value, $Res Function(_SymptomStat) _then) =
      __$SymptomStatCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int symptomId,
      String symptomName,
      SymptomCategory category,
      String iconName,
      String? emoji,
      int occurrenceCount,
      double averageSeverity});
}

/// @nodoc
class __$SymptomStatCopyWithImpl<$Res> implements _$SymptomStatCopyWith<$Res> {
  __$SymptomStatCopyWithImpl(this._self, this._then);

  final _SymptomStat _self;
  final $Res Function(_SymptomStat) _then;

  /// Create a copy of SymptomStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? symptomId = null,
    Object? symptomName = null,
    Object? category = null,
    Object? iconName = null,
    Object? emoji = freezed,
    Object? occurrenceCount = null,
    Object? averageSeverity = null,
  }) {
    return _then(_SymptomStat(
      symptomId: null == symptomId
          ? _self.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as int,
      symptomName: null == symptomName
          ? _self.symptomName
          : symptomName // ignore: cast_nullable_to_non_nullable
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
      occurrenceCount: null == occurrenceCount
          ? _self.occurrenceCount
          : occurrenceCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageSeverity: null == averageSeverity
          ? _self.averageSeverity
          : averageSeverity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
