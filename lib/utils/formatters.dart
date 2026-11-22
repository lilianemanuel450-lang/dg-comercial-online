import 'package:intl/intl.dart';

/// Formatação de moeda em Kwanza (Kz), sem casas decimais.
class AppFormatters {
  AppFormatters._();

  static const String currencySymbol = 'Kz';

  static final NumberFormat _formatter = NumberFormat('#,##0', 'pt_BR');

  static String price(double value) => '$currencySymbol ${_formatter.format(value)}';
}
