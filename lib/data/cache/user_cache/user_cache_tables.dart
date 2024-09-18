enum UserCacheTables {
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
      case UserCacheTables.id:
        return 'id';
      case UserCacheTables.name:
        return 'name';
      case UserCacheTables.surname:
        return 'surname';
      case UserCacheTables.gender:
        return 'gender';
      case UserCacheTables.avatar:
        return 'avatar';
      case UserCacheTables.birthOfDate:
        return 'birthOfDate';
      case UserCacheTables.height:
        return 'height';
      case UserCacheTables.table:
        return 'user';
    }
  }
}
