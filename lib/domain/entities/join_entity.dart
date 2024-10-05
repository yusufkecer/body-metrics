class JoinEntity {
  const JoinEntity({
    this.table,
    this.currentKey,
    this.joinKey,
    this.type,
  });

  final String? table;
  final String? currentKey;
  final String? joinKey;
  final String? type;
}
