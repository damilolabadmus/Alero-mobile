import 'package:freezed_annotation/freezed_annotation.dart';
import '../../repository/bank_performance_repository.dart';

part 'bank_performance_state.freezed.dart';

@freezed
abstract class BankPerformanceState with _$BankPerformanceState {
  const factory BankPerformanceState.initial() = _Initial;
  const factory BankPerformanceState.loading() = _Loading;
  const factory BankPerformanceState.loaded(BankPerformanceTotals data) = _Loaded;
  const factory BankPerformanceState.error(String message) = _Error;
}