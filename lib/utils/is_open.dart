import 'package:flutter/material.dart';

// Fungsi untuk menentukan apakah restoran buka berdasarkan jam operasional (termasuk yang melewati tengah malam)
bool isCurrentlyOpen(String jamBuka, String jamTutup) {
  try {
    final now = TimeOfDay.now();
    final buka = _timeOfDayFromString(jamBuka);
    final tutup = _timeOfDayFromString(jamTutup);

    if (buka == null || tutup == null) return false;

    // Konversi TimeOfDay ke menit sejak tengah malam
    final nowMinutes = now.hour * 60 + now.minute;
    final bukaMinutes = buka.hour * 60 + buka.minute;
    final tutupMinutes = tutup.hour * 60 + tutup.minute;

    if (bukaMinutes < tutupMinutes) {
      // Restoran buka dan tutup di hari yang sama
      return bukaMinutes <= nowMinutes && nowMinutes <= tutupMinutes;
    } else {
      // Restoran buka melewati tengah malam
      return nowMinutes >= bukaMinutes || nowMinutes <= tutupMinutes;
    }
  } catch (e) {
    return false;
  }
}

// Fungsi untuk mengonversi string jam ke TimeOfDay
TimeOfDay? _timeOfDayFromString(String time) {
  try {
    final parts = time.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  } catch (e) {
    return null;
  }
}
