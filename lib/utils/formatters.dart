import 'package:intl/intl.dart';

class Formaters {
  final formatCurrency = NumberFormat.simpleCurrency();
  final formatPercent = NumberFormat.percentPattern();

  static String currencyFormat(data) {
    final formated = NumberFormat.simpleCurrency().format(data);
    var content =
        double.parse(formated.replaceAll("\$", "").replaceAll(",", "")).toStringAsFixed(2);
    var parsed = double.parse(content);

    return NumberFormat.simpleCurrency().format(parsed);
  }

  static String percentageFormat(data) =>
      NumberFormat.percentPattern().format(data);
}
