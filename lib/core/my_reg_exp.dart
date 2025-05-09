class MyRegExp {
  /// Don't forget to add anchors [^ and $]
  static final email = RegExp(r'^[a-z0-9]@[a-z]\.[com]$');

  static final password = RegExp(r'''^(?=.*[a-z])(?=.*[A-Z])
    (?=.*\d)[a-zA-Z0-9~!@#$%^&*|]{8,}$''');

  static final rating = RegExp(r'^[0-5.0-5]{3,}$');
}
