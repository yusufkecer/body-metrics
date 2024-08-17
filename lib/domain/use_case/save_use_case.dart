import 'package:bodymetrics/core/base/base_use_case.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class SaveUseCase implements BaseUseCase<Future<bool>, Map<String, dynamic>> {
  final UserRepository _userInfoRepository;

  SaveUseCase(this._userInfoRepository);

  @override
  Future<bool> execute(Map<String, dynamic> userInfo) async {
    return _userInfoRepository.save(userInfo);
  }
}
