extension TinyInt on int {
  bool get convertBoolResult => this != 0;
}

extension NullExtension on Object? {
  bool get isNullOrEmpty =>
      this == null || this == '' || (this is List && (this! as List).isEmpty);
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}
