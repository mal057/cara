// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_dao.dart';

// ignore_for_file: type=lint
mixin _$CycleDaoMixin on DatabaseAccessor<AppDatabase> {
  $CyclesTableTable get cyclesTable => attachedDatabase.cyclesTable;
  $PeriodLogsTableTable get periodLogsTable => attachedDatabase.periodLogsTable;
  $SymptomsTableTable get symptomsTable => attachedDatabase.symptomsTable;
  $SymptomEntriesTableTable get symptomEntriesTable =>
      attachedDatabase.symptomEntriesTable;
  CycleDaoManager get managers => CycleDaoManager(this);
}

class CycleDaoManager {
  final _$CycleDaoMixin _db;
  CycleDaoManager(this._db);
  $$CyclesTableTableTableManager get cyclesTable =>
      $$CyclesTableTableTableManager(_db.attachedDatabase, _db.cyclesTable);
  $$PeriodLogsTableTableTableManager get periodLogsTable =>
      $$PeriodLogsTableTableTableManager(
          _db.attachedDatabase, _db.periodLogsTable);
  $$SymptomsTableTableTableManager get symptomsTable =>
      $$SymptomsTableTableTableManager(_db.attachedDatabase, _db.symptomsTable);
  $$SymptomEntriesTableTableTableManager get symptomEntriesTable =>
      $$SymptomEntriesTableTableTableManager(
          _db.attachedDatabase, _db.symptomEntriesTable);
}
