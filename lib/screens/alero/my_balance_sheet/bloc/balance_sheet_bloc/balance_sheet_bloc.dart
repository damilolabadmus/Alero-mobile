import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../../models/performance/MyBalanceSheetReponse.dart';
import '../../../../../models/performance/MyBalanceSheetRmResponse.dart';
import '../../../../../models/performance/MyBalanceSheetTypeResponse.dart';
import '../../../../../network/AleroAPIService.dart';
import '../../../../../utils/Pandora.dart';

part 'balance_sheet_bloc_state.dart';
part 'balance_sheet_bloc.freezed.dart';

@freezed
class BalanceSheetBlocEvent with _$BalanceSheetBlocEvent {
  const factory BalanceSheetBlocEvent.loadData() = _LoadData;
  const factory BalanceSheetBlocEvent.assignAndSaveItemTypes(String item) = _AssignAndSaveItemTypes;
  const factory BalanceSheetBlocEvent.updateTypes(String item) = _UpdateTypes;
  const factory BalanceSheetBlocEvent.updateDate(String date) = _UpdateDate;
}

class BalanceSheetBloc extends Bloc<BalanceSheetBlocEvent, BalanceSheetBlocState> {
  final apiService = AleroAPIService();
  final Pandora pandora = new Pandora();
  BalanceSheetBloc() : super(BalanceSheetBlocState.initial()) {
    on<_LoadData>((event, emit) async {
      await _loadData(emit);
    });

    on<_AssignAndSaveItemTypes>((event, emit) async {
      _assignAndSaveItemTypes(emit, event.item);
    });

    on<_UpdateTypes>((event, emit) async {
      _updateTypes(emit, event.item);
    });

    on<_UpdateDate>((event, emit) async {
      _updateDate(emit, event.date);
    });
  }

  void _updateDate(Emitter emit, String date) {
    emit(state.copyWith(selectedDate: date));
  }

  void _updateTypes(Emitter emit, String item) {
    if (state.segmentType == null) {
      emit(state.copyWith(segmentType: item));
    } else if (state.regionType != null) {
      emit(state.copyWith(regionType: item));
    } else if (state.areaType != null) {
      emit(state.copyWith(areaType: item));
    } else if (state.branchType != null) {
      emit(state.copyWith(branchType: item));
    } else if (state.rmType != null) {
      emit(state.copyWith(rmType: item));
    } else if (state.segmentType != null) {
      emit(state.copyWith(segmentType: item));
    } else {
      emit(state.copyWith(segmentType: item));
    }
  }

  void _assignAndSaveItemTypes(Emitter emit, String item) {
    if (state.regionType == null) {
      emit(state.copyWith(regionType: item));
    } else if (state.areaType == null) {
      emit(state.copyWith(areaType: item));
    } else if (state.branchType == null) {
      emit(state.copyWith(branchType: item));
    } else {
      emit(state.copyWith(rmType: item));
    }

    emit(state.copyWith(
      regionItem: state.regionType,
      areaItem: state.areaType,
      branchItem: state.branchType,
      rmItem: state.rmType,
    ));

    pandora.saveToSharedPreferences('regionItem', state.regionItem!);
    pandora.saveToSharedPreferences('areaItem', state.areaItem!);
    pandora.saveToSharedPreferences('branchItem', state.branchItem!);
    pandora.saveToSharedPreferences('rmItem', state.rmItem!);
  }

  Future<void> _loadData(Emitter emit) async {
    final date = state.selectedDate ?? state.yesterdayDateString!;
    getDate(emit);
    getRegionList(emit);
    getAreaListByRegionId(emit, 'SO001');
    getBranchListByAreaCode(emit, 'IMO001');
    getRmListByAreaCode(emit, '010');
    getBankWideDepositActualData(emit, date);
    getBankWideLoanActualData(emit, date);

    getRegionActualData(emit, date, 'SOUTH');
    getAreaActualData(emit, 'SO001', 'DELTA', date);
    getBranchActualData(emit, 'IMO001', 'ORLU', date);
    getRmData('WFG10289', emit, date);

    getBankWideDepositAvgData(emit, date);
    getBankWideLoanAvgData(emit, date);
    getRegionAvgData(emit, 'SO001');
    getAreaAvgData(emit, 'SO001', 'DELTA', date);
    getBranchAvgData(emit, 'IMO001', '010', date);

    getActualSegmentBankWideData(emit, '2023-07-24', 'SME'); // DON'T USE ANOTHER DATE and api response is very slow
    getActualSegmentRegionData(emit, 'SME', date, 'SO001');
    getActualSegmentAreaData(emit, 'SO001', 'SME', 'IMO001', date); // OR
    getActualSegmentBranchData(emit, 'IMO001', 'SME', '010', date);

    getAvgSegmentBankWideData(emit, date, 'Sme'); // Make Sure you use camel case for segment e.g. Sme, Corporate, etc
    getAvgSegmentRegionData(emit, 'SME', date, 'SO001');
    getAvgSegmentAreaData(emit, 'SO001', 'SME', date);
    getAvgSegmentBranchData(emit, 'IMO001', 'SME', date);
  }

