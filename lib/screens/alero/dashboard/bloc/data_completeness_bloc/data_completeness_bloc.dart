import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/data_completeness_and_validity_repository.dart';

part 'data_completeness_bloc.freezed.dart';

@freezed
abstract class DataCompletenessState with _$DataCompletenessState {
  const factory DataCompletenessState.initial() = _Initial;
  const factory DataCompletenessState.loading() = _Loading;
  const factory DataCompletenessState.loaded(AggregatedCAndVData data) = _Loaded;
  const factory DataCompletenessState.error(String message) = _Error;
}

class DataCompletenessBloc extends Cubit<DataCompletenessState> {
  final DataCompletenessAndValidityRepository repository;

  DataCompletenessBloc({required this.repository}) : super(DataCompletenessState.initial());

  void getDataCompletenessData() async {
    emit(DataCompletenessState.loading());
    try {
      final data = await repository.getDataCompletenessAndValidity();
      emit(DataCompletenessState.loaded(data));
    } catch (e) {
      emit(DataCompletenessState.error(e.toString()));
    }
  }
}
