// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExportDataModel {
  /// The date-range selection that triggered this export.
  ExportRange get range;

  /// Inclusive start of the exported date window.
  /// Null when [range] is [ExportRange.allTime] and there are no cycles.
  DateTime? get startDate;

  /// Inclusive end of the exported date window (typically today).
  DateTime get endDate;

  /// All completed (and current) cycles within the export window.
  List<CycleModel> get cycles;

  /// Day-level aggregated data for every calendar day in the window.
  /// Used by the CSV exporter for the row-per-day format.
  List<DayDataModel> get dailyData;

  /// Aggregate statistics for the export window.
  /// Null if there are fewer than 1 completed cycle.
  CycleStatsModel? get stats;

  /// Create a copy of ExportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportDataModelCopyWith<ExportDataModel> get copyWith =>
      _$ExportDataModelCopyWithImpl<ExportDataModel>(
          this as ExportDataModel, _$identity);

  /// Serializes this ExportDataModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExportDataModel &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other.cycles, cycles) &&
            const DeepCollectionEquality().equals(other.dailyData, dailyData) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      range,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(cycles),
      const DeepCollectionEquality().hash(dailyData),
      stats);

  @override
  String toString() {
    return 'ExportDataModel(range: $range, startDate: $startDate, endDate: $endDate, cycles: $cycles, dailyData: $dailyData, stats: $stats)';
  }
}

/// @nodoc
abstract mixin class $ExportDataModelCopyWith<$Res> {
  factory $ExportDataModelCopyWith(
          ExportDataModel value, $Res Function(ExportDataModel) _then) =
      _$ExportDataModelCopyWithImpl;
  @useResult
  $Res call(
      {ExportRange range,
      DateTime? startDate,
      DateTime endDate,
      List<CycleModel> cycles,
      List<DayDataModel> dailyData,
      CycleStatsModel? stats});

  $CycleStatsModelCopyWith<$Res>? get stats;
}

