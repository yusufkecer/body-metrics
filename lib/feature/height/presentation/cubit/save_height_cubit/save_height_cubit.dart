import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/domain/use_case/save_height_use_case.dart';
import 'package:equatable/equatable.dart';

part 'save_height_state.dart';

class SaveHeightCubit extends Cubit<SaveHeightState> {
  SaveHeightCubit(this._saveHeightUseCase) : super(SaveHeightInitial());
  final SaveHeightUseCase _saveHeightUseCase;

  Future<void> saveHeight(double height) async {
    emit(SaveHeightLoading());
    final result =
        await _saveHeightUseCase.executeWithParams(User(height: height));
    if (result == null) {
      emit(SaveHeightError());
    } else {
      emit(SaveHeightSuccess());
    }
  }
}
