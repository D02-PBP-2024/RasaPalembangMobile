extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 365).floor() >= 1) {
      final years = (difference.inDays / 365).floor();
      return (years == 1) ? 'Tahun lalu' : '$years tahun lalu';
    } else if ((difference.inDays / 30).floor() >= 1) {
      final months = (difference.inDays / 30).floor();
      return (months == 1) ? 'Bulan lalu' : '$months bulan yang lalu';
    } else if ((difference.inDays / 7).floor() >= 1) {
      final weeks = (difference.inDays / 7).floor();
      return (weeks == 1) ? 'Minggu lalu' : '$weeks minggu lalu';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'Kemarin' : 'Sehari yang lalu';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'Satu jam lalu' : 'Sekitar sejam lalu';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'Satu menit lalu' : 'Baru saja';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} detik lalu';
    } else {
      return 'Baru saja';
    }
  }
}
