import 'package:intl/intl.dart';

class FormatHarga {
  static String format(int amount) {
    var format = NumberFormat('Rp#,##0', 'id_ID');
    return format.format(amount);
  }
}
