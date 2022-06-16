class MerchantViewData {
  const MerchantViewData({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}

enum HomeStatus { initial, loading, success, failure }
