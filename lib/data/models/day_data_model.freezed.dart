// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DayDataModel {
  /// The calendar date this record covers.
  DateTime get date;

  /// Period log for this day. Null if the user did not log a period.
  PeriodLogModel? get periodLog;

  /// All symptom entries logged for this day. Empty if none.
  List<SymptomEntryModel> get symptomEntries;

  /// Free-form daily note for this day. Null if none was written.
  DailyNoteModel? get dailyNote;

  /// Computed cycle phase for this day. Null if no active cycle data.
  CyclePhase? get phase;

  /// Whether this day is within a predicted (not confirmed) period range.
  bool get isPredicted;

  /// Day number within the current cycle (1-based). Null if no cycle data.
  int? get cycleDay;

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DayDataModelCopyWith<DayDataModel> get copyWith =>
      _$DayDataModelCopyWithImpl<DayDataModel>(
          this as DayDataModel, _$identity);

  /// Serializes this DayDataModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DayDataModel &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.periodLog, periodLog) ||
                other.periodLog == periodLog) &&
            const DeepCollectionEquality()
                .equals(other.symptomEntries, symptomEntries) &&
            (identical(other.dailyNote, dailyNote) ||
                other.dailyNote == dailyNote) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.isPredicted, isPredicted) ||
                other.isPredicted == isPredicted) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      periodLog,
      const DeepCollectionEquality().hash(symptomEntries),
      dailyNote,
      phase,
      isPredicted,
      cycleDay);

  @override
  String toString() {
    return 'DayDataModel(date: $date, periodLog: $periodLog, symptomEntries: $symptomEntries, dailyNote: $dailyNote, phase: $phase, isPredicted: $isPredicted, cycleDay: $cycleDay)';
  }
}

/// @nodoc
abstract mixin class $DayDataModelCopyWith<$Res> {
  factory $DayDataModelCopyWith(
          DayDataModel value, $Res Function(DayDataModel) _then) =
      _$DayDataModelCopyWithImpl;
  @useResult
  $Res call(
      {DateTime date,
      PeriodLogModel? periodLog,
      List<SymptomEntryModel> symptomEntries,
      DailyNoteModel? dailyNote,
      CyclePhase? phase,
      bool isPredicted,
      int? cycleDay});

  $PeriodLogModelCopyWith<$Res>? get periodLog;
  $DailyNoteModelCopyWith<$Res>? get dailyNote;
}

/// @nodoc
class _$DayDataModelCopyWithImpl<$Res> implements $DayDataModelCopyWith<$Res> {
  _$DayDataModelCopyWithImpl(this._self, this._then);

  final DayDataModel _self;
  final $Res Function(DayDataModel) _then;

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? periodLog = freezed,
    Object? symptomEntries = null,
    Object? dailyNote = freezed,
    Object? phase = freezed,
    Object? isPredicted = null,
    Object? cycleDay = freezed,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodLog: freezed == periodLog
          ? _self.periodLog
          : periodLog // ignore: cast_nullable_to_non_nullable
              as PeriodLogModel?,
      symptomEntries: null == symptomEntries
          ? _self.symptomEntries
          : symptomEntries // ignore: cast_nullable_to_non_nullable
              as List<SymptomEntryModel>,
      dailyNote: freezed == dailyNote
          ? _self.dailyNote
          : dailyNote // ignore: cast_nullable_to_non_nullable
              as DailyNoteModel?,
      phase: freezed == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as CyclePhase?,
      isPredicted: null == isPredicted
          ? _self.isPredicted
          : isPredicted // ignore: cast_nullable_to_non_nullable
              as bool,
      cycleDay: freezed == cycleDay
          ? _self.cycleDay
          : cycleDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PeriodLogModelCopyWith<$Res>? get periodLog {
    if (_self.periodLog == null) {
      return null;
    }

    return $PeriodLogModelCopyWith<$Res>(_self.periodLog!, (value) {
      return _then(_self.copyWith(periodLog: value));
    });
  }

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyNoteModelCopyWith<$Res>? get dailyNote {
    if (_self.dailyNote == null) {
      return null;
    }

    return $DailyNoteModelCopyWith<$Res>(_self.dailyNote!, (value) {
      return _then(_self.copyWith(dailyNote: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DayDataModel].
extension DayDataModelPatterns on DayDataModel {
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
    TResult Function(_DayDataModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DayDataModel() when $default != null:
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
    TResult Function(_DayDataModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DayDataModel():
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
    TResult? Function(_DayDataModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DayDataModel() when $default != null:
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
            DateTime date,
            PeriodLogModel? periodLog,
            List<SymptomEntryModel> symptomEntries,
            DailyNoteModel? dailyNote,
            CyclePhase? phase,
            bool isPredicted,
            int? cycleDay)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DayDataModel() when $default != null:
        return $default(_that.date, _that.periodLog, _that.symptomEntries,
            _that.dailyNote, _that.phase, _that.isPredicted, _that.cycleDay);
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
            DateTime date,
            PeriodLogModel? periodLog,
            List<SymptomEntryModel> symptomEntries,
            DailyNoteModel? dailyNote,
            CyclePhase? phase,
            bool isPredicted,
            int? cycleDay)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DayDataModel():
        return $default(_that.date, _that.periodLog, _that.symptomEntries,
            _that.dailyNote, _that.phase, _that.isPredicted, _that.cycleDay);
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
            DateTime date,
            PeriodLogModel? periodLog,
            List<SymptomEntryModel> symptomEntries,
            DailyNoteModel? dailyNote,
            CyclePhase? phase,
            bool isPredicted,
            int? cycleDay)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DayDataModel() when $default != null:
        return $default(_that.date, _that.periodLog, _that.symptomEntries,
            _that.dailyNote, _that.phase, _that.isPredicted, _that.cycleDay);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DayDataModel implements DayDataModel {
  const _DayDataModel(
      {required this.date,
      this.periodLog,
      final List<SymptomEntryModel> symptomEntries = const [],
      this.dailyNote,
      this.phase,
      this.isPredicted = false,
      this.cycleDay})
      : _symptomEntries = symptomEntries;
  factory _DayDataModel.fromJson(Map<String, dynamic> json) =>
      _$DayDataModelFromJson(json);

  /// The calendar date this record covers.
  @override
  final DateTime date;

  /// Period log for this day. Null if the user did not log a period.
  @override
  final PeriodLogModel? periodLog;

  /// All symptom entries logged for this day. Empty if none.
  final List<SymptomEntryModel> _symptomEntries;

  /// All symptom entries logged for this day. Empty if none.
  @override
  @JsonKey()
  List<SymptomEntryModel> get symptomEntries {
    if (_symptomEntries is EqualUnmodifiableListView) return _symptomEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptomEntries);
  }

  /// Free-form daily note for this day. Null if none was written.
  @override
  final DailyNoteModel? dailyNote;

  /// Computed cycle phase for this day. Null if no active cycle data.
  @override
  final CyclePhase? phase;

  /// Whether this day is within a predicted (not confirmed) period range.
  @override
  @JsonKey()
  final bool isPredicted;

  /// Day number within the current cycle (1-based). Null if no cycle data.
  @override
  final int? cycleDay;

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DayDataModelCopyWith<_DayDataModel> get copyWith =>
      __$DayDataModelCopyWithImpl<_DayDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DayDataModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DayDataModel &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.periodLog, periodLog) ||
                other.periodLog == periodLog) &&
            const DeepCollectionEquality()
                .equals(other._symptomEntries, _symptomEntries) &&
            (identical(other.dailyNote, dailyNote) ||
                other.dailyNote == dailyNote) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.isPredicted, isPredicted) ||
                other.isPredicted == isPredicted) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      periodLog,
      const DeepCollectionEquality().hash(_symptomEntries),
      dailyNote,
      phase,
      isPredicted,
      cycleDay);

