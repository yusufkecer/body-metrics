enum BmiCacheColumns {
  id,
  date,
  weight,
  height,
  userId,
  result,
  table;

  String get value {
    switch (this) {
      case BmiCacheColumns.id:
        return 'id';
      case BmiCacheColumns.date:
        return 'date';
      case BmiCacheColumns.weight:
        return 'weight';
      case BmiCacheColumns.height:
        return 'height';
      case BmiCacheColumns.userId:
        return 'user_id';
      case BmiCacheColumns.result:
        return 'result';
      case BmiCacheColumns.table:
        return 'bmi';
    }
  }
}
