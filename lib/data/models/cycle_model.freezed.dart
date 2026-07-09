// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CycleModel {
  /// Database row ID from cycles table.
  int get id;

  /// First day of the cycle (first day of period).
  DateTime get startDate;

  /// Last day of the cycle (day before next period starts). Null while ongoing.
  DateTime? get endDate;

  /// Computed cycle length in days. Null until cycle is closed.
  int? get cycleLength;

  /// Number of period days in this cycle. Null until cycle is closed.
  int? get periodLength;

  /// Whether this cycle row was predicted (not user-confirmed).
  bool get isPredicted;

  /// Period logs belonging to this cycle.
  List<PeriodLogModel> get periodLogs;

  /// Current phase of this cycle (computed by PhaseCalculator).
  CyclePhase? get currentPhase;

  /// Day number within this cycle (1-based).
  int? get cycleDay;

  /// When this row was first inserted.
  DateTime get createdAt;

  /// When this row was last updated.
  DateTime get updatedAt;

  /// Create a copy of CycleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CycleModelCopyWith<CycleModel> get copyWith =>
      _$CycleModelCopyWithImpl<CycleModel>(this as CycleModel, _$identity);

  /// Serializes this CycleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CycleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.cycleLength, cycleLength) ||
                other.cycleLength == cycleLength) &&
            (identical(other.periodLength, periodLength) ||
                other.periodLength == periodLength) &&
            (identical(other.isPredicted, isPredicted) ||
                other.isPredicted == isPredicted) &&
            const DeepCollectionEquality()
                .equals(other.periodLogs, periodLogs) &&
            (identical(other.currentPhase, currentPhase) ||
                other.currentPhase == currentPhase) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      startDate,
      endDate,
      cycleLength,
      periodLength,
      isPredicted,
      const DeepCollectionEquality().hash(periodLogs),
      currentPhase,
      cycleDay,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'CycleModel(id: $id, startDate: $startDate, endDate: $endDate, cycleLength: $cycleLength, periodLength: $periodLength, isPredicted: $isPredicted, periodLogs: $periodLogs, currentPhase: $currentPhase, cycleDay: $cycleDay, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $CycleModelCopyWith<$Res> {
  factory $CycleModelCopyWith(
          CycleModel value, $Res Function(CycleModel) _then) =
      _$CycleModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime startDate,
      DateTime? endDate,
      int? cycleLength,
      int? periodLength,
      bool isPredicted,
      List<PeriodLogModel> periodLogs,
      CyclePhase? currentPhase,
      int? cycleDay,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CycleModelCopyWithImpl<$Res> implements $CycleModelCopyWith<$Res> {
  _$CycleModelCopyWithImpl(this._self, this._then);

  final CycleModel _self;
  final $Res Function(CycleModel) _then;

  /// Create a copy of CycleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? cycleLength = freezed,
    Object? periodLength = freezed,
    Object? isPredicted = null,
    Object? periodLogs = null,
    Object? currentPhase = freezed,
    Object? cycleDay = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cycleLength: freezed == cycleLength
          ? _self.cycleLength
          : cycleLength // ignore: cast_nullable_to_non_nullable
              as int?,
      periodLength: freezed == periodLength
          ? _self.periodLength
          : periodLength // ignore: cast_nullable_to_non_nullable
              as int?,
      isPredicted: null == isPredicted
          ? _self.isPredicted
          : isPredicted // ignore: cast_nullable_to_non_nullable
              as bool,
      periodLogs: null == periodLogs
          ? _self.periodLogs
          : periodLogs // ignore: cast_nullable_to_non_nullable
              as List<PeriodLogModel>,
      currentPhase: freezed == currentPhase
          ? _self.currentPhase
          : currentPhase // ignore: cast_nullable_to_non_nullable
              as CyclePhase?,
      cycleDay: freezed == cycleDay
          ? _self.cycleDay
          : cycleDay // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [CycleModel].
extension CycleModelPatterns on CycleModel {
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
    TResult Function(_CycleModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CycleModel() when $default != null:
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
    TResult Function(_CycleModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleModel():
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
    TResult? Function(_CycleModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleModel() when $default != null:
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
            DateTime startDate,
            DateTime? endDate,
            int? cycleLength,
            int? periodLength,
            bool isPredicted,
            List<PeriodLogModel> periodLogs,
            CyclePhase? currentPhase,
            int? cycleDay,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CycleModel() when $default != null:
        return $default(
            _that.id,
            _that.startDate,
            _that.endDate,
            _that.cycleLength,
            _that.periodLength,
            _that.isPredicted,
            _that.periodLogs,
            _that.currentPhase,
            _that.cycleDay,
            _that.createdAt,
            _that.updatedAt);
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
            int id,
            DateTime startDate,
            DateTime? endDate,
            int? cycleLength,
            int? periodLength,
            bool isPredicted,
            List<PeriodLogModel> periodLogs,
            CyclePhase? currentPhase,
            int? cycleDay,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleModel():
        return $default(
            _that.id,
            _that.startDate,
            _that.endDate,
            _that.cycleLength,
            _that.periodLength,
            _that.isPredicted,
            _that.periodLogs,
            _that.currentPhase,
            _that.cycleDay,
            _that.createdAt,
            _that.updatedAt);
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
            DateTime startDate,
            DateTime? endDate,
            int? cycleLength,
            int? periodLength,
            bool isPredicted,
            List<PeriodLogModel> periodLogs,
            CyclePhase? currentPhase,
            int? cycleDay,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CycleModel() when $default != null:
        return $default(
            _that.id,
            _that.startDate,
            _that.endDate,
            _that.cycleLength,
            _that.periodLength,
            _that.isPredicted,
            _that.periodLogs,
            _that.currentPhase,
            _that.cycleDay,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CycleModel implements CycleModel {
  const _CycleModel(
      {required this.id,
      required this.startDate,
      this.endDate,
      this.cycleLength,
      this.periodLength,
      this.isPredicted = false,
      final List<PeriodLogModel> periodLogs = const [],
      this.currentPhase,
      this.cycleDay,
      required this.createdAt,
      required this.updatedAt})
      : _periodLogs = periodLogs;
  factory _CycleModel.fromJson(Map<String, dynamic> json) =>
      _$CycleModelFromJson(json);

  /// Database row ID from cycles table.
  @override
  final int id;

  /// First day of the cycle (first day of period).
  @override
  final DateTime startDate;

  /// Last day of the cycle (day before next period starts). Null while ongoing.
  @override
  final DateTime? endDate;

  /// Computed cycle length in days. Null until cycle is closed.
  @override
  final int? cycleLength;

  /// Number of period days in this cycle. Null until cycle is closed.
  @override
  final int? periodLength;

  /// Whether this cycle row was predicted (not user-confirmed).
  @override
  @JsonKey()
  final bool isPredicted;

  /// Period logs belonging to this cycle.
  final List<PeriodLogModel> _periodLogs;

  /// Period logs belonging to this cycle.
  @override
  @JsonKey()
  List<PeriodLogModel> get periodLogs {
    if (_periodLogs is EqualUnmodifiableListView) return _periodLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_periodLogs);
  }

  /// Current phase of this cycle (computed by PhaseCalculator).
  @override
  final CyclePhase? currentPhase;

  /// Day number within this cycle (1-based).
  @override
  final int? cycleDay;

  /// When this row was first inserted.
  @override
  final DateTime createdAt;

  /// When this row was last updated.
  @override
  final DateTime updatedAt;

  /// Create a copy of CycleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CycleModelCopyWith<_CycleModel> get copyWith =>
      __$CycleModelCopyWithImpl<_CycleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CycleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CycleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.cycleLength, cycleLength) ||
                other.cycleLength == cycleLength) &&
            (identical(other.periodLength, periodLength) ||
                other.periodLength == periodLength) &&
            (identical(other.isPredicted, isPredicted) ||
                other.isPredicted == isPredicted) &&
            const DeepCollectionEquality()
                .equals(other._periodLogs, _periodLogs) &&
            (identical(other.currentPhase, currentPhase) ||
                other.currentPhase == currentPhase) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      startDate,
      endDate,
      cycleLength,
      periodLength,
      isPredicted,
      const DeepCollectionEquality().hash(_periodLogs),
      currentPhase,
      cycleDay,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'CycleModel(id: $id, startDate: $startDate, endDate: $endDate, cycleLength: $cycleLength, periodLength: $periodLength, isPredicted: $isPredicted, periodLogs: $periodLogs, currentPhase: $currentPhase, cycleDay: $cycleDay, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$CycleModelCopyWith<$Res>
    implements $CycleModelCopyWith<$Res> {
  factory _$CycleModelCopyWith(
          _CycleModel value, $Res Function(_CycleModel) _then) =
      __$CycleModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime startDate,
      DateTime? endDate,
      int? cycleLength,
      int? periodLength,
      bool isPredicted,
      List<PeriodLogModel> periodLogs,
      CyclePhase? currentPhase,
      int? cycleDay,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$CycleModelCopyWithImpl<$Res> implements _$CycleModelCopyWith<$Res> {
  __$CycleModelCopyWithImpl(this._self, this._then);

  final _CycleModel _self;
  final $Res Function(_CycleModel) _then;

  /// Create a copy of CycleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? cycleLength = freezed,
    Object? periodLength = freezed,
    Object? isPredicted = null,
    Object? periodLogs = null,
    Object? currentPhase = freezed,
    Object? cycleDay = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_CycleModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cycleLength: freezed == cycleLength
          ? _self.cycleLength
          : cycleLength // ignore: cast_nullable_to_non_nullable
              as int?,
      periodLength: freezed == periodLength
          ? _self.periodLength
          : periodLength // ignore: cast_nullable_to_non_nullable
              as int?,
      isPredicted: null == isPredicted
          ? _self.isPredicted
          : isPredicted // ignore: cast_nullable_to_non_nullable
              as bool,
      periodLogs: null == periodLogs
          ? _self._periodLogs
          : periodLogs // ignore: cast_nullable_to_non_nullable
              as List<PeriodLogModel>,
      currentPhase: freezed == currentPhase
          ? _self.currentPhase
          : currentPhase // ignore: cast_nullable_to_non_nullable
              as CyclePhase?,
      cycleDay: freezed == cycleDay
          ? _self.cycleDay
          : cycleDay // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
