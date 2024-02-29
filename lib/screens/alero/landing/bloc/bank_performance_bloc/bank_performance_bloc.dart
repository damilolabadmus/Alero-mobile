import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/bank_performance_repository.dart';
import 'bank_performance_state.dart';

class BankPerformanceBloc extends Cubit<BankPerformanceState> {
  final BankPerformanceRepository repository;

  BankPerformanceBloc({required this.repository}) : super(BankPerformanceState.initial());

  Future<void> getBankPerformanceData() async {
    emit(BankPerformanceState.loading());
    try {
      final data = await repository.getBankPerformanceData();
      emit(BankPerformanceState.loaded(data));
    } catch (e) {
      emit(BankPerformanceState.error(e.toString()));
    }
  }
}