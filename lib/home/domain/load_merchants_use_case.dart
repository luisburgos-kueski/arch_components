import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

class LoadMerchantsUseCase {
  LoadMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<List<Merchant>> run() async {
    return Future.delayed(const Duration(milliseconds: 2900), () async {
      await repository.loadMerchantsList();
      final list = repository.currentMerchantList ?? [];

      await KAppBehavior.registerEvent(
        OnMerchantListLoaded(
          params: {
            'list_length': list.length,
          },
        ),
      );

      return list;
    });
  }
}

abstract class UseCaseKAppBehaviorEvent implements KDefaultAppBehaviorEvent {
  @override
  DateTime get timestamp => DateTime.now();

  @override
  Map<String, dynamic>? get params => null;
}

class OnMerchantListLoaded extends UseCaseKAppBehaviorEvent {
  @override
  final String name = 'on_merchant_list_loaded';

  @override
  final Map<String, dynamic>? params;

  OnMerchantListLoaded({this.params});
}
