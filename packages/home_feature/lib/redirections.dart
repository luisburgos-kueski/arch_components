///TODO: Evaluate remove
abstract class IRedirections {}

///TODO: Change string attrs for callbacks to remove Get navigation coupling.
class HomeRedirections implements IRedirections {
  HomeRedirections({
    required this.merchantDetailRoute,
    required this.settingsRoute,
  });

  final String merchantDetailRoute;
  final String settingsRoute;

  String buildMerchantDetailRoute(String merchantId) =>
      '$merchantDetailRoute$merchantId';

  String buildSettingsRoute() => settingsRoute;
}
