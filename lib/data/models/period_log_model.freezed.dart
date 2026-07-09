// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PeriodLogModel {
  /// Database row ID from period_logs table.
  int get id;

  /// The calendar date this log covers. One log per day.
  DateTime get date;

  /// Foreign key to the parent cycle. Null if not yet assigned to a cycle.
  int? get cycleId;

  /// Flow intensity for this day.
  FlowIntensity get flowIntensity;

  /// Flow color for this day. Null if user did not specify.
  FlowColor? get flowColor;

  /// When this row was first inserted.
  DateTime get createdAt;

  /// When this row was last updated.
  DateTime get updatedAt;

  /// Create a copy of PeriodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PeriodLogModelCopyWith<PeriodLogModel> get copyWith =>
      _$PeriodLogModelCopyWithImpl<PeriodLogModel>(
          this as PeriodLogModel, _$identity);

  /// Serializes this PeriodLogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PeriodLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.cycleId, cycleId) || other.cycleId == cycleId) &&
            (identical(other.flowIntensity, flowIntensity) ||
                other.flowIntensity == flowIntensity) &&
            (identical(other.flowColor, flowColor) ||
                other.flowColor == flowColor) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, cycleId, flowIntensity,
      flowColor, createdAt, updatedAt);

  @override
  String toString() {
    return 'PeriodLogModel(id: $id, date: $date, cycleId: $cycleId, flowIntensity: $flowIntensity, flowColor: $flowColor, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $PeriodLogModelCopyWith<$Res> {
  factory $PeriodLogModelCopyWith(
          PeriodLogModel value, $Res Function(PeriodLogModel) _then) =
      _$PeriodLogModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime date,
      int? cycleId,
      FlowIntensity flowIntensity,
      FlowColor? flowColor,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PeriodLogModelCopyWithImpl<$Res>
    implements $PeriodLogModelCopyWith<$Res> {
  _$PeriodLogModelCopyWithImpl(this._self, this._then);

  final PeriodLogModel _self;
  final $Res Function(PeriodLogModel) _then;

  /// Create a copy of PeriodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? cycleId = freezed,
    Object? flowIntensity = null,
    Object? flowColor = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      cycleId: freezed == cycleId
          ? _self.cycleId
          : cycleId // ignore: cast_nullable_to_non_nullable
              as int?,
      flowIntensity: null == flowIntensity
          ? _self.flowIntensity
          : flowIntensity // ignore: cast_nullable_to_non_nullable
              as FlowIntensity,
      flowColor: freezed == flowColor
          ? _self.flowColor
          : flowColor // ignore: cast_nullable_to_non_nullable
              as FlowColor?,
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

/// Adds pattern-matching-related methods to [PeriodLogModel].
extension PeriodLogModelPatterns on PeriodLogModel {
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
    TResult Function(_PeriodLogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PeriodLogModel() when $default != null:
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
    TResult Function(_PeriodLogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PeriodLogModel():
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
    TResult? Function(_PeriodLogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PeriodLogModel() when $default != null:
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
            int? cycleId,
            FlowIntensity flowIntensity,
            FlowColor? flowColor,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PeriodLogModel() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.cycleId,
            _that.flowIntensity,
            _that.flowColor,
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
            DateTime date,
            int? cycleId,
            FlowIntensity flowIntensity,
            FlowColor? flowColor,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PeriodLogModel():
        return $default(
            _that.id,
            _that.date,
            _that.cycleId,
            _that.flowIntensity,
            _that.flowColor,
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
            DateTime date,
            int? cycleId,
            FlowIntensity flowIntensity,
            FlowColor? flowColor,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PeriodLogModel() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.cycleId,
            _that.flowIntensity,
            _that.flowColor,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PeriodLogModel implements PeriodLogModel {
  const _PeriodLogModel(
      {required this.id,
      required this.date,
      this.cycleId,
      required this.flowIntensity,
      this.flowColor,
      required this.createdAt,
      required this.updatedAt});
  factory _PeriodLogModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodLogModelFromJson(json);

  /// Database row ID from period_logs table.
  @override
  final int id;

  /// The calendar date this log covers. One log per day.
  @override
  final DateTime date;

  /// Foreign key to the parent cycle. Null if not yet assigned to a cycle.
  @override
  final int? cycleId;

  /// Flow intensity for this day.
  @override
  final FlowIntensity flowIntensity;

  /// Flow color for this day. Null if user did not specify.
  @override
  final FlowColor? flowColor;

  /// When this row was first inserted.
  @override
  final DateTime createdAt;

  /// When this row was last updated.
  @override
  final DateTime updatedAt;

  /// Create a copy of PeriodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PeriodLogModelCopyWith<_PeriodLogModel> get copyWith =>
      __$PeriodLogModelCopyWithImpl<_PeriodLogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PeriodLogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeriodLogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.cycleId, cycleId) || other.cycleId == cycleId) &&
            (identical(other.flowIntensity, flowIntensity) ||
                other.flowIntensity == flowIntensity) &&
            (identical(other.flowColor, flowColor) ||
                other.flowColor == flowColor) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, cycleId, flowIntensity,
      flowColor, createdAt, updatedAt);

  @override
  String toString() {
    return 'PeriodLogModel(id: $id, date: $date, cycleId: $cycleId, flowIntensity: $flowIntensity, flowColor: $flowColor, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PeriodLogModelCopyWith<$Res>
    implements $PeriodLogModelCopyWith<$Res> {
  factory _$PeriodLogModelCopyWith(
          _PeriodLogModel value, $Res Function(_PeriodLogModel) _then) =
      __$PeriodLogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime date,
      int? cycleId,
      FlowIntensity flowIntensity,
      FlowColor? flowColor,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$PeriodLogModelCopyWithImpl<$Res>
    implements _$PeriodLogModelCopyWith<$Res> {
  __$PeriodLogModelCopyWithImpl(this._self, this._then);

  final _PeriodLogModel _self;
  final $Res Function(_PeriodLogModel) _then;

  /// Create a copy of PeriodLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? cycleId = freezed,
    Object? flowIntensity = null,
    Object? flowColor = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_PeriodLogModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cycleId: freezed == cycleId
          ? _self.cycleId
          : cycleId // ignore: cast_nullable_to_non_nullable
              as int?,
      flowIntensity: null == flowIntensity
          ? _self.flowIntensity
          : flowIntensity // ignore: cast_nullable_to_non_nullable
              as FlowIntensity,
      flowColor: freezed == flowColor
          ? _self.flowColor
          : flowColor // ignore: cast_nullable_to_non_nullable
              as FlowColor?,
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
