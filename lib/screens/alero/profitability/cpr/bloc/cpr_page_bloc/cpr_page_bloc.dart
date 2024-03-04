import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../models/performance/CprResponse.dart';
import '../../../../../../network/AleroAPIService.dart';

part 'cpr_page_bloc.freezed.dart';

@freezed
class CprPageState with _$CprPageState {
  const factory CprPageState.initial() = _Initial;
  const factory CprPageState.loading() = _Loading;
  const factory CprPageState.loaded(List<CprResponse> topData, List<CprResponse> bottomData) = _Loaded;
  const factory CprPageState.error(String message) = _Error;
}

@freezed
class CprPageEvent with _$CprPageEvent {
  const factory CprPageEvent.fetchData() = _FetchData;
}

class CprPageBloc extends Bloc<CprPageEvent, CprPageState> {
  final AleroAPIService apiService = AleroAPIService();

  CprPageBloc() : super(CprPageState.initial()) {
    on<_FetchData>((event, emit) async {
      emit(CprPageState.loading());
      try {
        final topData = await apiService.getTopCprData();
        final bottomData = await apiService.getBottomCprData();
        emit(CprPageState.loaded(topData, bottomData));
      } catch (e) {
        emit(CprPageState.error(e.toString()));
      }
    });
  }
}
