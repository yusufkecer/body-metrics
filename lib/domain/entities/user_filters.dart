import 'package:bodymetrics/core/index.dart';

class UserFilters extends User {
  final int? bmiId;

  const UserFilters({
    super.id,
    super.birthOfDay,
    super.name,
    super.userMetrics,
    this.bmiId,
  });
}
