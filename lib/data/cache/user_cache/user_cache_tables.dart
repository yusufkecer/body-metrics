enum UserCacheColumns {
  id,
  name,
  surname,
  gender,
  avatar,
  height,
  birthOfDate,
  table;

  String get value {
    switch (this) {
      case UserCacheColumns.id:
        return 'id';
      case UserCacheColumns.name:
        return 'name';
      case UserCacheColumns.surname:
        return 'surname';
      case UserCacheColumns.gender:
        return 'gender';
      case UserCacheColumns.avatar:
        return 'avatar';
      case UserCacheColumns.birthOfDate:
        return 'birthOfDate';
      case UserCacheColumns.height:
        return 'height';
      case UserCacheColumns.table:
        return 'user';
    }
  }
}
