import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract final class Env {
  @EnviedField(varName: 'API_KEY', defaultValue: '')
  static final String apiKey = _Env.apiKey;
}
