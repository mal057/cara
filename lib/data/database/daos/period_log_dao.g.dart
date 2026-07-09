// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_log_dao.dart';

// ignore_for_file: type=lint
mixin _$PeriodLogDaoMixin on DatabaseAccessor<AppDatabase> {
  $CyclesTableTable get cyclesTable => attachedDatabase.cyclesTable;
  $PeriodLogsTableTable get periodLogsTable => attachedDatabase.periodLogsTable;
  PeriodLogDaoManager get managers => PeriodLogDaoManager(this);
}

class PeriodLogDaoManager {
  final _$PeriodLogDaoMixin _db;
  PeriodLogDaoManager(this._db);
  $$CyclesTableTableTableManager get cyclesTable =>
      $$CyclesTableTableTableManager(_db.attachedDatabase, _db.cyclesTable);
  $$PeriodLogsTableTableTableManager get periodLogsTable =>
      $$PeriodLogsTableTableTableManager(
          _db.attachedDatabase, _db.periodLogsTable);
}
