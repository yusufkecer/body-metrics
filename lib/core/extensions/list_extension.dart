extension ListExtension on List<Map<int, String>> {
  void get years {
    var key = 0;
    for (var i = 2024; i <= DateTime.now().year; i++) {
      final value = i.toString().substring(2);
      add({key: value});
      key += 2;
    }
  }
}
