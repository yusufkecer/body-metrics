import 'package:bodymetrics/core/index.dart';

class UserFilters extends User {
  const UserFilters({
    super.id,
    super.birthOfDate,
    super.name,
    super.userMetrics,
    this.bmiId,
  });

  final int? bmiId;
}
