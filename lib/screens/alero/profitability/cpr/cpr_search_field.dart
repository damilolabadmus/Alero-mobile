import 'package:alero/screens/alero/profitability/cpr/search_cpr_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../style/theme.dart' as Style;
import 'bloc/cpr_search_field_bloc/cpr_search_field_bloc.dart';

class CprSearchField extends StatelessWidget {
  const CprSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CprSearchBloc()..add(CprSearchEvent.search('0168077703')),
      child: _CprSearchField(),
    );
  }
}

class _CprSearchField extends StatelessWidget {
  _CprSearchField();

  @override
  Widget build(BuildContext context) {
    TextEditingController _filterFieldController = new TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(
              horizontal: Style.Constants.Padding20,
            ),
            width: size.width * 0.5,
            height: size.height * 0.06,
            decoration:
                BoxDecoration(color: Style.Colors.greyForm, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.transparent)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: BlocBuilder<CprSearchBloc, CprSearchState>(
                builder: (context, state) {
                  return TextField(
                    autocorrect: false,
                    controller: _filterFieldController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Style.Colors.greyTextColor,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {},
                    style:
                        TextStyle(color: Style.Colors.subBlackTextColor, fontSize: 14.0, fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search customer",
                        hintStyle:
                            TextStyle(fontSize: 10.0, color: Style.Colors.greyTextColor, fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600),
                        suffixIcon: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchCprPage(
                                  searchedCprData: state.maybeWhen(orElse: () => null, loaded: (data) => data),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Icon(
                              EvaIcons.searchOutline,
                              color: Style.Colors.buttonColor,
                              size: 18,
                            ),
                          ),
                        )),
                  );
                },
              ),
            )),
      ),
    );
  }
}
