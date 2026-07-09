// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_note_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyNoteModel {
  /// Database row ID from daily_notes table.
  int get id;

  /// The calendar date this note belongs to. Unique — one note per day.
  DateTime get date;

  /// Free-form note text. Max 500 characters.
  String get content;

  /// When this row was first inserted.
  DateTime get createdAt;

  /// When this row was last updated (upsert sets this).
  DateTime get updatedAt;

  /// Create a copy of DailyNoteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DailyNoteModelCopyWith<DailyNoteModel> get copyWith =>
      _$DailyNoteModelCopyWithImpl<DailyNoteModel>(
          this as DailyNoteModel, _$identity);

  /// Serializes this DailyNoteModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DailyNoteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, content, createdAt, updatedAt);

  @override
  String toString() {
    return 'DailyNoteModel(id: $id, date: $date, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $DailyNoteModelCopyWith<$Res> {
  factory $DailyNoteModelCopyWith(
          DailyNoteModel value, $Res Function(DailyNoteModel) _then) =
      _$DailyNoteModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime date,
      String content,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DailyNoteModelCopyWithImpl<$Res>
    implements $DailyNoteModelCopyWith<$Res> {
  _$DailyNoteModelCopyWithImpl(this._self, this._then);

  final DailyNoteModel _self;
  final $Res Function(DailyNoteModel) _then;

  /// Create a copy of DailyNoteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? content = null,
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
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
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

/// Adds pattern-matching-related methods to [DailyNoteModel].
extension DailyNoteModelPatterns on DailyNoteModel {
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
    TResult Function(_DailyNoteModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyNoteModel() when $default != null:
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
    TResult Function(_DailyNoteModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyNoteModel():
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
    TResult? Function(_DailyNoteModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyNoteModel() when $default != null:
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
    TResult Function(int id, DateTime date, String content, DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyNoteModel() when $default != null:
        return $default(_that.id, _that.date, _that.content, _that.createdAt,
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
    TResult Function(int id, DateTime date, String content, DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyNoteModel():
        return $default(_that.id, _that.date, _that.content, _that.createdAt,
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
    TResult? Function(int id, DateTime date, String content, DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyNoteModel() when $default != null:
        return $default(_that.id, _that.date, _that.content, _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DailyNoteModel implements DailyNoteModel {
  const _DailyNoteModel(
      {required this.id,
      required this.date,
      required this.content,
      required this.createdAt,
      required this.updatedAt});
  factory _DailyNoteModel.fromJson(Map<String, dynamic> json) =>
      _$DailyNoteModelFromJson(json);

  /// Database row ID from daily_notes table.
  @override
  final int id;

  /// The calendar date this note belongs to. Unique — one note per day.
  @override
  final DateTime date;

  /// Free-form note text. Max 500 characters.
  @override
  final String content;

  /// When this row was first inserted.
  @override
  final DateTime createdAt;

  /// When this row was last updated (upsert sets this).
  @override
  final DateTime updatedAt;

  /// Create a copy of DailyNoteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DailyNoteModelCopyWith<_DailyNoteModel> get copyWith =>
      __$DailyNoteModelCopyWithImpl<_DailyNoteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DailyNoteModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DailyNoteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, content, createdAt, updatedAt);

  @override
  String toString() {
    return 'DailyNoteModel(id: $id, date: $date, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$DailyNoteModelCopyWith<$Res>
    implements $DailyNoteModelCopyWith<$Res> {
  factory _$DailyNoteModelCopyWith(
          _DailyNoteModel value, $Res Function(_DailyNoteModel) _then) =
      __$DailyNoteModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime date,
      String content,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$DailyNoteModelCopyWithImpl<$Res>
    implements _$DailyNoteModelCopyWith<$Res> {
  __$DailyNoteModelCopyWithImpl(this._self, this._then);

  final _DailyNoteModel _self;
  final $Res Function(_DailyNoteModel) _then;

  /// Create a copy of DailyNoteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_DailyNoteModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
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
