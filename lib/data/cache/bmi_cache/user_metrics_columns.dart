enum UserMetricsColumns {
  id,
  date,
  weight,
  height,
  userId,
  result,
  table;

  String get value {
    switch (this) {
      case UserMetricsColumns.id:
        return 'id';
      case UserMetricsColumns.date:
        return 'date';
      case UserMetricsColumns.weight:
        return 'weight';
      case UserMetricsColumns.height:
        return 'height';
      case UserMetricsColumns.userId:
        return 'user_id';
      case UserMetricsColumns.result:
        return 'result';
      case UserMetricsColumns.table:
        return 'bmi';
    }
  }
}
