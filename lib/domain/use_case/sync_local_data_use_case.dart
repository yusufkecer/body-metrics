import 'package:bodymetrics/core/index.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncLocalDataUseCase {
  const SyncLocalDataUseCase(this._repository);

  final SyncDataRepositoryBase _repository;

  Future<void> execute() async {
    await _repository.sync();
  }

  Future<void> restore() async {
    await _repository.restore();
  }

  Future<void> markPending() async {
    await _repository.markPending();
  }

  Future<void> restoreAndAttemptSync() async {
    await _repository.restorePendingStatus();
    if (AppUtil.syncPending && AppUtil.hasSession) {
      'SyncLocalDataUseCase: pending sync detected on startup — retrying'.log();
      await _repository.sync();
    }
  }
}
