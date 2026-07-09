// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_prediction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CyclePredictionModel {
  /// Predicted start date of the next period.
  DateTime get predictedStart;

  /// Predicted end date of the next period.
  DateTime get predictedEnd;

  /// First day of the predicted fertile window.
  DateTime get fertileWindowStart;

  /// Last day of the predicted fertile window.
  DateTime get fertileWindowEnd;

  /// Confidence score in the range [0.0, 1.0].
  /// Derived from cycle regularity (std-dev of historical lengths).
  double get confidence;

  /// True if the user's cycle history shows high variability (std_dev > 5 days).
  bool get isIrregular;

  /// Create a copy of CyclePredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CyclePredictionModelCopyWith<CyclePredictionModel> get copyWith =>
      _$CyclePredictionModelCopyWithImpl<CyclePredictionModel>(
          this as CyclePredictionModel, _$identity);

  /// Serializes this CyclePredictionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CyclePredictionModel &&
            (identical(other.predictedStart, predictedStart) ||
                other.predictedStart == predictedStart) &&
            (identical(other.predictedEnd, predictedEnd) ||
                other.predictedEnd == predictedEnd) &&
            (identical(other.fertileWindowStart, fertileWindowStart) ||
                other.fertileWindowStart == fertileWindowStart) &&
            (identical(other.fertileWindowEnd, fertileWindowEnd) ||
                other.fertileWindowEnd == fertileWindowEnd) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.isIrregular, isIrregular) ||
                other.isIrregular == isIrregular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, predictedStart, predictedEnd,
      fertileWindowStart, fertileWindowEnd, confidence, isIrregular);

  @override
  String toString() {
    return 'CyclePredictionModel(predictedStart: $predictedStart, predictedEnd: $predictedEnd, fertileWindowStart: $fertileWindowStart, fertileWindowEnd: $fertileWindowEnd, confidence: $confidence, isIrregular: $isIrregular)';
  }
}

/// @nodoc
abstract mixin class $CyclePredictionModelCopyWith<$Res> {
  factory $CyclePredictionModelCopyWith(CyclePredictionModel value,
          $Res Function(CyclePredictionModel) _then) =
      _$CyclePredictionModelCopyWithImpl;
  @useResult
  $Res call(
      {DateTime predictedStart,
      DateTime predictedEnd,
      DateTime fertileWindowStart,
      DateTime fertileWindowEnd,
      double confidence,
      bool isIrregular});
}

