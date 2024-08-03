abstract interface class BaseModel<T> {
  BaseModel.fromJson();
  Map<String, dynamic> toJson();
}

abstract interface class IdModel {
  int? get id;
}
