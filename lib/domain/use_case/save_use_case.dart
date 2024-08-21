import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class SaveUseCase implements BaseUseCase<Future<bool?>, UserFilters> {
  final GetUserRepository _userInfoRepository;

  SaveUseCase(this._userInfoRepository);

  @override
  Future<bool?> execute(User userInfo) async {
    return _userInfoRepository.execute(userInfo);
  }

  @override
  Future<bool> executeAll(UserFilters params) {
    // TODO: implement executeAll
    throw UnimplementedError();
  }
}
