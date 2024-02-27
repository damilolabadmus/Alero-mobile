import 'package:alero/screens/alero/dashboard/repository/loans_trend_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loans_trend_bloc.freezed.dart';

@freezed
class LoansTrendState with _$LoansTrendState {
  const factory LoansTrendState.initial() = _Initial;
  const factory LoansTrendState.loading() = _Loading;
  const factory LoansTrendState.loaded(AggregatedLoansTrendData data) = _Loaded;
  const factory LoansTrendState.error(String message) = _Error;
}

class LoansTrendBloc extends Cubit<LoansTrendState> {
  final LoansTrendRepository repository;

  LoansTrendBloc({required this.repository}) : super(LoansTrendState.initial());

  void getLoansTrendData() async {
    emit(LoansTrendState.loading());
    try {
      final data = await repository.getLoansTrendData();
      emit(LoansTrendState.loaded(data));
    } catch (e) {
      emit(LoansTrendState.error(e.toString()));
    }
  }
}
