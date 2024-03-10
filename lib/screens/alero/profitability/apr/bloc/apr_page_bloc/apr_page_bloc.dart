import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../models/performance/AprResponse.dart';
import '../../../../../../network/AleroAPIService.dart';

part 'apr_page_bloc.freezed.dart';

@freezed
class APRPageEvent with _$APRPageEvent {
  const factory APRPageEvent.fetchData() = _FetchData;
  const factory APRPageEvent.startTimeout() = _StartTimeout;
}

@freezed
class APRPageState with _$APRPageState {
  const factory APRPageState.initial() = _Initial;
  const factory APRPageState.loading() = _Loading;
  const factory APRPageState.loaded({
    required List<AprResponse> topAprData,
    required List<AprResponse> bottomAprData,
  }) = _Loaded;
  const factory APRPageState.error(String error) = _Error;
}

class APRPageBloc extends Bloc<APRPageEvent, APRPageState> {
  final apiService = AleroAPIService();
  APRPageBloc() : super(APRPageState.initial()) {
    on<_FetchData>((event, emit) async {
      emit(APRPageState.loading());
      try {
        final topData = await apiService.getTopAprData().timeout(Duration(minutes: 15));
        final bottomData = await apiService.getBottomAprData().timeout(Duration(minutes: 15));
        emit(APRPageState.loaded(topAprData: topData, bottomAprData: bottomData));
      } catch (error) {
        emit(APRPageState.error(error.toString()));
      }
    });

    on<_StartTimeout>((event, emit) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        final currentState = state;
        if (currentState is _Loading) {
          emit(APRPageState.initial());
        }
      });
    });
  }
}
