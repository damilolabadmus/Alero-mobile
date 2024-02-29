import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../models/response/CustomerList.dart';
import '../../../../../network/AleroAPIService.dart';

part 'search_body_bloc.freezed.dart';

@freezed
abstract class SearchEvent with _$SearchEvent {
  const factory SearchEvent.search(String query) = SearchStarted;
  const factory SearchEvent.filter(String name) = SearchFilter;
}

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.loaded({
    required List<CustomerList> customerList,
  }) = SearchLoaded;
  const factory SearchState.error(String message) = SearchError;
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  var apiService = AleroAPIService();
  SearchBloc() : super(SearchState.initial()) {
    on<SearchStarted>((event, emit) async {
      emit(SearchState.loading());
      try {
        final searchResponse = await apiService.searchCustomer(event.query) as List;
        List<CustomerList> customerList = [];
        searchResponse.forEach((customer) {
          customerList.add(CustomerList(
            customerId: customer["groupId"],
            customerName: customer["customerName"],
            activeYear: customer["customerRelationshipAge"],
            businessSegment: customer["businessSegment"],
            active: (customer["activeStat"] == "Active") ? true : false,
          ));
        });

        emit(SearchState.loaded(
          customerList: customerList,
        ));
      } catch (e) {
        emit(SearchState.error(e.toString()));
      }
    });

    on<SearchFilter>((event, emit) async {
      List<CustomerList> filteredList = state.maybeWhen(
        loaded: (customerList) => customerList,
        orElse: () => [],
      );

      List<CustomerList> searchItem = [];

      for (var customer in filteredList) {
        if (customer.customerName!.toLowerCase().trim().contains(event.name.toLowerCase().trim())) {
          searchItem.add(customer);
        }
      }

      emit(SearchState.loaded(
        customerList: searchItem,
      ));
    });
  }
}
