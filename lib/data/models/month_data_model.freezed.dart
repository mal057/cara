// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonthData {
  /// All period log entries for the month, ordered by date ascending.
  List<PeriodLogModel> get periodLogs;

  /// All symptom entries for the month, ordered by date ascending.
  List<SymptomEntryModel> get symptomEntries;

  /// Create a copy of MonthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MonthDataCopyWith<MonthData> get copyWith =>
      _$MonthDataCopyWithImpl<MonthData>(this as MonthData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MonthData &&
            const DeepCollectionEquality()
                .equals(other.periodLogs, periodLogs) &&
            const DeepCollectionEquality()
                .equals(other.symptomEntries, symptomEntries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(periodLogs),
      const DeepCollectionEquality().hash(symptomEntries));

  @override
  String toString() {
    return 'MonthData(periodLogs: $periodLogs, symptomEntries: $symptomEntries)';
  }
}

/// @nodoc
abstract mixin class $MonthDataCopyWith<$Res> {
  factory $MonthDataCopyWith(MonthData value, $Res Function(MonthData) _then) =
      _$MonthDataCopyWithImpl;
  @useResult
  $Res call(
      {List<PeriodLogModel> periodLogs,
      List<SymptomEntryModel> symptomEntries});
}

/// @nodoc
class _$MonthDataCopyWithImpl<$Res> implements $MonthDataCopyWith<$Res> {
  _$MonthDataCopyWithImpl(this._self, this._then);

  final MonthData _self;
  final $Res Function(MonthData) _then;

  /// Create a copy of MonthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? periodLogs = null,
    Object? symptomEntries = null,
  }) {
    return _then(_self.copyWith(
      periodLogs: null == periodLogs
          ? _self.periodLogs
          : periodLogs // ignore: cast_nullable_to_non_nullable
              as List<PeriodLogModel>,
      symptomEntries: null == symptomEntries
          ? _self.symptomEntries
          : symptomEntries // ignore: cast_nullable_to_non_nullable
              as List<SymptomEntryModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MonthData].
extension MonthDataPatterns on MonthData {
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
    TResult Function(_MonthData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MonthData() when $default != null:
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
    TResult Function(_MonthData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonthData():
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
    TResult? Function(_MonthData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonthData() when $default != null:
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
    TResult Function(List<PeriodLogModel> periodLogs,
            List<SymptomEntryModel> symptomEntries)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MonthData() when $default != null:
        return $default(_that.periodLogs, _that.symptomEntries);
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
    TResult Function(List<PeriodLogModel> periodLogs,
            List<SymptomEntryModel> symptomEntries)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonthData():
        return $default(_that.periodLogs, _that.symptomEntries);
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
    TResult? Function(List<PeriodLogModel> periodLogs,
            List<SymptomEntryModel> symptomEntries)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonthData() when $default != null:
        return $default(_that.periodLogs, _that.symptomEntries);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MonthData implements MonthData {
  const _MonthData(
      {final List<PeriodLogModel> periodLogs = const [],
      final List<SymptomEntryModel> symptomEntries = const []})
      : _periodLogs = periodLogs,
        _symptomEntries = symptomEntries;

  /// All period log entries for the month, ordered by date ascending.
  final List<PeriodLogModel> _periodLogs;

  /// All period log entries for the month, ordered by date ascending.
  @override
  @JsonKey()
  List<PeriodLogModel> get periodLogs {
    if (_periodLogs is EqualUnmodifiableListView) return _periodLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_periodLogs);
  }

  /// All symptom entries for the month, ordered by date ascending.
  final List<SymptomEntryModel> _symptomEntries;

  /// All symptom entries for the month, ordered by date ascending.
  @override
  @JsonKey()
  List<SymptomEntryModel> get symptomEntries {
    if (_symptomEntries is EqualUnmodifiableListView) return _symptomEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptomEntries);
  }

  /// Create a copy of MonthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MonthDataCopyWith<_MonthData> get copyWith =>
      __$MonthDataCopyWithImpl<_MonthData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MonthData &&
            const DeepCollectionEquality()
                .equals(other._periodLogs, _periodLogs) &&
            const DeepCollectionEquality()
                .equals(other._symptomEntries, _symptomEntries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_periodLogs),
      const DeepCollectionEquality().hash(_symptomEntries));

  @override
  String toString() {
    return 'MonthData(periodLogs: $periodLogs, symptomEntries: $symptomEntries)';
  }
}

/// @nodoc
abstract mixin class _$MonthDataCopyWith<$Res>
    implements $MonthDataCopyWith<$Res> {
  factory _$MonthDataCopyWith(
          _MonthData value, $Res Function(_MonthData) _then) =
      __$MonthDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<PeriodLogModel> periodLogs,
      List<SymptomEntryModel> symptomEntries});
}

/// @nodoc
class __$MonthDataCopyWithImpl<$Res> implements _$MonthDataCopyWith<$Res> {
  __$MonthDataCopyWithImpl(this._self, this._then);

  final _MonthData _self;
  final $Res Function(_MonthData) _then;

  /// Create a copy of MonthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? periodLogs = null,
    Object? symptomEntries = null,
  }) {
    return _then(_MonthData(
      periodLogs: null == periodLogs
          ? _self._periodLogs
          : periodLogs // ignore: cast_nullable_to_non_nullable
              as List<PeriodLogModel>,
      symptomEntries: null == symptomEntries
          ? _self._symptomEntries
          : symptomEntries // ignore: cast_nullable_to_non_nullable
              as List<SymptomEntryModel>,
    ));
  }
}

// dart format on