/// @nodoc
class _$CyclePredictionModelCopyWithImpl<$Res>
    implements $CyclePredictionModelCopyWith<$Res> {
  _$CyclePredictionModelCopyWithImpl(this._self, this._then);

  final CyclePredictionModel _self;
  final $Res Function(CyclePredictionModel) _then;

  /// Create a copy of CyclePredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictedStart = null,
    Object? predictedEnd = null,
    Object? fertileWindowStart = null,
    Object? fertileWindowEnd = null,
    Object? confidence = null,
    Object? isIrregular = null,
  }) {
    return _then(_self.copyWith(
      predictedStart: null == predictedStart
          ? _self.predictedStart
          : predictedStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predictedEnd: null == predictedEnd
          ? _self.predictedEnd
          : predictedEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fertileWindowStart: null == fertileWindowStart
          ? _self.fertileWindowStart
          : fertileWindowStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fertileWindowEnd: null == fertileWindowEnd
          ? _self.fertileWindowEnd
          : fertileWindowEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      isIrregular: null == isIrregular
          ? _self.isIrregular
          : isIrregular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [CyclePredictionModel].
extension CyclePredictionModelPatterns on CyclePredictionModel {
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
    TResult Function(_CyclePredictionModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CyclePredictionModel() when $default != null:
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
    TResult Function(_CyclePredictionModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CyclePredictionModel():
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
    TResult? Function(_CyclePredictionModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CyclePredictionModel() when $default != null:
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
            DateTime predictedStart,
            DateTime predictedEnd,
            DateTime fertileWindowStart,
            DateTime fertileWindowEnd,
            double confidence,
            bool isIrregular)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CyclePredictionModel() when $default != null:
        return $default(
            _that.predictedStart,
            _that.predictedEnd,
            _that.fertileWindowStart,
            _that.fertileWindowEnd,
            _that.confidence,
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
            DateTime predictedStart,
            DateTime predictedEnd,
            DateTime fertileWindowStart,
            DateTime fertileWindowEnd,
            double confidence,
            bool isIrregular)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CyclePredictionModel():
        return $default(
            _that.predictedStart,
            _that.predictedEnd,
            _that.fertileWindowStart,
            _that.fertileWindowEnd,
            _that.confidence,
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
            DateTime predictedStart,
            DateTime predictedEnd,
            DateTime fertileWindowStart,
            DateTime fertileWindowEnd,
            double confidence,
            bool isIrregular)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CyclePredictionModel() when $default != null:
        return $default(
            _that.predictedStart,
            _that.predictedEnd,
            _that.fertileWindowStart,
            _that.fertileWindowEnd,
            _that.confidence,
            _that.isIrregular);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CyclePredictionModel implements CyclePredictionModel {
  const _CyclePredictionModel(
      {required this.predictedStart,
      required this.predictedEnd,
      required this.fertileWindowStart,
      required this.fertileWindowEnd,
      required this.confidence,
      this.isIrregular = false});
  factory _CyclePredictionModel.fromJson(Map<String, dynamic> json) =>
      _$CyclePredictionModelFromJson(json);

  /// Predicted start date of the next period.
  @override
  final DateTime predictedStart;

  /// Predicted end date of the next period.
  @override
  final DateTime predictedEnd;

  /// First day of the predicted fertile window.
  @override
  final DateTime fertileWindowStart;

  /// Last day of the predicted fertile window.
  @override
  final DateTime fertileWindowEnd;

  /// Confidence score in the range [0.0, 1.0].
  /// Derived from cycle regularity (std-dev of historical lengths).
  @override
  final double confidence;

  /// True if the user's cycle history shows high variability (std_dev > 5 days).
  @override
  @JsonKey()
  final bool isIrregular;

  /// Create a copy of CyclePredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CyclePredictionModelCopyWith<_CyclePredictionModel> get copyWith =>
      __$CyclePredictionModelCopyWithImpl<_CyclePredictionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CyclePredictionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CyclePredictionModel &&
            (identical(other.predictedStart, predictedStart) ||
                other.predictedStart == predictedStart) &&
            (identical(other.predictedEnd, predictedEnd) ||
                other.predictedEnd == predictedEnd) &&
            (identical(other.fertileWindowStart, fertileWindowStart) ||
                other.fertileWindowStart == fertileWindowStart) &&
            (identical(other.fertileWindowEnd, fertileWindowEnd) ||
                other.fertileWindowEnd == fertileWindowEnd) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.isIrregular, isIrregular) ||
                other.isIrregular == isIrregular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, predictedStart, predictedEnd,
      fertileWindowStart, fertileWindowEnd, confidence, isIrregular);

  @override
  String toString() {
    return 'CyclePredictionModel(predictedStart: $predictedStart, predictedEnd: $predictedEnd, fertileWindowStart: $fertileWindowStart, fertileWindowEnd: $fertileWindowEnd, confidence: $confidence, isIrregular: $isIrregular)';
  }
}

/// @nodoc
abstract mixin class _$CyclePredictionModelCopyWith<$Res>
    implements $CyclePredictionModelCopyWith<$Res> {
  factory _$CyclePredictionModelCopyWith(_CyclePredictionModel value,
          $Res Function(_CyclePredictionModel) _then) =
      __$CyclePredictionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime predictedStart,
      DateTime predictedEnd,
      DateTime fertileWindowStart,
      DateTime fertileWindowEnd,
      double confidence,
      bool isIrregular});
}

/// @nodoc
class __$CyclePredictionModelCopyWithImpl<$Res>
    implements _$CyclePredictionModelCopyWith<$Res> {
  __$CyclePredictionModelCopyWithImpl(this._self, this._then);

  final _CyclePredictionModel _self;
  final $Res Function(_CyclePredictionModel) _then;

  /// Create a copy of CyclePredictionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? predictedStart = null,
    Object? predictedEnd = null,
    Object? fertileWindowStart = null,
    Object? fertileWindowEnd = null,
    Object? confidence = null,
    Object? isIrregular = null,
  }) {
    return _then(_CyclePredictionModel(
      predictedStart: null == predictedStart
          ? _self.predictedStart
          : predictedStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predictedEnd: null == predictedEnd
          ? _self.predictedEnd
          : predictedEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fertileWindowStart: null == fertileWindowStart
          ? _self.fertileWindowStart
          : fertileWindowStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fertileWindowEnd: null == fertileWindowEnd
          ? _self.fertileWindowEnd
          : fertileWindowEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      isIrregular: null == isIrregular
          ? _self.isIrregular
          : isIrregular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
