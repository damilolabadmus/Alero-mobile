import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/screens/alero/profitability/apr/search_apr_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../style/theme.dart' as Style;
import 'bloc/apr_search_bloc/apr_search_bloc.dart';

class AprSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AprSearchBloc()
        ..add(AprSearchEvent.fetchData())
        ..add(AprSearchEvent.startTimeout()),
      child: _AprSearchField(),
    );
  }
}

class _AprSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AprSearchBloc, AprSearchState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loading: (_) => CircularProgressIndicator(),
          loaded: (state) => _buildSearchField(context, state.aprByAcctNoData),
          error: (_) => Text('An error occurred!'),
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context, List<AprResponse> aprByAcctNoData) {
    TextEditingController _filterFieldController = new TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(
        horizontal: Style.Constants.Padding20,
      ),
      width: size.width * 0.5,
      height: size.height * 0.06,
      decoration: BoxDecoration(color: Style.Colors.greyForm, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TextField(
          controller: _filterFieldController,
          autocorrect: false,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Style.Colors.greyTextColor,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {},
          style: TextStyle(color: Style.Colors.subBlackTextColor, fontSize: 14.0, fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search customer",
            hintStyle: TextStyle(fontSize: 10.0, color: Style.Colors.greyTextColor, fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600),
            suffixIcon: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchAprPage(searchedAprData: aprByAcctNoData))),
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Icon(
                  EvaIcons.searchOutline,
                  color: Style.Colors.buttonColor,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
