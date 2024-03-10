import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../models/performance/AprResponse.dart';
import '../../../../../../network/AleroAPIService.dart';
import '../../../../../../utils/Pandora.dart';

part 'apr_search_bloc.freezed.dart';

@freezed
abstract class AprSearchEvent with _$AprSearchEvent {
  const factory AprSearchEvent.fetchData() = _FetchData;
  const factory AprSearchEvent.startTimeout() = _StartTimeout;
}

@freezed
abstract class AprSearchState with _$AprSearchState {
  const factory AprSearchState.initial() = _Initial;
  const factory AprSearchState.loading() = _Loading;
  const factory AprSearchState.loaded(List<AprResponse> aprByAcctNoData, List<AprResponse> aprByCustomerData) = Loaded;
  const factory AprSearchState.error() = Error;
}

class AprSearchBloc extends Bloc<AprSearchEvent, AprSearchState> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();

  AprSearchBloc() : super(AprSearchState.initial()) {
    on<_FetchData>((event, emit) async {
      emit(AprSearchState.loading());
      try {
        List<Future<List<AprResponse>>> futures = [
          apiService.getAprDataByAccNo('0168077703').timeout(Duration(minutes: 15)),
          apiService.searchAprByCustomer('0168077703').timeout(Duration(minutes: 15)),
        ];

        List<List<AprResponse>> results = await Future.wait(futures);

        emit(AprSearchState.loaded(results[0], results[1]));
      } catch (e) {
        emit(AprSearchState.error());
      }
    });

    on<_StartTimeout>((event, emit) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        final currentState = state;
        if (currentState is _Loading) {
          emit(AprSearchState.initial());
        }
      });
    });
  }

}