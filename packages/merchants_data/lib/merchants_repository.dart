import 'package:core/in_memory_store.dart';

import 'merchant_model.dart';

class FakeMerchantsRepository {
  final _merchantListState = InMemoryStore<List<Merchant>?>(null);

  Stream<List<Merchant>?> merchantListStateChanges() =>
      _merchantListState.stream;
  List<Merchant>? get currentMerchantList => _merchantListState.value;

  Future<void> loadMerchantsList() async {
    await Future.delayed(const Duration(seconds: 3));
    _merchantListState.value = [
      Merchant('xiaomi', 'Xiaomi', 'Electronics', true),
      Merchant('doto', 'Tío Doto', 'Electronics', false),
      Merchant('meibi', 'Meibi', 'Others', false),
      Merchant('gaia', 'GAIA Design', 'Home', true),
    ];
  }

  Future<void> wipeMerchantsList() async {
    _merchantListState.value = null;
  }

  void dispose() => _merchantListState.close();
}
