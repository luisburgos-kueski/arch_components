import 'package:merchants_data/merchant_model.dart';

class MerchantViewData {
  const MerchantViewData({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  static List<MerchantViewData> listFrom(List<Merchant> data) => data
      .map(
        (merchant) => MerchantViewData(
          id: merchant.id,
          name: merchant.name,
        ),
      )
      .toList();
}

enum HomeStatus { initial, loading, success, failure }
