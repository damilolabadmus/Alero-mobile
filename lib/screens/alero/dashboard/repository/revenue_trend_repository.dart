import '../../../../network/AleroAPIService.dart';
import 'package:async/async.dart';

class RevenueTrendRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  RevenueTrendRepository({required this.apiService});

  Future<AggregateRevenueTrendData> getBankRevenueData() async {
    return await this._asyncMemoizer.runOnce(() async {
      var revenue = await apiService.getBankRevenue();
      double totalYtdRevenue = 0.0;
      double totalLoansRevenue = 0.0;
      double totalDepositsRevenue = 0.0;
      double totalCommFeesRevenue = 0.0;

      revenue.forEach((revenueTrend) {
        totalYtdRevenue += revenueTrend["ytdRevenue"];
        totalLoansRevenue += revenueTrend["loansRevenue"];
        totalDepositsRevenue += revenueTrend["depositsRevenue"];
        totalCommFeesRevenue += revenueTrend["commFeesRevenue"];
      });
      
      return AggregateRevenueTrendData(
        ytdRevenue: totalYtdRevenue,
        loansRevenue: totalLoansRevenue,
        depositsRevenue: totalDepositsRevenue,
        commFeesRevenue: totalCommFeesRevenue,
      );
    });
  }
}

class AggregateRevenueTrendData {
  final double ytdRevenue;
  final double loansRevenue;
  final double depositsRevenue;
  final double commFeesRevenue;

  AggregateRevenueTrendData({
    required this.ytdRevenue,
    required this.loansRevenue,
    required this.depositsRevenue,
    required this.commFeesRevenue,
  });
}
