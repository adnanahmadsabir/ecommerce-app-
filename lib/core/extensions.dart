import 'dart:core';

extension StringExtension on String {
  String fixed({int maxLength = 12, String replacement = '...'}) {
    return length > maxLength
        ? replaceRange(maxLength, null, replacement)
        : this;
  }
}

extension Int on int {
  int parse(String source) {
    return int.parse(source);
  }
}
