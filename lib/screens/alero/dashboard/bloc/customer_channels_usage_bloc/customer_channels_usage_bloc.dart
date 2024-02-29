// customer_channels_Volume_bloc.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alero/models/customer/TouchPointData.dart';

import '../../repository/customer_channels_usage_repository.dart';

part 'customer_channels_usage_bloc.freezed.dart';

@freezed
class CustomerChannelsUsageState with _$CustomerChannelsUsageState {
  const factory CustomerChannelsUsageState.initial() = _Initial;
  const factory CustomerChannelsUsageState.loading() = _Loading;
  const factory CustomerChannelsUsageState.loaded(List<TouchPointData?>? channels) = _Loaded;
  const factory CustomerChannelsUsageState.error(String message) = _Error;
}

class CustomerChannelsUsageBloc extends Cubit<CustomerChannelsUsageState> {
  final CustomerChannelsUsageRepository repository;

  CustomerChannelsUsageBloc(this.repository) : super(CustomerChannelsUsageState.initial());

  Future<void> fetch() async {
    emit(CustomerChannelsUsageState.loading());
    try {
      final channels = await repository.getCustomerChannelsUsage();
      emit(CustomerChannelsUsageState.loaded(channels));
    } catch (e) {
      emit(CustomerChannelsUsageState.error(e.toString()));
    }
  }
}