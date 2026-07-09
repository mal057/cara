// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CycleStatsModel {
  /// Weighted average cycle length in days across all completed cycles.
  double get avgCycleLength;

  /// Weighted average period length in days across all completed cycles.
  double get avgPeriodLength;

  /// Shortest recorded cycle length in days.
  int get minCycleLength;

  /// Longest recorded cycle length in days.
  int get maxCycleLength;

  /// Total number of completed cycles in the history.
  int get totalCycles;

  /// True if cycle history shows high variability (std_dev > 5 days).
  bool get isIrregular;

  /// Create a copy of CycleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CycleStatsModelCopyWith<CycleStatsModel> get copyWith =>
      _$CycleStatsModelCopyWithImpl<CycleStatsModel>(
          this as CycleStatsModel, _$identity);

  /// Serializes this CycleStatsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CycleStatsModel &&
            (identical(other.avgCycleLength, avgCycleLength) ||
                other.avgCycleLength == avgCycleLength) &&
            (identical(other.avgPeriodLength, avgPeriodLength) ||
                other.avgPeriodLength == avgPeriodLength) &&
            (identical(other.minCycleLength, minCycleLength) ||
                other.minCycleLength == minCycleLength) &&
            (identical(other.maxCycleLength, maxCycleLength) ||
                other.maxCycleLength == maxCycleLength) &&
            (identical(other.totalCycles, totalCycles) ||
                other.totalCycles == totalCycles) &&
            (identical(other.isIrregular, isIrregular) ||
                other.isIrregular == isIrregular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, avgCycleLength, avgPeriodLength,
      minCycleLength, maxCycleLength, totalCycles, isIrregular);

  @override
  String toString() {
    return 'CycleStatsModel(avgCycleLength: $avgCycleLength, avgPeriodLength: $avgPeriodLength, minCycleLength: $minCycleLength, maxCycleLength: $maxCycleLength, totalCycles: $totalCycles, isIrregular: $isIrregular)';
  }
}

/// @nodoc
abstract mixin class $CycleStatsModelCopyWith<$Res> {
  factory $CycleStatsModelCopyWith(
          CycleStatsModel value, $Res Function(CycleStatsModel) _then) =
      _$CycleStatsModelCopyWithImpl;
  @useResult
  $Res call(
      {double avgCycleLength,
      double avgPeriodLength,
      int minCycleLength,
      int maxCycleLength,
      int totalCycles,
      bool isIrregular});
}

