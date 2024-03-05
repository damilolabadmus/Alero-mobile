import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'log_out_bloc.freezed.dart';

@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.initial() = _Initial;
  const factory LogoutState.loading() = _Loading;
  const factory LogoutState.success() = _Success;
  const factory LogoutState.failure(String message) = _Failure;
}

@freezed
class LogoutEvent with _$LogoutEvent {
  const factory LogoutEvent.logout() = _Logout;
}

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AleroAPIService apiService = AleroAPIService();
  LogoutBloc() : super(LogoutState.initial()) {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutState.loading());
      try {
        await apiService.logoutUser();
        emit(LogoutState.success());
      } catch (e) {
        emit(LogoutState.failure(e.toString()));
      }
    });
  }

}
