import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/deposits_repository.dart';

part 'deposits_trend_bloc.freezed.dart';

@freezed
abstract class DepositsTrendState with _$DepositsState {
  const factory DepositsTrendState.initial() = _Initial;
  const factory DepositsTrendState.loading() = _Loading;
  const factory DepositsTrendState.loaded(AggregatedDepositsTrendData data) = _Loaded;
  const factory DepositsTrendState.error(String message) = _Error;
}

class DepositsTrendBloc extends Cubit<DepositsTrendState> {
  final DepositsTrendRepository repository;

  DepositsTrendBloc({required this.repository}) : super(DepositsTrendState.initial());

  void getDepositsTrendData() async {
    emit(DepositsTrendState.loading());
    try {
      final data = await repository.getDepositsTrendData();
      emit(DepositsTrendState.loaded(data));
    } catch (e) {
      emit(DepositsTrendState.error(e.toString()));
    }
  }
}
