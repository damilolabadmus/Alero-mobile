import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'balance_sheet_nav_bloc.freezed.dart';

@freezed
class BalanceSheetNavState with _$BalanceSheetNavState {
  const factory BalanceSheetNavState({
    required bool active,
    required bool isActive,
    required int position,
  }) = _BalanceSheetNavState;
}

@freezed
class BalanceSheetNavEvent with _$BalanceSheetNavEvent {
  const factory BalanceSheetNavEvent.activeChanged(bool active) = ActiveChanged;
  const factory BalanceSheetNavEvent.isActiveChanged(bool isActive) = IsActiveChanged;
  const factory BalanceSheetNavEvent.positionChanged(int position) = PositionChanged;
}

class BalanceSheetNavBloc extends Bloc<BalanceSheetNavEvent, BalanceSheetNavState> {
  BalanceSheetNavBloc()
      : super(BalanceSheetNavState(
          active: true,
          isActive: false,
          position: 0,
        )) {
    on<ActiveChanged>((event, emit) {
      state.copyWith(active: event.active);
    });
    on<IsActiveChanged>((event, emit) {
      state.copyWith(isActive: event.isActive);
    });
    on<PositionChanged>((event, emit) {
      state.copyWith(position: event.position);
    });
  }
}
