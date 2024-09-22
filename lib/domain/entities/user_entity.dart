import 'package:bodymetrics/core/index.dart';

class UserFilters extends User {
  const UserFilters({
    super.id,
    super.birthOfDate,
    super.name,
    super.userMetrics,
    super.avatar,
    super.gender,
    super.height,
    this.bmiId,
  });

  final int? bmiId;
}
