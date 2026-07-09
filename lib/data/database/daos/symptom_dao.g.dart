// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_dao.dart';

// ignore_for_file: type=lint
mixin _$SymptomDaoMixin on DatabaseAccessor<AppDatabase> {
  $SymptomsTableTable get symptomsTable => attachedDatabase.symptomsTable;
  $SymptomEntriesTableTable get symptomEntriesTable =>
      attachedDatabase.symptomEntriesTable;
  SymptomDaoManager get managers => SymptomDaoManager(this);
}

class SymptomDaoManager {
  final _$SymptomDaoMixin _db;
  SymptomDaoManager(this._db);
  $$SymptomsTableTableTableManager get symptomsTable =>
      $$SymptomsTableTableTableManager(_db.attachedDatabase, _db.symptomsTable);
  $$SymptomEntriesTableTableTableManager get symptomEntriesTable =>
      $$SymptomEntriesTableTableTableManager(
          _db.attachedDatabase, _db.symptomEntriesTable);
}
