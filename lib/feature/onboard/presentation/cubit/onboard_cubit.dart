part of '../onboard.dart';

@injectable
final class OnboardCubit extends Cubit<OnboardState> {
  OnboardCubit() : super(const OnboardInitial());

  void skip(int index, IntroKey key) {
    key.currentState?.controller.jumpToPage(index);
  }

  void updateIndex(int index) {
    emit(OnboardInitial(currentPage: index));
  }

  Future<bool> done(AppModel entity) async {
    final useCase = Locator.sl<OnboardUseCase>();
    final result = await useCase.executeWithParams(entity);
    return result ?? false;
  }
}
