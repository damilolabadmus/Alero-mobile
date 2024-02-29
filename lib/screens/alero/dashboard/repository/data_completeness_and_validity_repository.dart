import '../../../../models/customer/CompletenessAndValidityData.dart';
import '../../../../network/AleroAPIService.dart';
import 'package:async/async.dart';

class DataCompletenessAndValidityRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  DataCompletenessAndValidityRepository({required this.apiService});

  Future<AggregatedCAndVData> getDataCompletenessAndValidity() async {
    return await this._asyncMemoizer.runOnce(() async {
      var data = await apiService.getDataCompletenessAndValidity() as List<CompletenessAndValidityData?>?;
      String workflowStatus = '';
      int incompleteDataCount = 0;
      int invalidDataCount = 0;

      data?.forEach((element) {
        workflowStatus += element!.workflowStatus!;
        incompleteDataCount += element.incompleteDataCount!;
        invalidDataCount += element.invalidDataCount!;
      });

      return AggregatedCAndVData(
        workflowStatus: workflowStatus,
        incompleteDataCount: incompleteDataCount,
        invalidDataCount: invalidDataCount,
      );
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
