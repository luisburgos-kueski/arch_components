import 'dart:developer' as dev;

abstract class KLogger {
  static void log(String message, [String name = 'KLOGGER']) {
    dev.log(message, name: name);
  }
}

/// KAppBehaviorEvent { name, timestamp, params }
///
/// Merchant Item Tapped
/// Screen  - opened, closed
/// Login, SignUp
///
///
/// implements ---
/// Merchant Item Tapped implements
///
/// KScreenEvent implements KAppEvent
/// registerEvent Custom - setCurrentScreen (route, screenName)
///
/// Analytics ->
/// if (event is KScreen) set current
/// else registerEvent
///
/// Data Sources
/// registerEvent
///
/// init (route observer, observers events)
///
/// notifier () event observer -> event
///
/// Observer Events ->
/// Sources -> bloc, route observer, widget -> merchants tapped
///
