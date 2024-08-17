import 'package:bodymetrics/core/base/base_use_case.dart';
import 'package:bodymetrics/domain/index.dart';

sealed class SaveUseCase implements BaseUseCase<bool, User> {
  final UserRepository _userInfoRepository;

  SaveUseCase(this._userInfoRepository);

  Future<bool> call(Map<String, dynamic> userInfo) async {
    return _userInfoRepository.save(userInfo);
  }
}
