import 'package:async/async.dart';
import '../../../../network/AleroAPIService.dart';

class LoansTrendRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer<AggregatedLoansTrendData> _memoizer = AsyncMemoizer();

  LoansTrendRepository({required this.apiService});

  Future<AggregatedLoansTrendData> getLoansTrendData() async {
    return _memoizer.runOnce(() async {
      var loans = await apiService.getBankLoans();
      double actualLoans = 0.0;
      double actualLoansChange = 0.0;
      double averageLoans = 0.0;
      double averageLoansChange = 0.0;

      loans.forEach((trend) {
        actualLoans += trend["actualLoans"];
        actualLoansChange += trend["actualLoansChange"];
        averageLoans += trend["averageLoans"];
        averageLoansChange += trend["averageLoansChange"];
      });

      return AggregatedLoansTrendData(
        actualLoans: actualLoans,
        actualLoansChange: actualLoansChange,
        averageLoans: averageLoans,
        averageLoansChange: averageLoansChange,
      );
    });
  }
}

class AggregatedLoansTrendData {
  final double actualLoans;
  final double actualLoansChange;
  final double averageLoans;
  final double averageLoansChange;

  bool get isEmpty => actualLoans == 0 && actualLoansChange == 0 && averageLoans == 0 && averageLoansChange == 0;

  AggregatedLoansTrendData({
    required this.actualLoans,
    required this.actualLoansChange,
    required this.averageLoans,
    required this.averageLoansChange,
  });
}