  void getDate(Emitter emit) {
    DateTime startDate = DateTime.now();

    if (state.selectedDate != null) {
      final pickedDate = DateTime.parse(state.selectedDate!);
      final selectedStartDate = DateFormat('yyyy-MMM-dd').format(pickedDate);

      final twoDaysAgoSelectedDate = pickedDate.subtract(Duration(days: 2));
      final previousSelectedDate = DateFormat('yyyy-MMM-dd').format(twoDaysAgoSelectedDate);
      final selectedLastDayOfLastMonth = DateTime(pickedDate.year, pickedDate.month, 0);
      final selectedLastDayOfLastMonthString = DateFormat('yyyy-MMM-dd').format(selectedLastDayOfLastMonth);

      emit(state.copyWith(
        pickedDate: pickedDate,
        selectedStartDate: selectedStartDate,
        twoDaysAgoSelectedDate: twoDaysAgoSelectedDate,
        previousSelectedDate: previousSelectedDate,
        selectedLastDayOfLastMonth: selectedLastDayOfLastMonth,
        selectedLastDayOfLastMonthString: selectedLastDayOfLastMonthString,
      ));
    } else {
      final yesterdayDate = startDate.subtract(Duration(days: 1));
      final twoDaysAgo = startDate.subtract(Duration(days: 2));
      final previousDate = DateFormat('yyyy-MMM-dd').format(twoDaysAgo);
      final lastDayOfLastMonth = DateTime(startDate.year, startDate.month, 0);
      final lastDayOfLastMonthString = DateFormat('yyyy-MMM-dd').format(lastDayOfLastMonth);
      final yesterdayDateString = DateFormat('yyyy-MM-dd').format(yesterdayDate);
      final yesterDayDateString = DateFormat('yyyy-MMM-dd').format(yesterdayDate);

      emit(state.copyWith(
        yesterdayDate: yesterdayDate,
        twoDaysAgo: twoDaysAgo,
        previousDate: previousDate,
        lastDayOfLastMonth: lastDayOfLastMonth,
        lastDayOfLastMonthString: lastDayOfLastMonthString,
        yesterdayDateString: yesterdayDateString,
        yesterDayDateString: yesterDayDateString,
      ));
    }
  }

  Future<void> getRegionList(Emitter emit) async {
    List<String>? _listOfRegions = await apiService.getRegionList();
    emit(state.copyWith(regionList: _listOfRegions));
  }

  Future<void> getAreaListByRegionId(Emitter emit, String regionId) async {
    List<String>? _listOfAreas = await apiService.getAreaList(regionId);
    emit(state.copyWith(areaByRegion: _listOfAreas));
  }

  Future<void> getBranchListByAreaCode(Emitter emit, String areaCode) async {
    List<String>? _branchArea = await apiService.getBranchList(areaCode);
    emit(state.copyWith(branchByArea: _branchArea));
  }

  Future<void> getRmListByAreaCode(Emitter emit, String branchCode) async {
    List<String>? _rmBranch = await apiService.getRmList(branchCode);
    emit(state.copyWith(rmByBranch: _rmBranch));
  }

  Future<void> getBankWideDepositActualData(Emitter emit, String date) async {
    List<MyBalanceSheetResponse> depData;
    depData = await apiService.getBankWideDepositActual(date);
    emit(state.copyWith(bankDepActual: depData));
  }

  Future<void> getBankWideLoanActualData(Emitter emit, String date) async {
    List<MyBalanceSheetResponse> loanData = await apiService.getBankWideLoanActual(date);
    emit(state.copyWith(bankLoanActual: loanData));
  }

  Future<void> getRegionActualData(Emitter emit, String date, String region) async {
    List<MyBalanceSheetTypeResponse> regionData = await apiService.getRegionActual(date, region);
    emit(state.copyWith(regionActual: regionData));
  }

  Future<void> getAreaActualData(Emitter emit, String regionCode, String areaCode, String date) async {
    List<MyBalanceSheetTypeResponse> areaData = await apiService.getAreaActual(regionCode, areaCode, date);
    emit(state.copyWith(areaActual: areaData));
  }

