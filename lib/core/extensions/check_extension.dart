extension TinyInt on int {
  bool get convertBoolResult => this != 0;
}

extension NullExtension on Object? {
  bool get isNullOrEmpty => this == null || this == '' || this == <Object?>[];
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}
