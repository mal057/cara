// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CyclesTableTable extends CyclesTable
    with TableInfo<$CyclesTableTable, CyclesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CyclesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cycleLengthMeta =
      const VerificationMeta('cycleLength');
  @override
  late final GeneratedColumn<int> cycleLength = GeneratedColumn<int>(
      'cycle_length', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _periodLengthMeta =
      const VerificationMeta('periodLength');
  @override
  late final GeneratedColumn<int> periodLength = GeneratedColumn<int>(
      'period_length', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isPredictedMeta =
      const VerificationMeta('isPredicted');
  @override
  late final GeneratedColumn<int> isPredicted = GeneratedColumn<int>(
      'is_predicted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        startDate,
        endDate,
        cycleLength,
        periodLength,
        isPredicted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cycles';
  @override
  VerificationContext validateIntegrity(Insertable<CyclesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('cycle_length')) {
      context.handle(
          _cycleLengthMeta,
          cycleLength.isAcceptableOrUnknown(
              data['cycle_length']!, _cycleLengthMeta));
    }
    if (data.containsKey('period_length')) {
      context.handle(
          _periodLengthMeta,
          periodLength.isAcceptableOrUnknown(
              data['period_length']!, _periodLengthMeta));
    }
    if (data.containsKey('is_predicted')) {
      context.handle(
          _isPredictedMeta,
          isPredicted.isAcceptableOrUnknown(
              data['is_predicted']!, _isPredictedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CyclesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CyclesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      cycleLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cycle_length']),
      periodLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}period_length']),
      isPredicted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_predicted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CyclesTableTable createAlias(String alias) {
    return $CyclesTableTable(attachedDatabase, alias);
  }
}

class CyclesTableData extends DataClass implements Insertable<CyclesTableData> {
  /// Auto-incrementing primary key.
  final int id;

  /// ISO 8601 date of cycle start (first day of period). NOT NULL, UNIQUE.
  final String startDate;

  /// ISO 8601 date of cycle end (day before next period). NULL while ongoing.
  final String? endDate;

  /// Computed cycle length in days (end_date - start_date + 1).
  /// NULL until the cycle is closed.
  final int? cycleLength;

  /// Number of period days in this cycle. NULL until cycle is closed.
  final int? periodLength;

  /// 1 = this is a predicted (not user-confirmed) cycle. Default 0.
  /// Enforced as 0/1 by CHECK constraint in customConstraints.
  final int isPredicted;

  /// ISO 8601 timestamp — set once on insert.
  final String createdAt;

  /// ISO 8601 timestamp — updated on every write.
  final String updatedAt;
  const CyclesTableData(
      {required this.id,
      required this.startDate,
      this.endDate,
      this.cycleLength,
      this.periodLength,
      required this.isPredicted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date'] = Variable<String>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    if (!nullToAbsent || cycleLength != null) {
      map['cycle_length'] = Variable<int>(cycleLength);
    }
    if (!nullToAbsent || periodLength != null) {
      map['period_length'] = Variable<int>(periodLength);
    }
    map['is_predicted'] = Variable<int>(isPredicted);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  CyclesTableCompanion toCompanion(bool nullToAbsent) {
    return CyclesTableCompanion(
      id: Value(id),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      cycleLength: cycleLength == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleLength),
      periodLength: periodLength == null && nullToAbsent
          ? const Value.absent()
          : Value(periodLength),
      isPredicted: Value(isPredicted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CyclesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CyclesTableData(
      id: serializer.fromJson<int>(json['id']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      cycleLength: serializer.fromJson<int?>(json['cycleLength']),
      periodLength: serializer.fromJson<int?>(json['periodLength']),
      isPredicted: serializer.fromJson<int>(json['isPredicted']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
      'cycleLength': serializer.toJson<int?>(cycleLength),
      'periodLength': serializer.toJson<int?>(periodLength),
      'isPredicted': serializer.toJson<int>(isPredicted),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  CyclesTableData copyWith(
          {int? id,
          String? startDate,
          Value<String?> endDate = const Value.absent(),
          Value<int?> cycleLength = const Value.absent(),
          Value<int?> periodLength = const Value.absent(),
          int? isPredicted,
          String? createdAt,
          String? updatedAt}) =>
      CyclesTableData(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        cycleLength: cycleLength.present ? cycleLength.value : this.cycleLength,
        periodLength:
            periodLength.present ? periodLength.value : this.periodLength,
        isPredicted: isPredicted ?? this.isPredicted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CyclesTableData copyWithCompanion(CyclesTableCompanion data) {
    return CyclesTableData(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      cycleLength:
          data.cycleLength.present ? data.cycleLength.value : this.cycleLength,
      periodLength: data.periodLength.present
          ? data.periodLength.value
          : this.periodLength,
      isPredicted:
          data.isPredicted.present ? data.isPredicted.value : this.isPredicted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CyclesTableData(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('cycleLength: $cycleLength, ')
          ..write('periodLength: $periodLength, ')
          ..write('isPredicted: $isPredicted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startDate, endDate, cycleLength,
      periodLength, isPredicted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CyclesTableData &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.cycleLength == this.cycleLength &&
          other.periodLength == this.periodLength &&
          other.isPredicted == this.isPredicted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CyclesTableCompanion extends UpdateCompanion<CyclesTableData> {
  final Value<int> id;
  final Value<String> startDate;
  final Value<String?> endDate;
  final Value<int?> cycleLength;
  final Value<int?> periodLength;
  final Value<int> isPredicted;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const CyclesTableCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.cycleLength = const Value.absent(),
    this.periodLength = const Value.absent(),
    this.isPredicted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CyclesTableCompanion.insert({
    this.id = const Value.absent(),
    required String startDate,
    this.endDate = const Value.absent(),
    this.cycleLength = const Value.absent(),
    this.periodLength = const Value.absent(),
    this.isPredicted = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  })  : startDate = Value(startDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CyclesTableData> custom({
    Expression<int>? id,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<int>? cycleLength,
    Expression<int>? periodLength,
    Expression<int>? isPredicted,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (cycleLength != null) 'cycle_length': cycleLength,
      if (periodLength != null) 'period_length': periodLength,
      if (isPredicted != null) 'is_predicted': isPredicted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CyclesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? startDate,
      Value<String?>? endDate,
      Value<int?>? cycleLength,
      Value<int?>? periodLength,
      Value<int>? isPredicted,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return CyclesTableCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      isPredicted: isPredicted ?? this.isPredicted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (cycleLength.present) {
      map['cycle_length'] = Variable<int>(cycleLength.value);
    }
    if (periodLength.present) {
      map['period_length'] = Variable<int>(periodLength.value);
    }
    if (isPredicted.present) {
      map['is_predicted'] = Variable<int>(isPredicted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CyclesTableCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('cycleLength: $cycleLength, ')
          ..write('periodLength: $periodLength, ')
          ..write('isPredicted: $isPredicted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PeriodLogsTableTable extends PeriodLogsTable
    with TableInfo<$PeriodLogsTableTable, PeriodLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _cycleIdMeta =
      const VerificationMeta('cycleId');
  @override
  late final GeneratedColumn<int> cycleId = GeneratedColumn<int>(
      'cycle_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cycles (id)'));
  static const VerificationMeta _flowIntensityMeta =
      const VerificationMeta('flowIntensity');
  @override
  late final GeneratedColumn<String> flowIntensity = GeneratedColumn<String>(
      'flow_intensity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _flowColorMeta =
      const VerificationMeta('flowColor');
  @override
  late final GeneratedColumn<String> flowColor = GeneratedColumn<String>(
      'flow_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, cycleId, flowIntensity, flowColor, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'period_logs';
  @override
  VerificationContext validateIntegrity(
      Insertable<PeriodLogsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('cycle_id')) {
      context.handle(_cycleIdMeta,
          cycleId.isAcceptableOrUnknown(data['cycle_id']!, _cycleIdMeta));
    }
    if (data.containsKey('flow_intensity')) {
      context.handle(
          _flowIntensityMeta,
          flowIntensity.isAcceptableOrUnknown(
              data['flow_intensity']!, _flowIntensityMeta));
    } else if (isInserting) {
      context.missing(_flowIntensityMeta);
    }
    if (data.containsKey('flow_color')) {
      context.handle(_flowColorMeta,
          flowColor.isAcceptableOrUnknown(data['flow_color']!, _flowColorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeriodLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodLogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      cycleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cycle_id']),
      flowIntensity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flow_intensity'])!,
      flowColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flow_color']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PeriodLogsTableTable createAlias(String alias) {
    return $PeriodLogsTableTable(attachedDatabase, alias);
  }
}

class PeriodLogsTableData extends DataClass
    implements Insertable<PeriodLogsTableData> {
  /// Auto-incrementing primary key.
  final int id;

  /// ISO 8601 date. NOT NULL, UNIQUE — only one log entry per calendar day.
  final String date;

  /// Foreign key to cycles.id. NULL if this log is not yet assigned to a cycle
  /// (e.g. entered before the cycle row is created).
  final int? cycleId;

  /// Flow intensity: 'light', 'medium', or 'heavy'. NOT NULL.
  final String flowIntensity;

  /// Flow color: 'red', 'dark_red', 'brown', or 'pink'. Nullable.
  final String? flowColor;

  /// ISO 8601 timestamp — set once on insert.
  final String createdAt;

  /// ISO 8601 timestamp — updated on every write.
  final String updatedAt;
  const PeriodLogsTableData(
      {required this.id,
      required this.date,
      this.cycleId,
      required this.flowIntensity,
      this.flowColor,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || cycleId != null) {
      map['cycle_id'] = Variable<int>(cycleId);
    }
    map['flow_intensity'] = Variable<String>(flowIntensity);
    if (!nullToAbsent || flowColor != null) {
      map['flow_color'] = Variable<String>(flowColor);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  PeriodLogsTableCompanion toCompanion(bool nullToAbsent) {
    return PeriodLogsTableCompanion(
      id: Value(id),
      date: Value(date),
      cycleId: cycleId == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleId),
      flowIntensity: Value(flowIntensity),
      flowColor: flowColor == null && nullToAbsent
          ? const Value.absent()
          : Value(flowColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PeriodLogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodLogsTableData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      cycleId: serializer.fromJson<int?>(json['cycleId']),
      flowIntensity: serializer.fromJson<String>(json['flowIntensity']),
      flowColor: serializer.fromJson<String?>(json['flowColor']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'cycleId': serializer.toJson<int?>(cycleId),
      'flowIntensity': serializer.toJson<String>(flowIntensity),
      'flowColor': serializer.toJson<String?>(flowColor),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  PeriodLogsTableData copyWith(
          {int? id,
          String? date,
          Value<int?> cycleId = const Value.absent(),
          String? flowIntensity,
          Value<String?> flowColor = const Value.absent(),
          String? createdAt,
          String? updatedAt}) =>
      PeriodLogsTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        cycleId: cycleId.present ? cycleId.value : this.cycleId,
        flowIntensity: flowIntensity ?? this.flowIntensity,
        flowColor: flowColor.present ? flowColor.value : this.flowColor,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PeriodLogsTableData copyWithCompanion(PeriodLogsTableCompanion data) {
    return PeriodLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      cycleId: data.cycleId.present ? data.cycleId.value : this.cycleId,
      flowIntensity: data.flowIntensity.present
          ? data.flowIntensity.value
          : this.flowIntensity,
      flowColor: data.flowColor.present ? data.flowColor.value : this.flowColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodLogsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('cycleId: $cycleId, ')
          ..write('flowIntensity: $flowIntensity, ')
          ..write('flowColor: $flowColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, cycleId, flowIntensity, flowColor, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodLogsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.cycleId == this.cycleId &&
          other.flowIntensity == this.flowIntensity &&
          other.flowColor == this.flowColor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PeriodLogsTableCompanion extends UpdateCompanion<PeriodLogsTableData> {
  final Value<int> id;
  final Value<String> date;
  final Value<int?> cycleId;
  final Value<String> flowIntensity;
  final Value<String?> flowColor;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const PeriodLogsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.cycleId = const Value.absent(),
    this.flowIntensity = const Value.absent(),
    this.flowColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PeriodLogsTableCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    this.cycleId = const Value.absent(),
    required String flowIntensity,
    this.flowColor = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  })  : date = Value(date),
        flowIntensity = Value(flowIntensity),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PeriodLogsTableData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<int>? cycleId,
    Expression<String>? flowIntensity,
    Expression<String>? flowColor,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (cycleId != null) 'cycle_id': cycleId,
      if (flowIntensity != null) 'flow_intensity': flowIntensity,
      if (flowColor != null) 'flow_color': flowColor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PeriodLogsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<int?>? cycleId,
      Value<String>? flowIntensity,
      Value<String?>? flowColor,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return PeriodLogsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      cycleId: cycleId ?? this.cycleId,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      flowColor: flowColor ?? this.flowColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (cycleId.present) {
      map['cycle_id'] = Variable<int>(cycleId.value);
    }
    if (flowIntensity.present) {
      map['flow_intensity'] = Variable<String>(flowIntensity.value);
    }
    if (flowColor.present) {
      map['flow_color'] = Variable<String>(flowColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeriodLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('cycleId: $cycleId, ')
          ..write('flowIntensity: $flowIntensity, ')
          ..write('flowColor: $flowColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTableTable extends SymptomsTable
    with TableInfo<$SymptomsTableTable, SymptomsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, iconName, emoji, displayOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    } else if (isInserting) {
      context.missing(_iconNameMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji']),
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
    );
  }

  @override
  $SymptomsTableTable createAlias(String alias) {
    return $SymptomsTableTable(attachedDatabase, alias);
  }
}

class SymptomsTableData extends DataClass
    implements Insertable<SymptomsTableData> {
  /// Auto-incrementing primary key. The numeric ID is stable — it is the
  /// canonical symptom type identifier used by symptom_entries.
  final int id;

  /// Human-readable symptom name (e.g. 'headache'). NOT NULL, UNIQUE.
  final String name;

  /// Category group: 'mood', 'pain', 'energy', 'skin', 'digestion',
  /// 'sleep', or 'other'. NOT NULL.
  final String category;

  /// Flutter icon identifier string (e.g. 'Icons.mood'). NOT NULL.
  final String iconName;

  /// Optional emoji string for mood symptoms. NULL for non-mood symptoms.
  final String? emoji;

  /// Sort order for display in the symptom grid. NOT NULL.
  final int displayOrder;
  const SymptomsTableData(
      {required this.id,
      required this.name,
      required this.category,
      required this.iconName,
      this.emoji,
      required this.displayOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['icon_name'] = Variable<String>(iconName);
    if (!nullToAbsent || emoji != null) {
      map['emoji'] = Variable<String>(emoji);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  SymptomsTableCompanion toCompanion(bool nullToAbsent) {
    return SymptomsTableCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      iconName: Value(iconName),
      emoji:
          emoji == null && nullToAbsent ? const Value.absent() : Value(emoji),
      displayOrder: Value(displayOrder),
    );
  }

  factory SymptomsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      iconName: serializer.fromJson<String>(json['iconName']),
      emoji: serializer.fromJson<String?>(json['emoji']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'iconName': serializer.toJson<String>(iconName),
      'emoji': serializer.toJson<String?>(emoji),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  SymptomsTableData copyWith(
          {int? id,
          String? name,
          String? category,
          String? iconName,
          Value<String?> emoji = const Value.absent(),
          int? displayOrder}) =>
      SymptomsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        iconName: iconName ?? this.iconName,
        emoji: emoji.present ? emoji.value : this.emoji,
        displayOrder: displayOrder ?? this.displayOrder,
      );
  SymptomsTableData copyWithCompanion(SymptomsTableCompanion data) {
    return SymptomsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('iconName: $iconName, ')
          ..write('emoji: $emoji, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, iconName, emoji, displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.iconName == this.iconName &&
          other.emoji == this.emoji &&
          other.displayOrder == this.displayOrder);
}

class SymptomsTableCompanion extends UpdateCompanion<SymptomsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> iconName;
  final Value<String?> emoji;
  final Value<int> displayOrder;
  const SymptomsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.iconName = const Value.absent(),
    this.emoji = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  SymptomsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String iconName,
    this.emoji = const Value.absent(),
    required int displayOrder,
  })  : name = Value(name),
        category = Value(category),
        iconName = Value(iconName),
        displayOrder = Value(displayOrder);
  static Insertable<SymptomsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? iconName,
    Expression<String>? emoji,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (iconName != null) 'icon_name': iconName,
      if (emoji != null) 'emoji': emoji,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  SymptomsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? iconName,
      Value<String?>? emoji,
      Value<int>? displayOrder}) {
    return SymptomsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      iconName: iconName ?? this.iconName,
      emoji: emoji ?? this.emoji,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('iconName: $iconName, ')
          ..write('emoji: $emoji, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $SymptomEntriesTableTable extends SymptomEntriesTable
    with TableInfo<$SymptomEntriesTableTable, SymptomEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _symptomIdMeta =
      const VerificationMeta('symptomId');
  @override
  late final GeneratedColumn<int> symptomId = GeneratedColumn<int>(
      'symptom_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES symptoms (id)'));
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
      'severity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, symptomId, severity, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_entries';
  @override
  VerificationContext validateIntegrity(
      Insertable<SymptomEntriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('symptom_id')) {
      context.handle(_symptomIdMeta,
          symptomId.isAcceptableOrUnknown(data['symptom_id']!, _symptomIdMeta));
    } else if (isInserting) {
      context.missing(_symptomIdMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomEntriesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomEntriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      symptomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}symptom_id'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}severity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SymptomEntriesTableTable createAlias(String alias) {
    return $SymptomEntriesTableTable(attachedDatabase, alias);
  }
}

class SymptomEntriesTableData extends DataClass
    implements Insertable<SymptomEntriesTableData> {
  /// Auto-incrementing primary key.
  final int id;

  /// ISO 8601 date of the log entry. NOT NULL.
  /// Not UNIQUE — a user can log multiple symptoms for the same date.
  final String date;

  /// Foreign key to symptoms.id. NOT NULL.
  final int symptomId;

  /// Severity level: 1 = mild, 2 = moderate, 3 = severe.
  /// Enforced as CHECK (severity BETWEEN 1 AND 3) via customConstraints.
  final int severity;

  /// ISO 8601 timestamp — set once on insert.
  final String createdAt;
  const SymptomEntriesTableData(
      {required this.id,
      required this.date,
      required this.symptomId,
      required this.severity,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['symptom_id'] = Variable<int>(symptomId);
    map['severity'] = Variable<int>(severity);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  SymptomEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return SymptomEntriesTableCompanion(
      id: Value(id),
      date: Value(date),
      symptomId: Value(symptomId),
      severity: Value(severity),
      createdAt: Value(createdAt),
    );
  }

  factory SymptomEntriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomEntriesTableData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      symptomId: serializer.fromJson<int>(json['symptomId']),
      severity: serializer.fromJson<int>(json['severity']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'symptomId': serializer.toJson<int>(symptomId),
      'severity': serializer.toJson<int>(severity),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  SymptomEntriesTableData copyWith(
          {int? id,
          String? date,
          int? symptomId,
          int? severity,
          String? createdAt}) =>
      SymptomEntriesTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        symptomId: symptomId ?? this.symptomId,
        severity: severity ?? this.severity,
        createdAt: createdAt ?? this.createdAt,
      );
  SymptomEntriesTableData copyWithCompanion(SymptomEntriesTableCompanion data) {
    return SymptomEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      symptomId: data.symptomId.present ? data.symptomId.value : this.symptomId,
      severity: data.severity.present ? data.severity.value : this.severity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntriesTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('symptomId: $symptomId, ')
          ..write('severity: $severity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, symptomId, severity, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomEntriesTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.symptomId == this.symptomId &&
          other.severity == this.severity &&
          other.createdAt == this.createdAt);
}

class SymptomEntriesTableCompanion
    extends UpdateCompanion<SymptomEntriesTableData> {
  final Value<int> id;
  final Value<String> date;
  final Value<int> symptomId;
  final Value<int> severity;
  final Value<String> createdAt;
  const SymptomEntriesTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.symptomId = const Value.absent(),
    this.severity = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SymptomEntriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required int symptomId,
    required int severity,
    required String createdAt,
  })  : date = Value(date),
        symptomId = Value(symptomId),
        severity = Value(severity),
        createdAt = Value(createdAt);
  static Insertable<SymptomEntriesTableData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<int>? symptomId,
    Expression<int>? severity,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (symptomId != null) 'symptom_id': symptomId,
      if (severity != null) 'severity': severity,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SymptomEntriesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<int>? symptomId,
      Value<int>? severity,
      Value<String>? createdAt}) {
    return SymptomEntriesTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      symptomId: symptomId ?? this.symptomId,
      severity: severity ?? this.severity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (symptomId.present) {
      map['symptom_id'] = Variable<int>(symptomId.value);
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('symptomId: $symptomId, ')
          ..write('severity: $severity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyNotesTableTable extends DailyNotesTable
    with TableInfo<$DailyNotesTableTable, DailyNotesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyNotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, content, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_notes';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyNotesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyNotesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyNotesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyNotesTableTable createAlias(String alias) {
    return $DailyNotesTableTable(attachedDatabase, alias);
  }
}

class DailyNotesTableData extends DataClass
    implements Insertable<DailyNotesTableData> {
  /// Auto-incrementing primary key.
  final int id;

  /// ISO 8601 date. NOT NULL, UNIQUE — one note per calendar day.
  final String date;

  /// Free-form note text. Max 500 characters enforced at the application layer
  /// (NoteInput widget char counter). NOT NULL.
  final String content;

  /// ISO 8601 timestamp — set once on insert.
  final String createdAt;

  /// ISO 8601 timestamp — updated on every upsert.
  final String updatedAt;
  const DailyNotesTableData(
      {required this.id,
      required this.date,
      required this.content,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  DailyNotesTableCompanion toCompanion(bool nullToAbsent) {
    return DailyNotesTableCompanion(
      id: Value(id),
      date: Value(date),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyNotesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyNotesTableData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  DailyNotesTableData copyWith(
          {int? id,
          String? date,
          String? content,
          String? createdAt,
          String? updatedAt}) =>
      DailyNotesTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyNotesTableData copyWithCompanion(DailyNotesTableCompanion data) {
    return DailyNotesTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyNotesTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, content, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyNotesTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyNotesTableCompanion extends UpdateCompanion<DailyNotesTableData> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> content;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const DailyNotesTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyNotesTableCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String content,
    required String createdAt,
    required String updatedAt,
  })  : date = Value(date),
        content = Value(content),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DailyNotesTableData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? content,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyNotesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? content,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return DailyNotesTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyNotesTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  /// Setting key (e.g. 'default_cycle_length'). Primary key — NOT NULL.
  final String key;

  /// Setting value, JSON-encoded string. NOT NULL.
  final String value;

  /// ISO 8601 timestamp — updated on every write.
  final String updatedAt;
  const SettingsTableData(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  SettingsTableData copyWith({String? key, String? value, String? updatedAt}) =>
      SettingsTableData(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingsTableData copyWithCompanion(SettingsTableCompanion data) {
    return SettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String key,
    required String value,
    required String updatedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        updatedAt = Value(updatedAt);
  static Insertable<SettingsTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<String>? updatedAt,
      Value<int>? rowid}) {
    return SettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPreferencesTableTable extends NotificationPreferencesTable
    with
        TableInfo<$NotificationPreferencesTableTable,
            NotificationPreferencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<int> enabled = GeneratedColumn<int>(
      'enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timeOfDayMeta =
      const VerificationMeta('timeOfDay');
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
      'time_of_day', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _daysBeforeMeta =
      const VerificationMeta('daysBefore');
  @override
  late final GeneratedColumn<int> daysBefore = GeneratedColumn<int>(
      'days_before', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, enabled, timeOfDay, daysBefore, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_preferences';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationPreferencesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
          _timeOfDayMeta,
          timeOfDay.isAcceptableOrUnknown(
              data['time_of_day']!, _timeOfDayMeta));
    }
    if (data.containsKey('days_before')) {
      context.handle(
          _daysBeforeMeta,
          daysBefore.isAcceptableOrUnknown(
              data['days_before']!, _daysBeforeMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationPreferencesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPreferencesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}enabled'])!,
      timeOfDay: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_of_day']),
      daysBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}days_before']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NotificationPreferencesTableTable createAlias(String alias) {
    return $NotificationPreferencesTableTable(attachedDatabase, alias);
  }
}

class NotificationPreferencesTableData extends DataClass
    implements Insertable<NotificationPreferencesTableData> {
  /// Auto-incrementing primary key.
  final int id;

  /// Notification type identifier: 'period_approaching', 'fertile_window',
  /// or 'daily_reminder'. NOT NULL, UNIQUE.
  final String type;

  /// Whether this notification type is enabled. 1 = enabled, 0 = disabled.
  /// Default 0 (off). Enforced as CHECK (enabled IN (0, 1)).
  final int enabled;

  /// HH:MM time string for the daily reminder (e.g. '21:00'). Nullable —
  /// only relevant for 'daily_reminder' type.
  final String? timeOfDay;

  /// Days before the predicted event to fire the notification. Nullable —
  /// only relevant for 'period_approaching' and 'fertile_window' types.
  final int? daysBefore;

  /// ISO 8601 timestamp — updated on every write.
  final String updatedAt;
  const NotificationPreferencesTableData(
      {required this.id,
      required this.type,
      required this.enabled,
      this.timeOfDay,
      this.daysBefore,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['enabled'] = Variable<int>(enabled);
    if (!nullToAbsent || timeOfDay != null) {
      map['time_of_day'] = Variable<String>(timeOfDay);
    }
    if (!nullToAbsent || daysBefore != null) {
      map['days_before'] = Variable<int>(daysBefore);
    }
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  NotificationPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationPreferencesTableCompanion(
      id: Value(id),
      type: Value(type),
      enabled: Value(enabled),
      timeOfDay: timeOfDay == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOfDay),
      daysBefore: daysBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(daysBefore),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationPreferencesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPreferencesTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      enabled: serializer.fromJson<int>(json['enabled']),
      timeOfDay: serializer.fromJson<String?>(json['timeOfDay']),
      daysBefore: serializer.fromJson<int?>(json['daysBefore']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'enabled': serializer.toJson<int>(enabled),
      'timeOfDay': serializer.toJson<String?>(timeOfDay),
      'daysBefore': serializer.toJson<int?>(daysBefore),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  NotificationPreferencesTableData copyWith(
          {int? id,
          String? type,
          int? enabled,
          Value<String?> timeOfDay = const Value.absent(),
          Value<int?> daysBefore = const Value.absent(),
          String? updatedAt}) =>
      NotificationPreferencesTableData(
        id: id ?? this.id,
        type: type ?? this.type,
        enabled: enabled ?? this.enabled,
        timeOfDay: timeOfDay.present ? timeOfDay.value : this.timeOfDay,
        daysBefore: daysBefore.present ? daysBefore.value : this.daysBefore,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  NotificationPreferencesTableData copyWithCompanion(
      NotificationPreferencesTableCompanion data) {
    return NotificationPreferencesTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      daysBefore:
          data.daysBefore.present ? data.daysBefore.value : this.daysBefore,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('enabled: $enabled, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, enabled, timeOfDay, daysBefore, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPreferencesTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.enabled == this.enabled &&
          other.timeOfDay == this.timeOfDay &&
          other.daysBefore == this.daysBefore &&
          other.updatedAt == this.updatedAt);
}

class NotificationPreferencesTableCompanion
    extends UpdateCompanion<NotificationPreferencesTableData> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> enabled;
  final Value<String?> timeOfDay;
  final Value<int?> daysBefore;
  final Value<String> updatedAt;
  const NotificationPreferencesTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.enabled = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.daysBefore = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotificationPreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    this.enabled = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.daysBefore = const Value.absent(),
    required String updatedAt,
  })  : type = Value(type),
        updatedAt = Value(updatedAt);
  static Insertable<NotificationPreferencesTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? enabled,
    Expression<String>? timeOfDay,
    Expression<int>? daysBefore,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (enabled != null) 'enabled': enabled,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (daysBefore != null) 'days_before': daysBefore,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotificationPreferencesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<int>? enabled,
      Value<String?>? timeOfDay,
      Value<int?>? daysBefore,
      Value<String>? updatedAt}) {
    return NotificationPreferencesTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      enabled: enabled ?? this.enabled,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      daysBefore: daysBefore ?? this.daysBefore,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<int>(enabled.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (daysBefore.present) {
      map['days_before'] = Variable<int>(daysBefore.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('enabled: $enabled, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CyclesTableTable cyclesTable = $CyclesTableTable(this);
  late final $PeriodLogsTableTable periodLogsTable =
      $PeriodLogsTableTable(this);
  late final $SymptomsTableTable symptomsTable = $SymptomsTableTable(this);
  late final $SymptomEntriesTableTable symptomEntriesTable =
      $SymptomEntriesTableTable(this);
  late final $DailyNotesTableTable dailyNotesTable =
      $DailyNotesTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $NotificationPreferencesTableTable notificationPreferencesTable =
      $NotificationPreferencesTableTable(this);
  late final Index idxCyclesStartDate = Index('idx_cycles_start_date',
      'CREATE INDEX idx_cycles_start_date ON cycles (start_date)');
  late final Index idxPeriodLogsDate = Index('idx_period_logs_date',
      'CREATE INDEX idx_period_logs_date ON period_logs (date)');
  late final Index idxPeriodLogsCycleId = Index('idx_period_logs_cycle_id',
      'CREATE INDEX idx_period_logs_cycle_id ON period_logs (cycle_id)');
  late final Index idxSymptomEntriesDateSymptomId = Index(
      'idx_symptom_entries_date_symptom_id',
      'CREATE INDEX idx_symptom_entries_date_symptom_id ON symptom_entries (date, symptom_id)');
  late final Index idxDailyNotesDate = Index('idx_daily_notes_date',
      'CREATE INDEX idx_daily_notes_date ON daily_notes (date)');
  late final Index idxNotificationPreferencesType = Index(
      'idx_notification_preferences_type',
      'CREATE INDEX idx_notification_preferences_type ON notification_preferences (type)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        cyclesTable,
        periodLogsTable,
        symptomsTable,
        symptomEntriesTable,
        dailyNotesTable,
        settingsTable,
        notificationPreferencesTable,
        idxCyclesStartDate,
        idxPeriodLogsDate,
        idxPeriodLogsCycleId,
        idxSymptomEntriesDateSymptomId,
        idxDailyNotesDate,
        idxNotificationPreferencesType
      ];
}

typedef $$CyclesTableTableCreateCompanionBuilder = CyclesTableCompanion
    Function({
  Value<int> id,
  required String startDate,
  Value<String?> endDate,
  Value<int?> cycleLength,
  Value<int?> periodLength,
  Value<int> isPredicted,
  required String createdAt,
  required String updatedAt,
});
typedef $$CyclesTableTableUpdateCompanionBuilder = CyclesTableCompanion
    Function({
  Value<int> id,
  Value<String> startDate,
  Value<String?> endDate,
  Value<int?> cycleLength,
  Value<int?> periodLength,
  Value<int> isPredicted,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$CyclesTableTableReferences
    extends BaseReferences<_$AppDatabase, $CyclesTableTable, CyclesTableData> {
  $$CyclesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PeriodLogsTableTable, List<PeriodLogsTableData>>
      _periodLogsTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.periodLogsTable,
              aliasName: $_aliasNameGenerator(
                  db.cyclesTable.id, db.periodLogsTable.cycleId));

  $$PeriodLogsTableTableProcessedTableManager get periodLogsTableRefs {
    final manager =
        $$PeriodLogsTableTableTableManager($_db, $_db.periodLogsTable)
            .filter((f) => f.cycleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_periodLogsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CyclesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CyclesTableTable> {
  $$CyclesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cycleLength => $composableBuilder(
      column: $table.cycleLength, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get periodLength => $composableBuilder(
      column: $table.periodLength, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isPredicted => $composableBuilder(
      column: $table.isPredicted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> periodLogsTableRefs(
      Expression<bool> Function($$PeriodLogsTableTableFilterComposer f) f) {
    final $$PeriodLogsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.periodLogsTable,
        getReferencedColumn: (t) => t.cycleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PeriodLogsTableTableFilterComposer(
              $db: $db,
              $table: $db.periodLogsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CyclesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CyclesTableTable> {
  $$CyclesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cycleLength => $composableBuilder(
      column: $table.cycleLength, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get periodLength => $composableBuilder(
      column: $table.periodLength,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isPredicted => $composableBuilder(
      column: $table.isPredicted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CyclesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CyclesTableTable> {
  $$CyclesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get cycleLength => $composableBuilder(
      column: $table.cycleLength, builder: (column) => column);

  GeneratedColumn<int> get periodLength => $composableBuilder(
      column: $table.periodLength, builder: (column) => column);

  GeneratedColumn<int> get isPredicted => $composableBuilder(
      column: $table.isPredicted, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> periodLogsTableRefs<T extends Object>(
      Expression<T> Function($$PeriodLogsTableTableAnnotationComposer a) f) {
    final $$PeriodLogsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.periodLogsTable,
        getReferencedColumn: (t) => t.cycleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PeriodLogsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.periodLogsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CyclesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CyclesTableTable,
    CyclesTableData,
    $$CyclesTableTableFilterComposer,
    $$CyclesTableTableOrderingComposer,
    $$CyclesTableTableAnnotationComposer,
    $$CyclesTableTableCreateCompanionBuilder,
    $$CyclesTableTableUpdateCompanionBuilder,
    (CyclesTableData, $$CyclesTableTableReferences),
    CyclesTableData,
    PrefetchHooks Function({bool periodLogsTableRefs})> {
  $$CyclesTableTableTableManager(_$AppDatabase db, $CyclesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CyclesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CyclesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CyclesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> startDate = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            Value<int?> cycleLength = const Value.absent(),
            Value<int?> periodLength = const Value.absent(),
            Value<int> isPredicted = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              CyclesTableCompanion(
            id: id,
            startDate: startDate,
            endDate: endDate,
            cycleLength: cycleLength,
            periodLength: periodLength,
            isPredicted: isPredicted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String startDate,
            Value<String?> endDate = const Value.absent(),
            Value<int?> cycleLength = const Value.absent(),
            Value<int?> periodLength = const Value.absent(),
            Value<int> isPredicted = const Value.absent(),
            required String createdAt,
            required String updatedAt,
          }) =>
              CyclesTableCompanion.insert(
            id: id,
            startDate: startDate,
            endDate: endDate,
            cycleLength: cycleLength,
            periodLength: periodLength,
            isPredicted: isPredicted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CyclesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({periodLogsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (periodLogsTableRefs) db.periodLogsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (periodLogsTableRefs)
                    await $_getPrefetchedData<CyclesTableData,
                            $CyclesTableTable, PeriodLogsTableData>(
                        currentTable: table,
                        referencedTable: $$CyclesTableTableReferences
                            ._periodLogsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CyclesTableTableReferences(db, table, p0)
                                .periodLogsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cycleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CyclesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CyclesTableTable,
    CyclesTableData,
    $$CyclesTableTableFilterComposer,
    $$CyclesTableTableOrderingComposer,
    $$CyclesTableTableAnnotationComposer,
    $$CyclesTableTableCreateCompanionBuilder,
    $$CyclesTableTableUpdateCompanionBuilder,
    (CyclesTableData, $$CyclesTableTableReferences),
    CyclesTableData,
    PrefetchHooks Function({bool periodLogsTableRefs})>;
typedef $$PeriodLogsTableTableCreateCompanionBuilder = PeriodLogsTableCompanion
    Function({
  Value<int> id,
  required String date,
  Value<int?> cycleId,
  required String flowIntensity,
  Value<String?> flowColor,
  required String createdAt,
  required String updatedAt,
});
typedef $$PeriodLogsTableTableUpdateCompanionBuilder = PeriodLogsTableCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<int?> cycleId,
  Value<String> flowIntensity,
  Value<String?> flowColor,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$PeriodLogsTableTableReferences extends BaseReferences<
    _$AppDatabase, $PeriodLogsTableTable, PeriodLogsTableData> {
  $$PeriodLogsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CyclesTableTable _cycleIdTable(_$AppDatabase db) =>
      db.cyclesTable.createAlias(
          $_aliasNameGenerator(db.periodLogsTable.cycleId, db.cyclesTable.id));

  $$CyclesTableTableProcessedTableManager? get cycleId {
    final $_column = $_itemColumn<int>('cycle_id');
    if ($_column == null) return null;
    final manager = $$CyclesTableTableTableManager($_db, $_db.cyclesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cycleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PeriodLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PeriodLogsTableTable> {
  $$PeriodLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flowIntensity => $composableBuilder(
      column: $table.flowIntensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flowColor => $composableBuilder(
      column: $table.flowColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$CyclesTableTableFilterComposer get cycleId {
    final $$CyclesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cycleId,
        referencedTable: $db.cyclesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CyclesTableTableFilterComposer(
              $db: $db,
              $table: $db.cyclesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PeriodLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PeriodLogsTableTable> {
  $$PeriodLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flowIntensity => $composableBuilder(
      column: $table.flowIntensity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flowColor => $composableBuilder(
      column: $table.flowColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$CyclesTableTableOrderingComposer get cycleId {
    final $$CyclesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cycleId,
        referencedTable: $db.cyclesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CyclesTableTableOrderingComposer(
              $db: $db,
              $table: $db.cyclesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PeriodLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeriodLogsTableTable> {
  $$PeriodLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get flowIntensity => $composableBuilder(
      column: $table.flowIntensity, builder: (column) => column);

  GeneratedColumn<String> get flowColor =>
      $composableBuilder(column: $table.flowColor, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CyclesTableTableAnnotationComposer get cycleId {
    final $$CyclesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cycleId,
        referencedTable: $db.cyclesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CyclesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.cyclesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PeriodLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PeriodLogsTableTable,
    PeriodLogsTableData,
    $$PeriodLogsTableTableFilterComposer,
    $$PeriodLogsTableTableOrderingComposer,
    $$PeriodLogsTableTableAnnotationComposer,
    $$PeriodLogsTableTableCreateCompanionBuilder,
    $$PeriodLogsTableTableUpdateCompanionBuilder,
    (PeriodLogsTableData, $$PeriodLogsTableTableReferences),
    PeriodLogsTableData,
    PrefetchHooks Function({bool cycleId})> {
  $$PeriodLogsTableTableTableManager(
      _$AppDatabase db, $PeriodLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeriodLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeriodLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeriodLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int?> cycleId = const Value.absent(),
            Value<String> flowIntensity = const Value.absent(),
            Value<String?> flowColor = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              PeriodLogsTableCompanion(
            id: id,
            date: date,
            cycleId: cycleId,
            flowIntensity: flowIntensity,
            flowColor: flowColor,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            Value<int?> cycleId = const Value.absent(),
            required String flowIntensity,
            Value<String?> flowColor = const Value.absent(),
            required String createdAt,
            required String updatedAt,
          }) =>
              PeriodLogsTableCompanion.insert(
            id: id,
            date: date,
            cycleId: cycleId,
            flowIntensity: flowIntensity,
            flowColor: flowColor,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PeriodLogsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cycleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cycleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cycleId,
                    referencedTable:
                        $$PeriodLogsTableTableReferences._cycleIdTable(db),
                    referencedColumn:
                        $$PeriodLogsTableTableReferences._cycleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PeriodLogsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PeriodLogsTableTable,
    PeriodLogsTableData,
    $$PeriodLogsTableTableFilterComposer,
    $$PeriodLogsTableTableOrderingComposer,
    $$PeriodLogsTableTableAnnotationComposer,
    $$PeriodLogsTableTableCreateCompanionBuilder,
    $$PeriodLogsTableTableUpdateCompanionBuilder,
    (PeriodLogsTableData, $$PeriodLogsTableTableReferences),
    PeriodLogsTableData,
    PrefetchHooks Function({bool cycleId})>;
typedef $$SymptomsTableTableCreateCompanionBuilder = SymptomsTableCompanion
    Function({
  Value<int> id,
  required String name,
  required String category,
  required String iconName,
  Value<String?> emoji,
  required int displayOrder,
});
typedef $$SymptomsTableTableUpdateCompanionBuilder = SymptomsTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<String> iconName,
  Value<String?> emoji,
  Value<int> displayOrder,
});

final class $$SymptomsTableTableReferences extends BaseReferences<_$AppDatabase,
    $SymptomsTableTable, SymptomsTableData> {
  $$SymptomsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SymptomEntriesTableTable,
      List<SymptomEntriesTableData>> _symptomEntriesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.symptomEntriesTable,
          aliasName: $_aliasNameGenerator(
              db.symptomsTable.id, db.symptomEntriesTable.symptomId));

  $$SymptomEntriesTableTableProcessedTableManager get symptomEntriesTableRefs {
    final manager =
        $$SymptomEntriesTableTableTableManager($_db, $_db.symptomEntriesTable)
            .filter((f) => f.symptomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_symptomEntriesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SymptomsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomsTableTable> {
  $$SymptomsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> symptomEntriesTableRefs(
      Expression<bool> Function($$SymptomEntriesTableTableFilterComposer f) f) {
    final $$SymptomEntriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptomEntriesTable,
        getReferencedColumn: (t) => t.symptomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomEntriesTableTableFilterComposer(
              $db: $db,
              $table: $db.symptomEntriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SymptomsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomsTableTable> {
  $$SymptomsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$SymptomsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomsTableTable> {
  $$SymptomsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => column);

  Expression<T> symptomEntriesTableRefs<T extends Object>(
      Expression<T> Function($$SymptomEntriesTableTableAnnotationComposer a)
          f) {
    final $$SymptomEntriesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomEntriesTable,
            getReferencedColumn: (t) => t.symptomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomEntriesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.symptomEntriesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SymptomsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomsTableTable,
    SymptomsTableData,
    $$SymptomsTableTableFilterComposer,
    $$SymptomsTableTableOrderingComposer,
    $$SymptomsTableTableAnnotationComposer,
    $$SymptomsTableTableCreateCompanionBuilder,
    $$SymptomsTableTableUpdateCompanionBuilder,
    (SymptomsTableData, $$SymptomsTableTableReferences),
    SymptomsTableData,
    PrefetchHooks Function({bool symptomEntriesTableRefs})> {
  $$SymptomsTableTableTableManager(_$AppDatabase db, $SymptomsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> iconName = const Value.absent(),
            Value<String?> emoji = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
          }) =>
              SymptomsTableCompanion(
            id: id,
            name: name,
            category: category,
            iconName: iconName,
            emoji: emoji,
            displayOrder: displayOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String category,
            required String iconName,
            Value<String?> emoji = const Value.absent(),
            required int displayOrder,
          }) =>
              SymptomsTableCompanion.insert(
            id: id,
            name: name,
            category: category,
            iconName: iconName,
            emoji: emoji,
            displayOrder: displayOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SymptomsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({symptomEntriesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (symptomEntriesTableRefs) db.symptomEntriesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (symptomEntriesTableRefs)
                    await $_getPrefetchedData<SymptomsTableData,
                            $SymptomsTableTable, SymptomEntriesTableData>(
                        currentTable: table,
                        referencedTable: $$SymptomsTableTableReferences
                            ._symptomEntriesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SymptomsTableTableReferences(db, table, p0)
                                .symptomEntriesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.symptomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SymptomsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomsTableTable,
    SymptomsTableData,
    $$SymptomsTableTableFilterComposer,
    $$SymptomsTableTableOrderingComposer,
    $$SymptomsTableTableAnnotationComposer,
    $$SymptomsTableTableCreateCompanionBuilder,
    $$SymptomsTableTableUpdateCompanionBuilder,
    (SymptomsTableData, $$SymptomsTableTableReferences),
    SymptomsTableData,
    PrefetchHooks Function({bool symptomEntriesTableRefs})>;
typedef $$SymptomEntriesTableTableCreateCompanionBuilder
    = SymptomEntriesTableCompanion Function({
  Value<int> id,
  required String date,
  required int symptomId,
  required int severity,
  required String createdAt,
});
typedef $$SymptomEntriesTableTableUpdateCompanionBuilder
    = SymptomEntriesTableCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<int> symptomId,
  Value<int> severity,
  Value<String> createdAt,
});

final class $$SymptomEntriesTableTableReferences extends BaseReferences<
    _$AppDatabase, $SymptomEntriesTableTable, SymptomEntriesTableData> {
  $$SymptomEntriesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SymptomsTableTable _symptomIdTable(_$AppDatabase db) =>
      db.symptomsTable.createAlias($_aliasNameGenerator(
          db.symptomEntriesTable.symptomId, db.symptomsTable.id));

  $$SymptomsTableTableProcessedTableManager get symptomId {
    final $_column = $_itemColumn<int>('symptom_id')!;

    final manager = $$SymptomsTableTableTableManager($_db, $_db.symptomsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symptomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SymptomEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTableTable> {
  $$SymptomEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SymptomsTableTableFilterComposer get symptomId {
    final $$SymptomsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symptomId,
        referencedTable: $db.symptomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomsTableTableFilterComposer(
              $db: $db,
              $table: $db.symptomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTableTable> {
  $$SymptomEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SymptomsTableTableOrderingComposer get symptomId {
    final $$SymptomsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symptomId,
        referencedTable: $db.symptomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomsTableTableOrderingComposer(
              $db: $db,
              $table: $db.symptomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTableTable> {
  $$SymptomEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SymptomsTableTableAnnotationComposer get symptomId {
    final $$SymptomsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symptomId,
        referencedTable: $db.symptomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.symptomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomEntriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomEntriesTableTable,
    SymptomEntriesTableData,
    $$SymptomEntriesTableTableFilterComposer,
    $$SymptomEntriesTableTableOrderingComposer,
    $$SymptomEntriesTableTableAnnotationComposer,
    $$SymptomEntriesTableTableCreateCompanionBuilder,
    $$SymptomEntriesTableTableUpdateCompanionBuilder,
    (SymptomEntriesTableData, $$SymptomEntriesTableTableReferences),
    SymptomEntriesTableData,
    PrefetchHooks Function({bool symptomId})> {
  $$SymptomEntriesTableTableTableManager(
      _$AppDatabase db, $SymptomEntriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomEntriesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomEntriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int> symptomId = const Value.absent(),
            Value<int> severity = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              SymptomEntriesTableCompanion(
            id: id,
            date: date,
            symptomId: symptomId,
            severity: severity,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required int symptomId,
            required int severity,
            required String createdAt,
          }) =>
              SymptomEntriesTableCompanion.insert(
            id: id,
            date: date,
            symptomId: symptomId,
            severity: severity,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SymptomEntriesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({symptomId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (symptomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.symptomId,
                    referencedTable: $$SymptomEntriesTableTableReferences
                        ._symptomIdTable(db),
                    referencedColumn: $$SymptomEntriesTableTableReferences
                        ._symptomIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SymptomEntriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomEntriesTableTable,
    SymptomEntriesTableData,
    $$SymptomEntriesTableTableFilterComposer,
    $$SymptomEntriesTableTableOrderingComposer,
    $$SymptomEntriesTableTableAnnotationComposer,
    $$SymptomEntriesTableTableCreateCompanionBuilder,
    $$SymptomEntriesTableTableUpdateCompanionBuilder,
    (SymptomEntriesTableData, $$SymptomEntriesTableTableReferences),
    SymptomEntriesTableData,
    PrefetchHooks Function({bool symptomId})>;
typedef $$DailyNotesTableTableCreateCompanionBuilder = DailyNotesTableCompanion
    Function({
  Value<int> id,
  required String date,
  required String content,
  required String createdAt,
  required String updatedAt,
});
typedef $$DailyNotesTableTableUpdateCompanionBuilder = DailyNotesTableCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<String> content,
  Value<String> createdAt,
  Value<String> updatedAt,
});

class $$DailyNotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyNotesTableTable> {
  $$DailyNotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyNotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyNotesTableTable> {
  $$DailyNotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyNotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyNotesTableTable> {
  $$DailyNotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyNotesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyNotesTableTable,
    DailyNotesTableData,
    $$DailyNotesTableTableFilterComposer,
    $$DailyNotesTableTableOrderingComposer,
    $$DailyNotesTableTableAnnotationComposer,
    $$DailyNotesTableTableCreateCompanionBuilder,
    $$DailyNotesTableTableUpdateCompanionBuilder,
    (
      DailyNotesTableData,
      BaseReferences<_$AppDatabase, $DailyNotesTableTable, DailyNotesTableData>
    ),
    DailyNotesTableData,
    PrefetchHooks Function()> {
  $$DailyNotesTableTableTableManager(
      _$AppDatabase db, $DailyNotesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyNotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyNotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyNotesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              DailyNotesTableCompanion(
            id: id,
            date: date,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String content,
            required String createdAt,
            required String updatedAt,
          }) =>
              DailyNotesTableCompanion.insert(
            id: id,
            date: date,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyNotesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyNotesTableTable,
    DailyNotesTableData,
    $$DailyNotesTableTableFilterComposer,
    $$DailyNotesTableTableOrderingComposer,
    $$DailyNotesTableTableAnnotationComposer,
    $$DailyNotesTableTableCreateCompanionBuilder,
    $$DailyNotesTableTableUpdateCompanionBuilder,
    (
      DailyNotesTableData,
      BaseReferences<_$AppDatabase, $DailyNotesTableTable, DailyNotesTableData>
    ),
    DailyNotesTableData,
    PrefetchHooks Function()>;
typedef $$SettingsTableTableCreateCompanionBuilder = SettingsTableCompanion
    Function({
  required String key,
  required String value,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableTableUpdateCompanionBuilder = SettingsTableCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableAnnotationComposer,
    $$SettingsTableTableCreateCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder,
    (
      SettingsTableData,
      BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>
    ),
    SettingsTableData,
    PrefetchHooks Function()> {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsTableCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required String updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsTableCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableAnnotationComposer,
    $$SettingsTableTableCreateCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder,
    (
      SettingsTableData,
      BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>
    ),
    SettingsTableData,
    PrefetchHooks Function()>;
typedef $$NotificationPreferencesTableTableCreateCompanionBuilder
    = NotificationPreferencesTableCompanion Function({
  Value<int> id,
  required String type,
  Value<int> enabled,
  Value<String?> timeOfDay,
  Value<int?> daysBefore,
  required String updatedAt,
});
typedef $$NotificationPreferencesTableTableUpdateCompanionBuilder
    = NotificationPreferencesTableCompanion Function({
  Value<int> id,
  Value<String> type,
  Value<int> enabled,
  Value<String?> timeOfDay,
  Value<int?> daysBefore,
  Value<String> updatedAt,
});

class $$NotificationPreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTableTable> {
  $$NotificationPreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeOfDay => $composableBuilder(
      column: $table.timeOfDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get daysBefore => $composableBuilder(
      column: $table.daysBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationPreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTableTable> {
  $$NotificationPreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
      column: $table.timeOfDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get daysBefore => $composableBuilder(
      column: $table.daysBefore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationPreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTableTable> {
  $$NotificationPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<int> get daysBefore => $composableBuilder(
      column: $table.daysBefore, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationPreferencesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationPreferencesTableTable,
    NotificationPreferencesTableData,
    $$NotificationPreferencesTableTableFilterComposer,
    $$NotificationPreferencesTableTableOrderingComposer,
    $$NotificationPreferencesTableTableAnnotationComposer,
    $$NotificationPreferencesTableTableCreateCompanionBuilder,
    $$NotificationPreferencesTableTableUpdateCompanionBuilder,
    (
      NotificationPreferencesTableData,
      BaseReferences<_$AppDatabase, $NotificationPreferencesTableTable,
          NotificationPreferencesTableData>
    ),
    NotificationPreferencesTableData,
    PrefetchHooks Function()> {
  $$NotificationPreferencesTableTableTableManager(
      _$AppDatabase db, $NotificationPreferencesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPreferencesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationPreferencesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationPreferencesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> enabled = const Value.absent(),
            Value<String?> timeOfDay = const Value.absent(),
            Value<int?> daysBefore = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              NotificationPreferencesTableCompanion(
            id: id,
            type: type,
            enabled: enabled,
            timeOfDay: timeOfDay,
            daysBefore: daysBefore,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String type,
            Value<int> enabled = const Value.absent(),
            Value<String?> timeOfDay = const Value.absent(),
            Value<int?> daysBefore = const Value.absent(),
            required String updatedAt,
          }) =>
              NotificationPreferencesTableCompanion.insert(
            id: id,
            type: type,
            enabled: enabled,
            timeOfDay: timeOfDay,
            daysBefore: daysBefore,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationPreferencesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $NotificationPreferencesTableTable,
        NotificationPreferencesTableData,
        $$NotificationPreferencesTableTableFilterComposer,
        $$NotificationPreferencesTableTableOrderingComposer,
        $$NotificationPreferencesTableTableAnnotationComposer,
        $$NotificationPreferencesTableTableCreateCompanionBuilder,
        $$NotificationPreferencesTableTableUpdateCompanionBuilder,
        (
          NotificationPreferencesTableData,
          BaseReferences<_$AppDatabase, $NotificationPreferencesTableTable,
              NotificationPreferencesTableData>
        ),
        NotificationPreferencesTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CyclesTableTableTableManager get cyclesTable =>
      $$CyclesTableTableTableManager(_db, _db.cyclesTable);
  $$PeriodLogsTableTableTableManager get periodLogsTable =>
      $$PeriodLogsTableTableTableManager(_db, _db.periodLogsTable);
  $$SymptomsTableTableTableManager get symptomsTable =>
      $$SymptomsTableTableTableManager(_db, _db.symptomsTable);
  $$SymptomEntriesTableTableTableManager get symptomEntriesTable =>
      $$SymptomEntriesTableTableTableManager(_db, _db.symptomEntriesTable);
  $$DailyNotesTableTableTableManager get dailyNotesTable =>
      $$DailyNotesTableTableTableManager(_db, _db.dailyNotesTable);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$NotificationPreferencesTableTableTableManager
      get notificationPreferencesTable =>
          $$NotificationPreferencesTableTableTableManager(
              _db, _db.notificationPreferencesTable);
}