  @override
  String toString() {
    return 'DayDataModel(date: $date, periodLog: $periodLog, symptomEntries: $symptomEntries, dailyNote: $dailyNote, phase: $phase, isPredicted: $isPredicted, cycleDay: $cycleDay)';
  }
}

/// @nodoc
abstract mixin class _$DayDataModelCopyWith<$Res>
    implements $DayDataModelCopyWith<$Res> {
  factory _$DayDataModelCopyWith(
          _DayDataModel value, $Res Function(_DayDataModel) _then) =
      __$DayDataModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime date,
      PeriodLogModel? periodLog,
      List<SymptomEntryModel> symptomEntries,
      DailyNoteModel? dailyNote,
      CyclePhase? phase,
      bool isPredicted,
      int? cycleDay});

  @override
  $PeriodLogModelCopyWith<$Res>? get periodLog;
  @override
  $DailyNoteModelCopyWith<$Res>? get dailyNote;
}

/// @nodoc
class __$DayDataModelCopyWithImpl<$Res>
    implements _$DayDataModelCopyWith<$Res> {
  __$DayDataModelCopyWithImpl(this._self, this._then);

  final _DayDataModel _self;
  final $Res Function(_DayDataModel) _then;

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? periodLog = freezed,
    Object? symptomEntries = null,
    Object? dailyNote = freezed,
    Object? phase = freezed,
    Object? isPredicted = null,
    Object? cycleDay = freezed,
  }) {
    return _then(_DayDataModel(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodLog: freezed == periodLog
          ? _self.periodLog
          : periodLog // ignore: cast_nullable_to_non_nullable
              as PeriodLogModel?,
      symptomEntries: null == symptomEntries
          ? _self._symptomEntries
          : symptomEntries // ignore: cast_nullable_to_non_nullable
              as List<SymptomEntryModel>,
      dailyNote: freezed == dailyNote
          ? _self.dailyNote
          : dailyNote // ignore: cast_nullable_to_non_nullable
              as DailyNoteModel?,
      phase: freezed == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as CyclePhase?,
      isPredicted: null == isPredicted
          ? _self.isPredicted
          : isPredicted // ignore: cast_nullable_to_non_nullable
              as bool,
      cycleDay: freezed == cycleDay
          ? _self.cycleDay
          : cycleDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PeriodLogModelCopyWith<$Res>? get periodLog {
    if (_self.periodLog == null) {
      return null;
    }

    return $PeriodLogModelCopyWith<$Res>(_self.periodLog!, (value) {
      return _then(_self.copyWith(periodLog: value));
    });
  }

  /// Create a copy of DayDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyNoteModelCopyWith<$Res>? get dailyNote {
    if (_self.dailyNote == null) {
      return null;
    }

    return $DailyNoteModelCopyWith<$Res>(_self.dailyNote!, (value) {
      return _then(_self.copyWith(dailyNote: value));
    });
  }
}

// dart format on
