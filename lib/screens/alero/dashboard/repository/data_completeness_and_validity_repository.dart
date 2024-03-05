import '../../../../models/customer/CompletenessAndValidityData.dart';
import '../../../../network/AleroAPIService.dart';
import 'package:async/async.dart';

class DataCompletenessAndValidityRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  DataCompletenessAndValidityRepository({required this.apiService});

  Future<List<CompletenessAndValidityData?>> getDataCompletenessAndValidity() async {
    return await this._asyncMemoizer.runOnce(() async {
      var data = await apiService.getDataCompletenessAndValidity() as List<CompletenessAndValidityData?>;
      List<CompletenessAndValidityData?> cavData = [];

      if (data.length == 0) {
        cavData.add(CompletenessAndValidityData(
          workflowStatus: '',
          incompleteDataCount: 0,
          invalidDataCount: 0,
        ));
      } else {
        data.forEach((element) {
          cavData.add(element);
        });
      }

      return cavData;
    });
  }
}

class AggregatedCAndVData {
  final String workflowStatus;
  final int incompleteDataCount;
  final int invalidDataCount;

  bool get isEmpty => workflowStatus == "" && incompleteDataCount == 0 && invalidDataCount == 0;

  AggregatedCAndVData({
    required this.workflowStatus,
    required this.incompleteDataCount,
    required this.invalidDataCount,
  });
}