/// @nodoc
class _$CycleStatsModelCopyWithImpl<$Res>
    implements $CycleStatsModelCopyWith<$Res> {
  _$CycleStatsModelCopyWithImpl(this._self, this._then);

  final CycleStatsModel _self;
  final $Res Function(CycleStatsModel) _then;

  /// Create a copy of CycleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avgCycleLength = null,
    Object? avgPeriodLength = null,
    Object? minCycleLength = null,
    Object? maxCycleLength = null,
    Object? totalCycles = null,
    Object? isIrregular = null,
  }) {
    return _then(_self.copyWith(
      avgCycleLength: null == avgCycleLength
          ? _self.avgCycleLength
          : avgCycleLength // ignore: cast_nullable_to_non_nullable
              as double,
      avgPeriodLength: null == avgPeriodLength
          ? _self.avgPeriodLength
          : avgPeriodLength // ignore: cast_nullable_to_non_nullable
              as double,
      minCycleLength: null == minCycleLength
          ? _self.minCycleLength
          : minCycleLength // ignore: cast_nullable_to_non_nullable
              as int,
      maxCycleLength: null == maxCycleLength
          ? _self.maxCycleLength
          : maxCycleLength // ignore: cast_nullable_to_non_nullable
              as int,
      totalCycles: null == totalCycles
          ? _self.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      isIrregular: null == isIrregular
          ? _self.isIrregular
          : isIrregular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [CycleStatsModel].
extension CycleStatsModelPatterns on CycleStatsModel {
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
    TResult Function(_CycleStatsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CycleStatsModel() when $default != null:
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
    TResult Function(_CycleStatsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleStatsModel():
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
    TResult? Function(_CycleStatsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleStatsModel() when $default != null:
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
            double avgCycleLength,
            double avgPeriodLength,
            int minCycleLength,
            int maxCycleLength,
            int totalCycles,
            bool isIrregular)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CycleStatsModel() when $default != null:
        return $default(
            _that.avgCycleLength,
            _that.avgPeriodLength,
            _that.minCycleLength,
            _that.maxCycleLength,
            _that.totalCycles,
            _that.isIrregular);
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
            double avgCycleLength,
            double avgPeriodLength,
            int minCycleLength,
            int maxCycleLength,
            int totalCycles,
            bool isIrregular)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleStatsModel():
        return $default(
            _that.avgCycleLength,
            _that.avgPeriodLength,
            _that.minCycleLength,
            _that.maxCycleLength,
            _that.totalCycles,
            _that.isIrregular);
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
            double avgCycleLength,
            double avgPeriodLength,
            int minCycleLength,
            int maxCycleLength,
            int totalCycles,
            bool isIrregular)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleStatsModel() when $default != null:
        return $default(
            _that.avgCycleLength,
            _that.avgPeriodLength,
            _that.minCycleLength,
            _that.maxCycleLength,
            _that.totalCycles,
            _that.isIrregular);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CycleStatsModel implements CycleStatsModel {
  const _CycleStatsModel(
      {required this.avgCycleLength,
      required this.avgPeriodLength,
      required this.minCycleLength,
      required this.maxCycleLength,
      required this.totalCycles,
      this.isIrregular = false});
  factory _CycleStatsModel.fromJson(Map<String, dynamic> json) =>
      _$CycleStatsModelFromJson(json);

  /// Weighted average cycle length in days across all completed cycles.
  @override
  final double avgCycleLength;

  /// Weighted average period length in days across all completed cycles.
  @override
  final double avgPeriodLength;

  /// Shortest recorded cycle length in days.
  @override
  final int minCycleLength;

  /// Longest recorded cycle length in days.
  @override
  final int maxCycleLength;

  /// Total number of completed cycles in the history.
  @override
  final int totalCycles;

  /// True if cycle history shows high variability (std_dev > 5 days).
  @override
  @JsonKey()
  final bool isIrregular;

  /// Create a copy of CycleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CycleStatsModelCopyWith<_CycleStatsModel> get copyWith =>
      __$CycleStatsModelCopyWithImpl<_CycleStatsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CycleStatsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CycleStatsModel &&
            (identical(other.avgCycleLength, avgCycleLength) ||
                other.avgCycleLength == avgCycleLength) &&
            (identical(other.avgPeriodLength, avgPeriodLength) ||
                other.avgPeriodLength == avgPeriodLength) &&
            (identical(other.minCycleLength, minCycleLength) ||
                other.minCycleLength == minCycleLength) &&
            (identical(other.maxCycleLength, maxCycleLength) ||
                other.maxCycleLength == maxCycleLength) &&
            (identical(other.totalCycles, totalCycles) ||
                other.totalCycles == totalCycles) &&
            (identical(other.isIrregular, isIrregular) ||
                other.isIrregular == isIrregular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, avgCycleLength, avgPeriodLength,
      minCycleLength, maxCycleLength, totalCycles, isIrregular);

  @override
  String toString() {
    return 'CycleStatsModel(avgCycleLength: $avgCycleLength, avgPeriodLength: $avgPeriodLength, minCycleLength: $minCycleLength, maxCycleLength: $maxCycleLength, totalCycles: $totalCycles, isIrregular: $isIrregular)';
  }
}

/// @nodoc
abstract mixin class _$CycleStatsModelCopyWith<$Res>
    implements $CycleStatsModelCopyWith<$Res> {
  factory _$CycleStatsModelCopyWith(
          _CycleStatsModel value, $Res Function(_CycleStatsModel) _then) =
      __$CycleStatsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double avgCycleLength,
      double avgPeriodLength,
      int minCycleLength,
      int maxCycleLength,
      int totalCycles,
      bool isIrregular});
}

/// @nodoc
class __$CycleStatsModelCopyWithImpl<$Res>
    implements _$CycleStatsModelCopyWith<$Res> {
  __$CycleStatsModelCopyWithImpl(this._self, this._then);

  final _CycleStatsModel _self;
  final $Res Function(_CycleStatsModel) _then;

  /// Create a copy of CycleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? avgCycleLength = null,
    Object? avgPeriodLength = null,
    Object? minCycleLength = null,
    Object? maxCycleLength = null,
    Object? totalCycles = null,
    Object? isIrregular = null,
  }) {
    return _then(_CycleStatsModel(
      avgCycleLength: null == avgCycleLength
          ? _self.avgCycleLength
          : avgCycleLength // ignore: cast_nullable_to_non_nullable
              as double,
      avgPeriodLength: null == avgPeriodLength
          ? _self.avgPeriodLength
          : avgPeriodLength // ignore: cast_nullable_to_non_nullable
              as double,
      minCycleLength: null == minCycleLength
          ? _self.minCycleLength
          : minCycleLength // ignore: cast_nullable_to_non_nullable
              as int,
      maxCycleLength: null == maxCycleLength
          ? _self.maxCycleLength
          : maxCycleLength // ignore: cast_nullable_to_non_nullable
              as int,
      totalCycles: null == totalCycles
          ? _self.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      isIrregular: null == isIrregular
          ? _self.isIrregular
          : isIrregular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
