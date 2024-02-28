import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:alero/network/AleroAPIService.dart';

import '../../../../../models/customer/LoanClassificationStatus.dart';

part 'loans_overdue_bloc.freezed.dart';

@freezed
class LoanOverdueState with _$LoanOverdueState {
  const factory LoanOverdueState.loading() = _Loading;
  const factory LoanOverdueState.loaded(List<LoanClassificationStatus?>? data) = _Loaded;
  const factory LoanOverdueState.error(String message) = _Error;
}

class LoanOverdueBloc extends Cubit<LoanOverdueState> {
  final AleroAPIService apiService;

  LoanOverdueBloc(this.apiService) : super(LoanOverdueState.loading());

  Future<void> getLoansOverdue() async {
    try {
      var data = await apiService.getLoanOverdue();
      emit(LoanOverdueState.loaded(data as List<LoanClassificationStatus?>?));
    } catch (e) {
      emit(LoanOverdueState.error(e.toString()));
    }
  }
}
