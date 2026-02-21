import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/index.dart';
import 'package:injectable/injectable.dart';

@injectable
final class OnboardCubit extends Cubit<OnboardState> {
  OnboardCubit(this._useCase) : super(const OnboardInitial());

  final OnboardUseCase _useCase;
  void skip(int index, IntroKey key) {
    key.currentState?.controller.jumpToPage(index);
  }

  void updateIndex(int index) {
    emit(OnboardInitial(currentPage: index));
  }

  Future<bool> done(AppModel entity) async {
    final result = await _useCase.executeWithParams(params: entity);
    return result ?? false;
  }
}
