import 'package:logger/logger.dart';

/// Creates a new instance of logger for each class.
Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}

/// Custom log printer to print logs.
///
///`logger.v("Verbose log");`
///
///`logger.d("Debug log");`
///
///`logger.i("Info log");`
///
///`logger.w("Warning log");`
///
///`logger.e("Error log");`
///
///`logger.wtf("What a terrible failure log");`
class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level] ?? AnsiColor.none();
    final emoji = PrettyPrinter.levelEmojis[event.level] ?? '';

    return [
      color(
        '$emoji ${DateTime.now().toIso8601String()}: $className - ${event.message}',
      ),
    ];
  }
}
