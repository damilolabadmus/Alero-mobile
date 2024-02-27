import '../../../../models/customer/BankRevenueData.dart';
import '../../../../network/AleroAPIService.dart';
import 'package:async/async.dart';

class BankRevenueRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  BankRevenueRepository({required this.apiService});

  Future<BankRevenueData> getBankRevenueData() async {
    return await this._asyncMemoizer.runOnce(() async {
      var revenue = await apiService.getBankRevenue();
      List<BankRevenueData> rtData = [];
      if (revenue.length == 0) {
        rtData.add(BankRevenueData(
          ytdRevenue: 0.0,
          loansRevenue: 0.0,
          depositsRevenue: 0,
          commFeesRevenue: 0,
        ));
      } else {
        revenue.forEach((revenueTrend) {
          rtData.add(BankRevenueData(
            ytdRevenue: revenueTrend["ytdRevenue"],
            loansRevenue: revenueTrend["loansRevenue"],
            depositsRevenue: revenueTrend["depositsRevenue"],
            commFeesRevenue: revenueTrend["commFeesRevenue"],
          ));
        });
      }
      return _calculateTotal(rtData);
    });
  }

  BankRevenueData _calculateTotal(List<BankRevenueData> data) {
    double totalYtdRevenue = 0.0;
    double totalLoansRevenue = 0.0;
    double totalDepositsRevenue = 0.0;
    double totalCommFeesRevenue = 0.0;

    for (var item in data) {
      totalYtdRevenue += item.ytdRevenue!;
      totalLoansRevenue += item.loansRevenue!;
      totalDepositsRevenue += item.depositsRevenue!;
      totalCommFeesRevenue += item.commFeesRevenue!;
    }

    return BankRevenueData(
      ytdRevenue: totalYtdRevenue,
      loansRevenue: totalLoansRevenue,
      depositsRevenue: totalDepositsRevenue,
      commFeesRevenue: totalCommFeesRevenue,
    );
  }
}