  Future<void> getBranchActualData(Emitter emit, String areaCode, String branchCode, String date) async {
    List<MyBalanceSheetTypeResponse> branchData = await apiService.getBranchActual(areaCode, branchCode, date);
    emit(state.copyWith(branchActual: branchData));
  }

  Future<void> getRmData(String rmCode, Emitter emit, String date) async {
    List<MyBalanceSheetRmResponse> rmData = await apiService.getRmAvg(rmCode, date);
    emit(state.copyWith(rmData: rmData));
  }

  Future<void> getBankWideDepositAvgData(Emitter emit, String date) async {
    List<MyBalanceSheetResponse> depAvgData = await apiService.getBankWideDepositAvg(date);
    emit(state.copyWith(bankWideDepAvg: depAvgData));
  }

  Future<void> getBankWideLoanAvgData(Emitter emit, String date) async {
    List<MyBalanceSheetResponse> loanAvgData = await apiService.getBankWideLoanAvg(date);
    emit(state.copyWith(bankWideLoanAvg: loanAvgData));
  }

  Future<void> getRegionAvgData(Emitter emit, String regionCode) async {
    List<MyBalanceSheetTypeResponse> regionAvgData = await apiService.getRegionAvg(regionCode);
    emit(state.copyWith(regionAvg: regionAvgData));
  }

  Future<void> getAreaAvgData(Emitter emit, String regionCode, String areaCode, String date) async {
    List<MyBalanceSheetTypeResponse> areaAvgData = await apiService.getAreaAvg(regionCode, areaCode, date);
    emit(state.copyWith(areaAvg: areaAvgData));
  }

  Future<void> getBranchAvgData(Emitter emit, String areaCode, String branchCode, String date) async {
    List<MyBalanceSheetTypeResponse> branchAvgData = await apiService.getBranchAvg(areaCode, branchCode, date);
    emit(state.copyWith(branchAvg: branchAvgData));
  }

  Future<void> getActualSegmentBankWideData(Emitter emit, String date, String segment) async {
    List<MyBalanceSheetResponse> segmentBankWideData = await apiService.getActualSegmentBankWide(date, segment);
    emit(state.copyWith(segmentBankWide: segmentBankWideData));
  }

  Future<void> getActualSegmentRegionData(Emitter emit, String segment, String date, String regionCode) async {
    List<MyBalanceSheetRmResponse> actualSegmentRegionData = await apiService.getActualSegmentRegion(segment, date, regionCode);
    emit(state.copyWith(actualSegmentRegion: actualSegmentRegionData));
  }

  Future<void> getActualSegmentAreaData(Emitter emit, String regionCode, String segment, String areaCode, String date) async {
    List<MyBalanceSheetRmResponse> actualSegmentAreaData = await apiService.getActualSegmentArea(regionCode, segment, areaCode, date);
    emit(state.copyWith(actualSegmentArea: actualSegmentAreaData));
  }

  Future<void> getActualSegmentBranchData(Emitter emit, String areaCode, String segment, String branchCode, String date) async {
    List<MyBalanceSheetRmResponse> actualSegmentBranchData = await apiService.getActualSegmentBranch(areaCode, segment, branchCode, date);
    emit(state.copyWith(actualSegmentBranch: actualSegmentBranchData));
  }

  Future<void> getAvgSegmentBankWideData(Emitter emit, String date, String segment) async {
    List<MyBalanceSheetResponse> avgSegmentBankWideData = await apiService.getAvgSegmentBankWide(date, segment);
    emit(state.copyWith(avgSegmentBankWide: avgSegmentBankWideData));
  }

  Future<void> getAvgSegmentRegionData(Emitter emit, String segment, String date, String regionCode) async {
    List<MyBalanceSheetRmResponse> avgSegmentRegionData = await apiService.getAvgSegmentRegion(segment, date, regionCode);
    emit(state.copyWith(avgSegmentRegion: avgSegmentRegionData));
  }

  Future<void> getAvgSegmentAreaData(Emitter emit, String regionCode, String segment, String date) async {
    List<MyBalanceSheetRmResponse> avgSegmentAreaData = await apiService.getAvgSegmentArea(regionCode, segment, date);
    emit(state.copyWith(avgSegmentArea: avgSegmentAreaData));
  }

  Future<void> getAvgSegmentBranchData(Emitter emit, String areaCode, String segment, String date) async {
    List<MyBalanceSheetRmResponse> avgSegmentBranchData = await apiService.getAvgSegmentBranch(areaCode, segment, date);
    emit(state.copyWith(avgSegmentBranch: avgSegmentBranchData));
  }
}
