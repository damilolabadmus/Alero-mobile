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
      var test = await apiService.getBankTouchPoint();
      List<TouchPointData?> ccData = [];
      List<TouchPointData?>? channels = test as List<TouchPointData?>?;
      String channel = '';
      double averageSpend = 0.0;
      double volumeSpend = 0.0;
      int transactionChannelCount = 0;

      if (channels?.length == 0) {
        ccData.add(TouchPointData(
          channel: '',
          averageSpend: 0.0,
          volumeSpend: 0.0,
          transactionChannelCount: 0,
        ));
      } else {
        channels?.forEach((usage) {
          ccData.add(usage);
        });
      }
      for (int i = 0; i < ccData.length; i++) {
        channel = channel + ccData[i]!.channel!;
        averageSpend = averageSpend + ccData[i]!.averageSpend!;
        volumeSpend = volumeSpend + ccData[i]!.volumeSpend!;
        transactionChannelCount = transactionChannelCount + ccData[i]!.transactionChannelCount!;
      }
      return channels;
    });
  }
}