import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class SaveUseCase implements BaseUseCase<Future<Users?>, UserFilters> {
  final GetUserRepository _userInfoRepository;

  SaveUseCase(this._userInfoRepository);

  @override
  Future<Users?> execute(UserFilters userInfo) async {
    return _userInfoRepository.execute(userInfo);
  }

  @override
  Future<Users?>? executeAll(UserFilters params) {
    // TODO: implement executeAll
    throw UnimplementedError();
  }
}
