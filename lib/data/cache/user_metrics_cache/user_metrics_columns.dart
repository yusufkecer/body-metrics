enum UserMetricsColumns {
  id,
  date,
  weight,
  height,
  userId,
  bmi,
  diff,
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
      case UserMetricsColumns.bmi:
        return 'bmi';
      case UserMetricsColumns.diff:
        return 'weight_diff';
      case UserMetricsColumns.table:
        return 'user_metrics';
    }
  }
}
