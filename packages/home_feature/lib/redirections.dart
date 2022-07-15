///TODO: Evaluate remove
abstract class IRedirections {}

///TODO: Change string attrs for callbacks to remove Get navigation coupling.
class HomeRedirections implements IRedirections {
  HomeRedirections({
    required this.goToMerchantDetail,
    required this.goToSettings,
    required this.goToSecondSettings,
    required this.appBehaviorPath,
    required this.logBehaviorPath,
  });

  final String appBehaviorPath;
  final String logBehaviorPath;

  final Function(String merchantId) goToMerchantDetail;
  final Function() goToSettings;

  // TODO: Rename. For now it refers to a second option in the app bar.
  final Function() goToSecondSettings;
}