/// @nodoc
class _$ExportDataModelCopyWithImpl<$Res>
    implements $ExportDataModelCopyWith<$Res> {
  _$ExportDataModelCopyWithImpl(this._self, this._then);

  final ExportDataModel _self;
  final $Res Function(ExportDataModel) _then;

  /// Create a copy of ExportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? range = null,
    Object? startDate = freezed,
    Object? endDate = null,
    Object? cycles = null,
    Object? dailyData = null,
    Object? stats = freezed,
  }) {
    return _then(_self.copyWith(
      range: null == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as ExportRange,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cycles: null == cycles
          ? _self.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as List<CycleModel>,
      dailyData: null == dailyData
          ? _self.dailyData
          : dailyData // ignore: cast_nullable_to_non_nullable
              as List<DayDataModel>,
      stats: freezed == stats
          ? _self.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as CycleStatsModel?,
    ));
  }

  /// Create a copy of ExportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CycleStatsModelCopyWith<$Res>? get stats {
    if (_self.stats == null) {
      return null;
    }

    return $CycleStatsModelCopyWith<$Res>(_self.stats!, (value) {
      return _then(_self.copyWith(stats: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ExportDataModel].
extension ExportDataModelPatterns on ExportDataModel {
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
    TResult Function(_ExportDataModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExportDataModel() when $default != null:
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
    TResult Function(_ExportDataModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportDataModel():
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
    TResult? Function(_ExportDataModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportDataModel() when $default != null:
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
            ExportRange range,
            DateTime? startDate,
            DateTime endDate,
            List<CycleModel> cycles,
            List<DayDataModel> dailyData,
            CycleStatsModel? stats)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExportDataModel() when $default != null:
        return $default(_that.range, _that.startDate, _that.endDate,
            _that.cycles, _that.dailyData, _that.stats);
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
            ExportRange range,
            DateTime? startDate,
            DateTime endDate,
            List<CycleModel> cycles,
            List<DayDataModel> dailyData,
            CycleStatsModel? stats)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportDataModel():
        return $default(_that.range, _that.startDate, _that.endDate,
            _that.cycles, _that.dailyData, _that.stats);
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
            ExportRange range,
            DateTime? startDate,
            DateTime endDate,
            List<CycleModel> cycles,
            List<DayDataModel> dailyData,
            CycleStatsModel? stats)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportDataModel() when $default != null:
        return $default(_that.range, _that.startDate, _that.endDate,
            _that.cycles, _that.dailyData, _that.stats);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExportDataModel implements ExportDataModel {
  const _ExportDataModel(
      {required this.range,
      this.startDate,
      required this.endDate,
      final List<CycleModel> cycles = const [],
      final List<DayDataModel> dailyData = const [],
      this.stats})
      : _cycles = cycles,
        _dailyData = dailyData;
  factory _ExportDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExportDataModelFromJson(json);

  /// The date-range selection that triggered this export.
  @override
  final ExportRange range;

  /// Inclusive start of the exported date window.
  /// Null when [range] is [ExportRange.allTime] and there are no cycles.
  @override
  final DateTime? startDate;

  /// Inclusive end of the exported date window (typically today).
  @override
  final DateTime endDate;

  /// All completed (and current) cycles within the export window.
  final List<CycleModel> _cycles;

  /// All completed (and current) cycles within the export window.
  @override
  @JsonKey()
  List<CycleModel> get cycles {
    if (_cycles is EqualUnmodifiableListView) return _cycles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cycles);
  }

  /// Day-level aggregated data for every calendar day in the window.
  /// Used by the CSV exporter for the row-per-day format.
  final List<DayDataModel> _dailyData;

  /// Day-level aggregated data for every calendar day in the window.
  /// Used by the CSV exporter for the row-per-day format.
  @override
  @JsonKey()
  List<DayDataModel> get dailyData {
    if (_dailyData is EqualUnmodifiableListView) return _dailyData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyData);
  }

  /// Aggregate statistics for the export window.
  /// Null if there are fewer than 1 completed cycle.
  @override
  final CycleStatsModel? stats;

  /// Create a copy of ExportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExportDataModelCopyWith<_ExportDataModel> get copyWith =>
      __$ExportDataModelCopyWithImpl<_ExportDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExportDataModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExportDataModel &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._cycles, _cycles) &&
            const DeepCollectionEquality()
                .equals(other._dailyData, _dailyData) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      range,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_cycles),
      const DeepCollectionEquality().hash(_dailyData),
      stats);

  @override
  String toString() {
    return 'ExportDataModel(range: $range, startDate: $startDate, endDate: $endDate, cycles: $cycles, dailyData: $dailyData, stats: $stats)';
  }
}

/// @nodoc
abstract mixin class _$ExportDataModelCopyWith<$Res>
    implements $ExportDataModelCopyWith<$Res> {
  factory _$ExportDataModelCopyWith(
          _ExportDataModel value, $Res Function(_ExportDataModel) _then) =
      __$ExportDataModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ExportRange range,
      DateTime? startDate,
      DateTime endDate,
      List<CycleModel> cycles,
      List<DayDataModel> dailyData,
      CycleStatsModel? stats});

  @override
  $CycleStatsModelCopyWith<$Res>? get stats;
}

/// @nodoc
class __$ExportDataModelCopyWithImpl<$Res>
    implements _$ExportDataModelCopyWith<$Res> {
  __$ExportDataModelCopyWithImpl(this._self, this._then);

  final _ExportDataModel _self;
  final $Res Function(_ExportDataModel) _then;

  /// Create a copy of ExportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? range = null,
    Object? startDate = freezed,
    Object? endDate = null,
    Object? cycles = null,
    Object? dailyData = null,
    Object? stats = freezed,
  }) {
    return _then(_ExportDataModel(
      range: null == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as ExportRange,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cycles: null == cycles
          ? _self._cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as List<CycleModel>,
      dailyData: null == dailyData
          ? _self._dailyData
          : dailyData // ignore: cast_nullable_to_non_nullable
              as List<DayDataModel>,
      stats: freezed == stats
          ? _self.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as CycleStatsModel?,
    ));
  }

  /// Create a copy of ExportDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CycleStatsModelCopyWith<$Res>? get stats {
    if (_self.stats == null) {
      return null;
    }

    return $CycleStatsModelCopyWith<$Res>(_self.stats!, (value) {
      return _then(_self.copyWith(stats: value));
    });
  }
}

// dart format on
