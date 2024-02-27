import '../../../../network/AleroAPIService.dart';
import 'package:async/async.dart';

class BankPerformanceRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer asyncMemoizer = AsyncMemoizer();

  BankPerformanceRepository({required this.apiService});

  Future<BankPerformanceTotals> getBankPerformanceData() async {
    var bankPerformance = await this.asyncMemoizer.runOnce(() async {
      return await apiService.getBankingPerformance();
    });

    double totalCustomers = 0.0;
    double ytdCustomers = 0.0;
    double totalAccounts = 0.0;
    double ytdAccounts = 0.0;

    if (bankPerformance.length != 0) {
      bankPerformance.forEach((performance) {
        totalCustomers += performance["customerCount"];
        ytdCustomers += performance["ytdCustomerCount"];
        totalAccounts += performance["accountCount"];
        ytdAccounts += performance["ytdAccountCount"];
      });
    }

    return BankPerformanceTotals(
      totalCustomers: totalCustomers,
      ytdCustomers: ytdCustomers,
      totalAccounts: totalAccounts,
      ytdAccounts: ytdAccounts,
    );
  }
}

class BankPerformanceTotals {
  final double totalCustomers;
  final double ytdCustomers;
  final double totalAccounts;
  final double ytdAccounts;

  BankPerformanceTotals({
    required this.totalCustomers,
    required this.ytdCustomers,
    required this.totalAccounts,
    required this.ytdAccounts,
  });
}
