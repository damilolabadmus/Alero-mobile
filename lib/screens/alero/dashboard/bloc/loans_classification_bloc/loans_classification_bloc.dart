import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:alero/network/AleroAPIService.dart';

import '../../../../../models/customer/LoanClassificationStatus.dart';

part 'loans_classification_bloc.freezed.dart';

@freezed
class LoanClassificationStatusState with _$LoanClassificationStatusState {
  const factory LoanClassificationStatusState.loading() = _Loading;
  const factory LoanClassificationStatusState.loaded(List<LoanClassificationStatus> data) = _Loaded;
  const factory LoanClassificationStatusState.error(String message) = _Error;
}

class LoanClassificationStatusBloc extends Cubit<LoanClassificationStatusState> {
  final AleroAPIService apiService;

  LoanClassificationStatusBloc(this.apiService) : super(LoanClassificationStatusState.loading());

  Future<void> getLoansClassificationStatus() async {
    try {
      var data = await apiService.getLoanClassificationStatus();
      emit(LoanClassificationStatusState.loaded(data as List<LoanClassificationStatus>));
    } catch (e) {
      emit(LoanClassificationStatusState.error(e.toString()));
    }
  }
}
