import 'package:bodymetrics/core/index.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class SyncLocalDataUseCase {
  const SyncLocalDataUseCase(this._repository);

  final SyncDataRepositoryBase _repository;

  Future<void> execute() async {
    await _repository.sync();
  }
}
