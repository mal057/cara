// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPreferenceModel {
  /// Database row ID from notification_preferences table.
  int get id;

  /// Notification type identifier. One of: 'period_approaching',
  /// 'fertile_window', 'daily_reminder'.
  String get type;

  /// Whether this notification type is currently enabled.
  bool get enabled;

  /// HH:MM time string for the daily reminder (e.g. '21:00').
  /// Null for non-daily types.
  String? get timeOfDay;

  /// Days before the predicted event to fire the notification.
  /// Null for 'daily_reminder' type.
  int? get daysBefore;

  /// When this row was last updated.
  DateTime get updatedAt;

  /// Create a copy of NotificationPreferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationPreferenceModelCopyWith<NotificationPreferenceModel>
      get copyWith => _$NotificationPreferenceModelCopyWithImpl<
              NotificationPreferenceModel>(
          this as NotificationPreferenceModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationPreferenceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.daysBefore, daysBefore) ||
                other.daysBefore == daysBefore) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, enabled, timeOfDay, daysBefore, updatedAt);

  @override
  String toString() {
    return 'NotificationPreferenceModel(id: $id, type: $type, enabled: $enabled, timeOfDay: $timeOfDay, daysBefore: $daysBefore, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $NotificationPreferenceModelCopyWith<$Res> {
  factory $NotificationPreferenceModelCopyWith(
          NotificationPreferenceModel value,
          $Res Function(NotificationPreferenceModel) _then) =
      _$NotificationPreferenceModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String type,
      bool enabled,
      String? timeOfDay,
      int? daysBefore,
      DateTime updatedAt});
}

/// @nodoc
class _$NotificationPreferenceModelCopyWithImpl<$Res>
    implements $NotificationPreferenceModelCopyWith<$Res> {
  _$NotificationPreferenceModelCopyWithImpl(this._self, this._then);

  final NotificationPreferenceModel _self;
  final $Res Function(NotificationPreferenceModel) _then;

  /// Create a copy of NotificationPreferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? enabled = null,
    Object? timeOfDay = freezed,
    Object? daysBefore = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      timeOfDay: freezed == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      daysBefore: freezed == daysBefore
          ? _self.daysBefore
          : daysBefore // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationPreferenceModel].
extension NotificationPreferenceModelPatterns on NotificationPreferenceModel {
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
    TResult Function(_NotificationPreferenceModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferenceModel() when $default != null:
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
    TResult Function(_NotificationPreferenceModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferenceModel():
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
    TResult? Function(_NotificationPreferenceModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferenceModel() when $default != null:
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
    TResult Function(int id, String type, bool enabled, String? timeOfDay,
            int? daysBefore, DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferenceModel() when $default != null:
        return $default(_that.id, _that.type, _that.enabled, _that.timeOfDay,
            _that.daysBefore, _that.updatedAt);
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
    TResult Function(int id, String type, bool enabled, String? timeOfDay,
            int? daysBefore, DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferenceModel():
        return $default(_that.id, _that.type, _that.enabled, _that.timeOfDay,
            _that.daysBefore, _that.updatedAt);
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
    TResult? Function(int id, String type, bool enabled, String? timeOfDay,
            int? daysBefore, DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferenceModel() when $default != null:
        return $default(_that.id, _that.type, _that.enabled, _that.timeOfDay,
            _that.daysBefore, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NotificationPreferenceModel implements NotificationPreferenceModel {
  const _NotificationPreferenceModel(
      {required this.id,
      required this.type,
      required this.enabled,
      this.timeOfDay,
      this.daysBefore,
      required this.updatedAt});

  /// Database row ID from notification_preferences table.
  @override
  final int id;

  /// Notification type identifier. One of: 'period_approaching',
  /// 'fertile_window', 'daily_reminder'.
  @override
  final String type;

  /// Whether this notification type is currently enabled.
  @override
  final bool enabled;

  /// HH:MM time string for the daily reminder (e.g. '21:00').
  /// Null for non-daily types.
  @override
  final String? timeOfDay;

  /// Days before the predicted event to fire the notification.
  /// Null for 'daily_reminder' type.
  @override
  final int? daysBefore;

  /// When this row was last updated.
  @override
  final DateTime updatedAt;

  /// Create a copy of NotificationPreferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationPreferenceModelCopyWith<_NotificationPreferenceModel>
      get copyWith => __$NotificationPreferenceModelCopyWithImpl<
          _NotificationPreferenceModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationPreferenceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.daysBefore, daysBefore) ||
                other.daysBefore == daysBefore) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, enabled, timeOfDay, daysBefore, updatedAt);

  @override
  String toString() {
    return 'NotificationPreferenceModel(id: $id, type: $type, enabled: $enabled, timeOfDay: $timeOfDay, daysBefore: $daysBefore, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$NotificationPreferenceModelCopyWith<$Res>
    implements $NotificationPreferenceModelCopyWith<$Res> {
  factory _$NotificationPreferenceModelCopyWith(
          _NotificationPreferenceModel value,
          $Res Function(_NotificationPreferenceModel) _then) =
      __$NotificationPreferenceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String type,
      bool enabled,
      String? timeOfDay,
      int? daysBefore,
      DateTime updatedAt});
}

/// @nodoc
class __$NotificationPreferenceModelCopyWithImpl<$Res>
    implements _$NotificationPreferenceModelCopyWith<$Res> {
  __$NotificationPreferenceModelCopyWithImpl(this._self, this._then);

  final _NotificationPreferenceModel _self;
  final $Res Function(_NotificationPreferenceModel) _then;

  /// Create a copy of NotificationPreferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? enabled = null,
    Object? timeOfDay = freezed,
    Object? daysBefore = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_NotificationPreferenceModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      timeOfDay: freezed == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      daysBefore: freezed == daysBefore
          ? _self.daysBefore
          : daysBefore // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
