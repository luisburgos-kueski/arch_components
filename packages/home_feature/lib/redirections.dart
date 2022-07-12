///TODO: Evaluate remove
abstract class IRedirections {}

///TODO: Change string attrs for callbacks to remove Get navigation coupling.
class HomeRedirections implements IRedirections {
  HomeRedirections({
    required this.goToMerchantDetail,
    required this.goToSettings,
  });

  final Function(String merchantId) goToMerchantDetail;
  final Function() goToSettings;
}
