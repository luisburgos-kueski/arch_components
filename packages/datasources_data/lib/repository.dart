import 'package:rxdart/rxdart.dart';

class Merchant {
  const Merchant({required this.name});
  final String name;
}

abstract class MerchantsDataProvider {
  Future<Merchant> getMerchantById(String id);
  //TODO: Change List<Merchant> to api response model ListMerchantsResponse
  Future<List<Merchant>> searchMerchant(String name);
  Future<List<Merchant>> getFeaturedMerchants();
}

class MerchantsRepository implements MerchantsDataProvider {
  BehaviorSubject<List<Merchant>> merchantsObservable =
      BehaviorSubject.seeded([]);

  @override
  Future<List<Merchant>> getFeaturedMerchants() async {
    // TODO: implement getFeaturedMerchants
    throw UnimplementedError();
  }

  @override
  Future<Merchant> getMerchantById(String id) async {
    // TODO: implement getMerchantById
    throw UnimplementedError();
  }

  @override
  Future<List<Merchant>> searchMerchant(String name) async {
    // TODO: implement searchMerchant
    throw UnimplementedError();
  }
}
