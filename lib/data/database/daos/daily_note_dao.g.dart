// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_note_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyNoteDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyNotesTableTable get dailyNotesTable => attachedDatabase.dailyNotesTable;
  DailyNoteDaoManager get managers => DailyNoteDaoManager(this);
}

class DailyNoteDaoManager {
  final _$DailyNoteDaoMixin _db;
  DailyNoteDaoManager(this._db);
  $$DailyNotesTableTableTableManager get dailyNotesTable =>
      $$DailyNotesTableTableTableManager(
          _db.attachedDatabase, _db.dailyNotesTable);
}
