import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import '../../../models/response/CustomerList.dart';
import '../../../style/theme.dart' as Style;
import '../components/empty_list_item.dart';
import 'bloc/search_body_bloc/search_body_bloc.dart';
import 'search_item.dart';
import 'search_search_field.dart';
import 'shimmer_loading_widget.dart';

class SearchBody extends StatelessWidget {
  final String? searchQuery;

  SearchBody({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(SearchEvent.search(searchQuery!)),
      child: _SearchBody(),
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _filterFieldController = new TextEditingController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 13.0),
          child: Align(
            alignment: Alignment.topRight,
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => Text('Please wait ...'),
                  loading: () => Text('Please wait ...'),
                  loaded: (customerList) => Text(customerList.length.toString() + ' matches found'),
                  error: (message) => Text('Error: $message'),
                );
              },
            ),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: EdgeInsets.only(left: 23.0, right: 15.0),
            child: TextField(
              autocorrect: false,
              controller: _filterFieldController,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Style.Colors.greyTextColor,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                context.read<SearchBloc>().add(SearchEvent.filter(value));
              },
              style: TextStyle(
                color: Style.Colors.blackTextColor,
                fontSize: 15.0,
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Filter with customer’s name or branch",
                hintStyle: TextStyle(
                  fontSize: 10.0,
                  color: Style.Colors.greyTextColor,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.w600,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    context.read<SearchBloc>().add(SearchEvent.filter(_filterFieldController.text));
                  },
                  child: Icon(
                    EvaIcons.searchOutline,
                    color: Style.Colors.buttonColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            state.maybeWhen(
                loaded: (data) {
                  if (data.isEmpty) {
                    Navigator.of(context).pushNamed('/search', arguments: _filterFieldController.text.toString());
                  }
                },
                orElse: () {});
          },
          builder: (context, state) {
            return state.when(
              initial: () => Container(),
              loading: () => ShimmerLoadingWidget(),
              loaded: (customerList) => _buildCustomerList(customerList),
              error: (message) => Text('Error: $message'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomerList(List<CustomerList> customerList) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            if (customerList.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: customerList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SearchItemCard(
                      press: () {
                        Navigator.of(context).pushNamed('/customer-profile', arguments: customerList[index].customerId);
                      },
                      customerName: customerList[index].customerName,
                      customerYears: customerList[index].activeYear,
                      businessSegment: customerList[index].businessSegment,
                      active: customerList[index].active,
                    ),
                  );
                },
              ),
            if (customerList.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: EmptyListItem(message: 'User not Found'),
              ),
          ],
        ),
      ),
    );
  }
}
