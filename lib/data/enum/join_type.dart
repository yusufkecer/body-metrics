enum JoinType {
  inner,
  left,
  right;

  String get type {
    switch (this) {
      case JoinType.inner:
        return 'INNER JOIN';
      case JoinType.left:
        return 'LEFT JOIN';
      case JoinType.right:
        return 'RIGHT JOIN';
    }
  }
}
