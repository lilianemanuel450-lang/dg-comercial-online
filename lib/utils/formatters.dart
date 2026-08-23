import 'package:intl/intl.dart';

/// Formatação de moeda. Trocar para 'AOA'/'Kz' via configuração
/// não altera nenhum outro ponto do app.
class AppFormatters {
  AppFormatters._();

  static const String currencySymbol = 'R\$';

  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: currencySymbol,
    decimalDigits: 2,
  );

  static String price(double value) => _formatter.format(value);
}
