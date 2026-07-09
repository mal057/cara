// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dao.dart';

// ignore_for_file: type=lint
mixin _$NotificationDaoMixin on DatabaseAccessor<AppDatabase> {
  $NotificationPreferencesTableTable get notificationPreferencesTable =>
      attachedDatabase.notificationPreferencesTable;
  NotificationDaoManager get managers => NotificationDaoManager(this);
}

class NotificationDaoManager {
  final _$NotificationDaoMixin _db;
  NotificationDaoManager(this._db);
  $$NotificationPreferencesTableTableTableManager
      get notificationPreferencesTable =>
          $$NotificationPreferencesTableTableTableManager(
              _db.attachedDatabase, _db.notificationPreferencesTable);
}
