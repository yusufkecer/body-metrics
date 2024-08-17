import 'package:bodymetrics/core/base/base_use_case.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class SaveUseCase implements BaseUseCase<Future<Users?>, User> {
  final UserRepository _userInfoRepository;

  SaveUseCase(this._userInfoRepository);

  @override
  Future<Users?> execute(User userInfo) async {
    return _userInfoRepository.get(userInfo);
  }
}
