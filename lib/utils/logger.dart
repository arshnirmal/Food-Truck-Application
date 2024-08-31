import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
  ),
);

void logD(String message) {
  logger.d(message);
}

void logE(String message) {
  logger.e(message);
}

void logI(String message) {
  logger.i(message);
}

void logT(String message) {
  logger.t(message);
}

void logW(String message) {
  logger.w(message);
}
