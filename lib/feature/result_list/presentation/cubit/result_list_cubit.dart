import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'result_list_state.dart';

class ResultListCubit extends Cubit<ResultListState> {
  ResultListCubit() : super(ResultListInitial());
}
