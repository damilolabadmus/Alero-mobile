import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/customer/BankRevenueData.dart';
import '../../repository/bank_revenue_repository.dart';

part 'bank_revenue_bloc.freezed.dart';

@freezed
class BankRevenueState with _$BankRevenueState {
  const factory BankRevenueState.initial() = _Initial;
  const factory BankRevenueState.loading() = _Loading;
  const factory BankRevenueState.loaded(BankRevenueData data) = _Loaded;
  const factory BankRevenueState.error(String message) = _Error;
}

class BankRevenueBloc extends Cubit<BankRevenueState> {
  final BankRevenueRepository repository;

  BankRevenueBloc({required this.repository}) : super(BankRevenueState.initial());

  Future<void> getBankRevenueData() async {
    emit(BankRevenueState.loading());
    try {
      final data = await repository.getBankRevenueData();
      emit(BankRevenueState.loaded(data));
    } catch (e) {
      emit(BankRevenueState.error(e.toString()));
    }
  }
}