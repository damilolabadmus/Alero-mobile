import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/data_completeness_and_validity_repository.dart';

part 'data_validity_bloc.freezed.dart';

@freezed
abstract class DataValidityState with _$DataValidityState {
  const factory DataValidityState.initial() = _Initial;
  const factory DataValidityState.loading() = _Loading;
  const factory DataValidityState.loaded(AggregatedCAndVData data) = _Loaded;
  const factory DataValidityState.error(String message) = _Error;
}

class DataValidityBloc extends Cubit<DataValidityState> {
  final DataCompletenessAndValidityRepository repository;

  DataValidityBloc({required this.repository}) : super(DataValidityState.initial());

  void getDataValidityData() async {
    emit(DataValidityState.loading());
    try {
      final data = await repository.getDataCompletenessAndValidity();
      emit(DataValidityState.loaded(data));
    } catch (e) {
      emit(DataValidityState.error(e.toString()));
    }
  }
}
