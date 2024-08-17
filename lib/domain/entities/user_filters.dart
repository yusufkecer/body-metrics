import 'package:bodymetrics/core/index.dart';

class UserFilters extends User {
  final int? bmiId;

  const UserFilters({
    super.id,
    super.name,
    super.userMetrics,
    this.bmiId,
  });
}
