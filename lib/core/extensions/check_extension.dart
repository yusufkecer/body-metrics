extension TinyInt on int {
  bool get boolResult => this != 0;
}

extension NullExtension on Object? {
  bool get isNullOrEmpty => this == null || this == '' || this == <Object?>[];
  bool get isNotNull => this != null;
}
