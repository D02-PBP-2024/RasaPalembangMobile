String printException(Exception e) {
  return e.toString().replaceFirst(RegExp(r'Exception: '), '').trim();
}
