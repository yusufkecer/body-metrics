import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/domain/use_case/save_height_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'save_height_state.dart';

@injectable
final class SaveHeightCubit extends Cubit<SaveHeightState> {
  SaveHeightCubit(this._saveHeightUseCase) : super(SaveHeightInitial());
  final SaveHeightUseCase _saveHeightUseCase;

  Future<void> saveHeight(int height) async {
    emit(SaveHeightLoading());
    final userId = AppUtil.currentUserId;
    final result = await _saveHeightUseCase.executeWithParams(
      params: User(id: userId, height: height),
    );
    if (result == null || result == false) {
      emit(const SaveHeightError(error: LocaleKeys.exception_height_not_saved));
    } else {
      emit(SaveHeightSuccess());
    }
  }
}
