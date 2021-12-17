import 'package:intl/intl.dart';

class AppNumberFormat {
  final num number;

  AppNumberFormat(this.number);

  String get currency {
    final value = number ?? 0.000;
    final currencyFormat = new NumberFormat("##,##,##0.0#");
    return currencyFormat.format(value.abs());
  }

  String get percent {
    final value = number ?? 0.000;
    final percentFormat = new NumberFormat("##0.##");
    return percentFormat.format(value.abs());
  }
}
