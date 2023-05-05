extension StringExt on String {
  int toInt() => int.tryParse(this) ?? 0;
  bool contain(Pattern other, {bool ignoreCase = false}) =>
      ignoreCase ? toLowerCase().contains(other) : contains(other);
}
