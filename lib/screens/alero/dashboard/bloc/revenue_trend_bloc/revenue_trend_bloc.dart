import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/revenue_trend_repository.dart';

part 'revenue_trend_bloc.freezed.dart';

@freezed
class RevenueTrendState with _$RevenueTrendState {
  const factory RevenueTrendState.initial() = _Initial;
  const factory RevenueTrendState.loading() = _Loading;
  const factory RevenueTrendState.loaded(AggregateRevenueTrendData data) = _Loaded;
  const factory RevenueTrendState.error(String message) = _Error;
}

class RevenueTrendBloc extends Cubit<RevenueTrendState> {
  final RevenueTrendRepository repository;

  RevenueTrendBloc({required this.repository}) : super(RevenueTrendState.initial());

  Future<void> getBankRevenueData() async {
    emit(RevenueTrendState.loading());
    try {
      final data = await repository.getBankRevenueData();
      emit(RevenueTrendState.loaded(data));
    } catch (e) {
      emit(RevenueTrendState.error(e.toString()));
    }
  }
}
