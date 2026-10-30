// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'targets_dao.dart';

// ignore_for_file: type=lint
mixin _$TargetsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserProfilesTable get userProfiles => attachedDatabase.userProfiles;
  $DayTypeTargetRowsTable get dayTypeTargetRows =>
      attachedDatabase.dayTypeTargetRows;
  $WeekScheduleEntriesTable get weekScheduleEntries =>
      attachedDatabase.weekScheduleEntries;
  TargetsDaoManager get managers => TargetsDaoManager(this);
}

class TargetsDaoManager {
  final _$TargetsDaoMixin _db;
  TargetsDaoManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db.attachedDatabase, _db.userProfiles);
  $$DayTypeTargetRowsTableTableManager get dayTypeTargetRows =>
      $$DayTypeTargetRowsTableTableManager(
        _db.attachedDatabase,
        _db.dayTypeTargetRows,
      );
  $$WeekScheduleEntriesTableTableManager get weekScheduleEntries =>
      $$WeekScheduleEntriesTableTableManager(
        _db.attachedDatabase,
        _db.weekScheduleEntries,
      );
}
