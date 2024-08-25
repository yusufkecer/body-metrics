extension TinyInt on int {
  bool get boolResult => this != 0;
}

extension NullExtebsion on Object? {
  bool get isNullOrEmpty => this == null || this == '';
  bool get isNotNull => this != null;
}
