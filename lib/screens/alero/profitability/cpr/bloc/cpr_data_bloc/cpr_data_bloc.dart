import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../models/performance/CprResponse.dart';
import '../../../../../../network/AleroAPIService.dart';

part 'cpr_data_bloc.freezed.dart';

@freezed
class CprDataState with _$CprDataState {
  const factory CprDataState.initial() = _Initial;
  const factory CprDataState.loading() = _Loading;
  const factory CprDataState.loaded(List<CprResponse> topData, List<CprResponse> bottomData) = _Loaded;
  const factory CprDataState.error(String message) = _Error;
}

@freezed
class CprDataEvent with _$CprDataEvent {
  const factory CprDataEvent.fetchData() = _FetchData;
}

class CprDataBloc extends Bloc<CprDataEvent, CprDataState> {
  final AleroAPIService apiService = AleroAPIService();

  CprDataBloc() : super(CprDataState.initial()) {
    on<_FetchData>((event, emit) async {
      emit(CprDataState.loading());
      try {
        final topData = await apiService.getTopCprData();
        final bottomData = await apiService.getBottomCprData();
        emit(CprDataState.loaded(topData, bottomData));
      } catch (e) {
        emit(CprDataState.error(e.toString()));
      }
    });
  }
}
