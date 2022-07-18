import 'dart:developer' as dev;

///TODO: Change with loggy
abstract class KLogger {
  static void log(String message, [String name = 'KLOGGER']) {
    dev.log(message, name: name);
  }
}
