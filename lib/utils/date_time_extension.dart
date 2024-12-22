extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 365).floor() >= 1) {
      final years = (difference.inDays / 365).floor();
      return '$years tahun yang lalu';
    } else if ((difference.inDays / 30).floor() >= 1) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan yang lalu';
    } else if ((difference.inDays / 7).floor() >= 1) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks minggu yang lalu';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} detik yang lalu';
    } else {
      return 'Baru saja';
    }
  }
}
