import 'package:flutter/widgets.dart';

import '../logger.dart';

class ConsoleLogger extends Logger {
  @override
  void error(Object e, StackTrace s) {
    debugPrint("${e.toString()}: $s");
  }

  @override
  void log(String message) {
    debugPrint(message);
  }
}