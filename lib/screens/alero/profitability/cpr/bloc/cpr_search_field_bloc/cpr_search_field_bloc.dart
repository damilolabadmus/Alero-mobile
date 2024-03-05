import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../models/performance/CprResponse.dart';
import '../../../../../../network/AleroAPIService.dart';

part 'cpr_search_field_bloc.freezed.dart';

@freezed
class CprSearchEvent with _$CprSearchEvent {
  const factory CprSearchEvent.search(String customerNumber) = _Search;
}

@freezed
class CprSearchState with _$CprSearchState {
  const factory CprSearchState.initial() = _Initial;
  const factory CprSearchState.loading() = _Loading;
  const factory CprSearchState.loaded(List<CprResponse> data) = _Loaded;
  const factory CprSearchState.error(String message) = _Error;
}

class CprSearchBloc extends Bloc<CprSearchEvent, CprSearchState> {
  final apiService = AleroAPIService();
  CprSearchBloc() : super(_Initial()) {
    on<_Search>((event, emit) async {
      emit(_Loading());
      try {
        final data = await apiService.getCprByCustomer(event.customerNumber);
        emit(_Loaded(data));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }


}