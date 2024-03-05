// customer_channels_usage_repository.dart
import 'package:alero/models/customer/TouchPointData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:async/async.dart';

class CustomerChannelsUsageRepository {
  final AleroAPIService apiService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  CustomerChannelsUsageRepository({required this.apiService});

  Future<List<TouchPointData?>?> getCustomerChannelsUsage() async {
    return await this._asyncMemoizer.runOnce(() async {
      var result = await apiService.getBankTouchPoint();
      List<TouchPointData?> ccData = [];
      List<TouchPointData?> channels = result as List<TouchPointData?>;

      if (channels.length == 0) {
        ccData.add(TouchPointData(
          channel: '',
          averageSpend: 0.0,
          volumeSpend: 0.0,
          transactionChannelCount: 0,
        ));
      } else {
        channels.forEach((usage) {
          ccData.add(usage);
        });
      }
      return ccData;
    });
  }
}