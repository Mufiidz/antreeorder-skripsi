extension StringExt on String {
  int toInt() => int.tryParse(this) ?? 0;
  bool contain(Pattern other, {bool ignoreCase = false}) =>
      ignoreCase ? toLowerCase().contains(other) : contains(other);
  bool get isUrl {
    final RegExp _urlRegex = RegExp(
        r"^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$");
    return _urlRegex.hasMatch(this);
  }
}
