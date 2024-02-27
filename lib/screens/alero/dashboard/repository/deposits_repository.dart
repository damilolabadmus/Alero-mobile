import 'package:async/async.dart';
import '../../../../network/AleroAPIService.dart';


class DepositsTrendRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer<AggregatedDepositsTrendData> _memoizer = AsyncMemoizer();

  DepositsTrendRepository({required this.apiService});

  Future<AggregatedDepositsTrendData> getDepositsTrendData() async {
      return _memoizer.runOnce(() async {
        var deposits = await apiService.getBankDeposits();
        double actualDeposits = 0.0;
        double actualDepositsChange = 0.0;
        double averageDeposits = 0.0;
        double averageDepositsChange = 0.0;

        deposits.forEach((trend) {
          actualDeposits += trend["actualDeposits"];
          actualDepositsChange += trend["actualDepositsChange"];
          averageDeposits += trend["averageDeposits"];
          averageDepositsChange += trend["averageDepositsChange"];
        });

        return AggregatedDepositsTrendData(
          actualDeposits: actualDeposits,
          actualDepositsChange: actualDepositsChange,
          averageDeposits: averageDeposits,
          averageDepositsChange: averageDepositsChange,
        );
      });
    }
  }

class AggregatedDepositsTrendData {
  final double actualDeposits;
  final double actualDepositsChange;
  final double averageDeposits;
  final double averageDepositsChange;

  bool get isEmpty => actualDeposits == 0 && actualDepositsChange == 0 && averageDeposits == 0 && averageDepositsChange == 0;

  AggregatedDepositsTrendData({
    required this.actualDeposits,
    required this.actualDepositsChange,
    required this.averageDeposits,
    required this.averageDepositsChange,
  });
}
